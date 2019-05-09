//
//  JobDetailTableView.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/20.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "JobDetailTableView.h"
#import "SDCycleScrollView.h"


@interface JobDetailTableView ()<UITableViewDelegate ,UITableViewDataSource,SDCycleScrollViewDelegate>
@property (nonatomic ,strong) SDCycleScrollView *sdcycleScrollView;
@end

@implementation JobDetailTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.backgroundColor = BackgroundColor;
        self.delegate = self;
        self.dataSource = self;
        self.estimatedSectionHeaderHeight = 0;
        BLOCKSELF
        [self.jobDetailViewModel setProductDetailBlock:^(id result) {
            [blockSelf reloadData];
        }];
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return AdaptationWidth(250);
    }
    if (indexPath.row == 1) {
        return AdaptationWidth(self.jobDetailViewModel.productModel.cell3Width);
    }
    if (indexPath.row == 2) {
        
        return AdaptationWidth(self.jobDetailViewModel.productModel.cell2Width) ;
    }
    
    if (indexPath.row == 3) {
//        MyLog(@"%ld",(long)self.jobDetailViewModel.productModel.cellWidth);

        return AdaptationWidth(self.jobDetailViewModel.productModel.cellWidth) ;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"JobDetialIdentifier";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
//    if (!cell) {
       UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = BackgroundColor;
//    }
    switch (indexPath.row) {
        case 0:
        {   
            
            [cell.contentView addSubview:self.sdcycleScrollView];
            _sdcycleScrollView.imageURLStringsGroup = self.jobDetailViewModel.productModel.productMainPicUrl;
            if (self.jobDetailViewModel.productModel.productMainPicUrl.count == 1) {
                _sdcycleScrollView.autoScroll = NO;
            }
            [self.sdcycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.mas_equalTo(cell);
                make.height.mas_equalTo(AdaptationWidth(250));
            }];
            
            
        }
            break;
        case 1:
        {
            UIView *view = [[UIView alloc]init];
            [view setCornerValue:4];
            view.backgroundColor  = [UIColor whiteColor];
            [cell.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(cell).offset(10);
                make.right.mas_equalTo(cell).offset(-10);
                make.top.mas_equalTo(cell).offset(4);
                make.bottom.mas_equalTo(cell).offset(-4);
            }];
            
            UILabel *detailtitle = [[UILabel alloc]init];
            detailtitle.numberOfLines = 2;
            detailtitle.text = self.jobDetailViewModel.productModel.productTitle;
            [detailtitle setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(18)]];
            [detailtitle setTextColor:LabelMainColor];
            [view addSubview:detailtitle];
            [detailtitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(view).offset(AdaptationWidth(16));
                make.right.mas_equalTo(view).offset(AdaptationWidth(-16));
                make.top.mas_equalTo(view).offset(AdaptationWidth(12));
                
            }];
            
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
            NSDictionary * attributes = @{
                                          NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(16)],
                                          NSParagraphStyleAttributeName: paragraphStyle
                                          };
            CGSize textRect = CGSizeMake(AdaptationWidth(235), MAXFLOAT);
            CGFloat textHeight = [detailtitle.text boundingRectWithSize: textRect
                                                            options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                         attributes:attributes
                                                            context:nil].size.height;
            self.jobDetailViewModel.productModel.cell3Width =  AdaptationWidth(textHeight + 103) ;
            
            
            
            UILabel *cellDetail = [[UILabel alloc]init];
            cellDetail.text = @"返佣 ￥";
            [cellDetail setFont:[UIFont systemFontOfSize:AdaptationWidth(12)]];
            [cellDetail setTextColor:RedColor];
            [view addSubview:cellDetail];
            [cellDetail mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(view).offset(AdaptationWidth(26));
                make.top.mas_equalTo(detailtitle.mas_bottom).offset(AdaptationWidth(13));
            }];
            
            UILabel *detailMoney = [[UILabel alloc]init];
            detailMoney.text =[NSString stringWithFormat:@"%.2f",[self.jobDetailViewModel.productModel.productSalary doubleValue]/100] ;
            [detailMoney setFont:[UIFont fontWithName:@"PingFangSC-Semibold" size:AdaptationWidth(22)]];
            [detailMoney setTextColor:RedColor];
            [view addSubview:detailMoney];
            [detailMoney mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(cellDetail.mas_right).offset(AdaptationWidth(1));
                make.top.mas_equalTo(detailtitle.mas_bottom).offset(AdaptationWidth(3));
            }];
            
            UILabel *shareLab = [[UILabel alloc]init];
            [shareLab setCornerValue:2];
            shareLab.text = [NSString stringWithFormat:@"分享赚￥%.2f",[self.jobDetailViewModel.productModel.productShareSalary doubleValue]/100];
            shareLab.backgroundColor = XColorWithRGB(255, 227, 227);
            [shareLab setFont:[UIFont systemFontOfSize:AdaptationWidth(12)]];
            [shareLab setTextColor:RedColor];
            [view addSubview:shareLab];
            [shareLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(detailMoney.mas_right).offset(AdaptationWidth(15));
                make.bottom.mas_equalTo(cellDetail);
            }];
            
            
            UIImageView *cellImage = [[UIImageView alloc]init];
            cellImage.image = [UIImage imageNamed:@"icon_jobDetail_time"];
            [view addSubview:cellImage];
            [cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(view).offset(AdaptationWidth(16));
                make.bottom.mas_equalTo(view).offset(AdaptationWidth(-10));
            }];
            
            UILabel *detailTime = [[UILabel alloc]init];
            detailTime.text = [NSString stringWithFormat:@"领取截止至 %@",self.jobDetailViewModel.productModel.productDeadTimeDesc];
            [detailTime setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(12)]];
            [detailTime setTextColor:LabelAssistantColor];
            [view addSubview:detailTime];
            [detailTime mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(cellImage.mas_right).offset(AdaptationWidth(3));
                make.centerY.mas_equalTo(cellImage);
 
            }];
            
            UILabel *numLab = [[UILabel alloc]init];
            numLab.text = [NSString stringWithFormat:@"已领取%@",self.jobDetailViewModel.productModel.prodApplyCount];
            [numLab setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(12)]];
            [numLab setTextColor:LabelAssistantColor];
            [view addSubview:numLab];
            [numLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(view).offset(AdaptationWidth(-16));
                make.centerY.mas_equalTo(cellImage);
                
            }];

        }
            break;
        case 2:
        {
            UIView *view = [[UIView alloc]init];
            [view setCornerValue:4];
            view.backgroundColor  = [UIColor whiteColor];
            [cell.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(cell).offset(10);
                make.right.mas_equalTo(cell).offset(-10);
                make.top.mas_equalTo(cell).offset(4);
                make.bottom.mas_equalTo(cell).offset(-4);
            }];
            
            UILabel *title = [[UILabel alloc]init];
            title.text = @"面向群体";
            [title setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(18)]];
            [title setTextColor:LabelMainColor];
            [view addSubview:title];
            [title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(view).offset(AdaptationWidth(16));
                make.right.mas_equalTo(view).offset(AdaptationWidth(-16));
                make.top.mas_equalTo(view).offset(AdaptationWidth(12));
                
            }];
            
            UILabel *detial1 = [[UILabel alloc]init];
            detial1.numberOfLines = 0;
            detial1.text = self.jobDetailViewModel.productModel.productGroupOrientedDesc;
            [detial1 setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(16)]];
            [detial1 setTextColor:LabelMainColor];
            [view addSubview:detial1];
            [detial1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(view).offset(AdaptationWidth(16));
                make.right.mas_equalTo(view).offset(AdaptationWidth(-16));
                make.top.mas_equalTo(title.mas_bottom).offset(AdaptationWidth(6));
                make.bottom.mas_equalTo(view).offset(AdaptationWidth(-12));
                
            }];
