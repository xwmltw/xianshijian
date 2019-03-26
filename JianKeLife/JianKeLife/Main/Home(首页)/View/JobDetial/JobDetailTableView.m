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
        return AdaptationWidth(300);
    }
    return AdaptationWidth(100);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"JobDetialIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = BackgroundColor;
    }
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
            
            UIView *view = [[UIView alloc]init];
            view.backgroundColor  = RedColor;
            [cell.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.mas_equalTo(cell);
                make.height.mas_equalTo(AdaptationWidth(50));
            }];
            
            UILabel *cellDetail = [[UILabel alloc]init];
            cellDetail.text = @"返佣 ￥";
            [cellDetail setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
            [cellDetail setTextColor:[UIColor whiteColor]];
            [view addSubview:cellDetail];
            [cellDetail mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(view).offset(AdaptationWidth(26));
                make.centerY.mas_equalTo(view);
            }];
            
            UILabel *detailMoney = [[UILabel alloc]init];
            detailMoney.text =[NSString stringWithFormat:@"%.2f",[self.jobDetailViewModel.productModel.productSalary doubleValue]] ;
            [detailMoney setFont:[UIFont fontWithName:@"PingFangSC-Bold" size:AdaptationWidth(30)]];
            [detailMoney setTextColor:[UIColor whiteColor]];
            [view addSubview:detailMoney];
            [detailMoney mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(cellDetail.mas_right).offset(AdaptationWidth(3));
                make.centerY.mas_equalTo(view);
            }];
            
            UIButton *getNum = [[UIButton alloc]init];
            getNum.enabled = NO;
            [getNum setBackgroundImage:[UIImage imageNamed:@"iocn_detail_hearbg"] forState:UIControlStateNormal];
            [getNum setTitle:[NSString stringWithFormat:@"已领取%@",self.jobDetailViewModel.productModel.prodApplyCount] forState:UIControlStateNormal];
            [getNum setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [getNum.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(12)]];
            [view addSubview:getNum];
            [getNum mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.top.bottom.mas_equalTo(view);
                make.width.mas_equalTo(AdaptationWidth(113));
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
            
            UILabel *detailMoney = [[UILabel alloc]init];
            detailMoney.numberOfLines = 2;
            detailMoney.text = self.jobDetailViewModel.productModel.productTitle;
            [detailMoney setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(18)]];
            [detailMoney setTextColor:LabelMainColor];
            [view addSubview:detailMoney];
            [detailMoney mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(view).offset(AdaptationWidth(16));
                make.right.mas_equalTo(view).offset(AdaptationWidth(-16));
                make.top.mas_equalTo(view).offset(AdaptationWidth(12));
                
            }];
            
            UIImageView *cellImage = [[UIImageView alloc]init];
            cellImage.image = [UIImage imageNamed:@"icon_jobDetail_time"];
            [view addSubview:cellImage];
            [cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(view).offset(AdaptationWidth(16));
                make.bottom.mas_equalTo(view).offset(AdaptationWidth(-12));
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
            [title setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(16)]];
            [title setTextColor:LabelMainColor];
            [view addSubview:title];
            [title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(view).offset(AdaptationWidth(16));
                make.right.mas_equalTo(view).offset(AdaptationWidth(-16));
                make.top.mas_equalTo(view).offset(AdaptationWidth(12));
                
            }];
            
            UILabel *detial = [[UILabel alloc]init];
            detial.numberOfLines = 0;
            detial.text = self.jobDetailViewModel.productModel.productGroupOrientedDesc;
            [detial setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(14)]];
            [detial setTextColor:LabelMainColor];
            [view addSubview:detial];
            [detial mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(view).offset(AdaptationWidth(16));
                make.right.mas_equalTo(view).offset(AdaptationWidth(-16));
                make.top.mas_equalTo(title.mas_bottom).offset(AdaptationWidth(6));
                make.bottom.mas_equalTo(view).offset(AdaptationWidth(-12));
                
            }];
           
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
            [title setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(16)]];
            [title setTextColor:LabelMainColor];
            [view addSubview:title];
            [title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(view);
                make.top.mas_equalTo(view).offset(AdaptationWidth(12));
                
            }];
            
            UILabel *detial = [[UILabel alloc]init];
            detial.numberOfLines = 0;
//            detial.text = self.jobDetailViewModel.productModel.productDesc;
            [detial setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(14)]];
            [detial setTextColor:LabelMainColor];
            [view addSubview:detial];
            [detial mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(view).offset(AdaptationWidth(16));
                make.right.mas_equalTo(view).offset(AdaptationWidth(-16));
                make.top.mas_equalTo(title.mas_bottom).offset(AdaptationWidth(6));
                make.bottom.mas_equalTo(view).offset(AdaptationWidth(-12));
                
            }];
            
            NSMutableAttributedString * artical_main_text = [[NSMutableAttributedString alloc] initWithData:[[NSString stringWithFormat:@"%@",self.jobDetailViewModel.productModel.productDesc] dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
            detial.attributedText = artical_main_text;
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
        
        _sdcycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"iamge_rule"]];
        _sdcycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
        _sdcycleScrollView.autoScrollTimeInterval = 3;
        _sdcycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _sdcycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _sdcycleScrollView.pageDotColor = XColorWithRBBA(255, 255, 255, 0.4);
        
    }
    return _sdcycleScrollView;
}
@end