//            NSString *str = [NSString stringWithFormat:@"<head><style>img{width:%f !important;height:auto}</style></head>%@",self.Sw,self.jobDetailViewModel.productModel.productGroupOrientedDesc];
//            NSMutableAttributedString * artical_main_text = [[NSMutableAttributedString alloc] initWithData:[[NSString stringWithFormat:@"%@",str] dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
//            detial1.attributedText = artical_main_text;
            
//            CGSize detal = [detial1.text]
//            CGSize detailSize = [detial1.text boundingRectWithSize:CGSizeMake(AdaptationWidth(235), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
//                        CGSize detailSize = [detial1.text boundingRectWithSize:CGSizeMake(AdaptationWidth(235), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:nil context:nil].size;
//            self.jobDetailViewModel.productModel.cell2Width =  detailSize.height + 70;
            
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
            NSDictionary * attributes = @{
                                          NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(16)],
                                          NSParagraphStyleAttributeName: paragraphStyle
                                          };
            CGSize textRect = CGSizeMake(AdaptationWidth(235), MAXFLOAT);
            CGFloat textHeight = [detial1.text boundingRectWithSize: textRect
                                                   options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                attributes:attributes
                                                   context:nil].size.height;
            self.jobDetailViewModel.productModel.cell2Width =  AdaptationWidth(textHeight + 70) ;
        }
            break;
        case 3:
        {
            UIView *view = [[UIView alloc]init];
            [view setCornerValue:4];
            view.backgroundColor  = [UIColor whiteColor];
            [cell.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(cell).offset(10);
                make.right.mas_equalTo(cell).offset(-10);
                make.top.mas_equalTo(cell).offset(4);
                make.bottom.mas_equalTo(cell).offset(-4);
            }];
            
            UILabel *title = [[UILabel alloc]init];
            title.text = @"产品详情";
            [title setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(18)]];
            [title setTextColor:LabelMainColor];
            [view addSubview:title];
            [title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(view);
                make.top.mas_equalTo(view).offset(AdaptationWidth(12));
                
            }];
            
            UILabel *detial = [[UILabel alloc]init];
            detial.numberOfLines = 0;
//            detial.text = self.jobDetailViewModel.productModel.productDesc;
            
            [detial setTextColor:LabelMainColor];
            [view addSubview:detial];
            [detial mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(view).offset(AdaptationWidth(16));
                make.right.mas_equalTo(view).offset(AdaptationWidth(-16));
                make.top.mas_equalTo(title.mas_bottom).offset(AdaptationWidth(6));

            }];
            
            NSString *str = [NSString stringWithFormat:@"<head><style>img{max-width:%f !important;height:auto}p{font-size: %fpx !important;}</style></head>%@",self.Sw,AdaptationWidth(16),self.jobDetailViewModel.productModel.productDesc];
            NSMutableAttributedString * artical_main_text = [[NSMutableAttributedString alloc] initWithData:[[NSString stringWithFormat:@"%@",str] dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
            detial.attributedText = artical_main_text;
            [detial setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(16)]];
            CGSize detailSize = [detial.attributedText boundingRectWithSize:CGSizeMake(AdaptationWidth(235), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
//            CGSize detailSize = [detial.text boundingRectWithSize:CGSizeMake(AdaptationWidth(235), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:nil context:nil].size;
            self.jobDetailViewModel.productModel.cellWidth =  detailSize.height + 70;
            
        }
            break;
            
            
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    XBlockExec(self.jobDetailCellBlock ,indexPath.row);
    
}
- (JobDetailViewModel *)jobDetailViewModel{
    if (!_jobDetailViewModel) {
        _jobDetailViewModel = [[JobDetailViewModel alloc]init];
        
    }
    return _jobDetailViewModel;
}
- (SDCycleScrollView *)sdcycleScrollView{
    if (!_sdcycleScrollView) {
        
        _sdcycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage createImageWithColor:[UIColor whiteColor] ]];
        _sdcycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
        _sdcycleScrollView.autoScrollTimeInterval = 3;
        _sdcycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _sdcycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _sdcycleScrollView.pageDotColor = XColorWithRBBA(255, 255, 255, 0.4);
        _sdcycleScrollView.backgroundColor = [UIColor whiteColor];
    }
    return _sdcycleScrollView;
}
@end
