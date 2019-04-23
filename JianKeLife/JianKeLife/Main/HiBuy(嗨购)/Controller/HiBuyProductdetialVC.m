//
//  HiBuyProductdetialVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/4/23.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "HiBuyProductdetialVC.h"
#import "SDCycleScrollView.h"
#import "HiBuyDetailModel.h"
#import "BaseWebView.h"
#import "BaseWebVC.h"
#import "HiBuyShareInfoModel.h"
@interface HiBuyProductdetialVC ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,WKUIDelegate>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) SDCycleScrollView *sdcycleScrollView;
@property (nonatomic ,strong) HiBuyDetailModel *hiBuyDetailModel;
@property (nonatomic ,strong) HiBuyShareInfoModel *hiBuyShareInfoModel;
@end

@implementation HiBuyProductdetialVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    [self.tableView.jobDetailViewModel requestDetialData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedSectionHeaderHeight = 0;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(AdaptationWidth(58));
    }];
    
    
    UIButton *balckBtn = [[UIButton alloc]init];
    balckBtn.tag = 5021;
    [balckBtn setCornerValue:AdaptationWidth(20)];
    [balckBtn setBackgroundImage:[UIImage createImageWithColor:XColorWithRBBA(255, 255, 255, 0.13)] forState:UIControlStateNormal];
    [balckBtn setImage:[UIImage imageNamed:@"icon_back_gray"] forState:UIControlStateNormal];
    [balckBtn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:balckBtn];
    [balckBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(30);
        make.left.mas_equalTo(self.view).offset(16);
        make.height.width.mas_equalTo(AdaptationWidth(40));
    }];
    
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(AdaptationWidth(58));
    }];
    
    UIButton *shareBtn = [[UIButton alloc]init];
    shareBtn.tag = 5022;
    [shareBtn setCornerValue:AdaptationWidth(4)];
    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [shareBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(17)]];
    shareBtn.backgroundColor = blueColor;
    [shareBtn setImage:[UIImage imageNamed:@"icon_laxin_share"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:shareBtn];
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView).offset(AdaptationWidth(7));
        make.left.mas_equalTo(bottomView).offset(AdaptationWidth(10));
        make.bottom.mas_equalTo(bottomView).offset(AdaptationWidth(-7));
        make.width.mas_equalTo(AdaptationWidth(116));
    }];
    
    UIButton *getBtn = [[UIButton alloc]init];
    getBtn.tag = 5023;
    [getBtn setCornerValue:AdaptationWidth(4)];
    [getBtn setTitle:@"领券购买" forState:UIControlStateNormal];
    [getBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(17)]];
    getBtn.backgroundColor = RedColor;
    [getBtn setImage:[UIImage imageNamed:@"icon_laxin_buy"] forState:UIControlStateNormal];
    [getBtn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:getBtn];
    [getBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView).offset(AdaptationWidth(7));
        make.right.mas_equalTo(bottomView).offset(AdaptationWidth(-10));
        make.bottom.mas_equalTo(bottomView).offset(AdaptationWidth(-7));
        make.width.mas_equalTo(AdaptationWidth(229));
    }];
    
    
    
    WEAKSELF
    [XNetWork requestNetWorkWithUrl:Xtb_product_detail andModel:@{@"productId":self.productId} andSuccessBlock:^(ResponseModel *model) {
        weakSelf.hiBuyDetailModel = [HiBuyDetailModel mj_objectWithKeyValues:model.data];
        [weakSelf.tableView reloadData];
    } andFailBlock:^(ResponseModel *model) {
        
    }];
    
}
#pragma mark - btn
-(void)btnOnClick:(UIButton *)btn{

    switch (btn.tag) {
        case 5021:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 5022://分享
        {
            if (![[UserInfo sharedInstance]isSignIn])[self getBlackLogin:self];
            WEAKSELF
            [XNetWork requestNetWorkWithUrl:Xtb_product_getShareInfo andModel:@{@"productId":self.productId} andSuccessBlock:^(ResponseModel *model) {
                weakSelf.hiBuyShareInfoModel = [HiBuyShareInfoModel mj_objectWithKeyValues:model.data];
                if (weakSelf.hiBuyShareInfoModel.hasAuthorize.integerValue == 0) {
                    [weakSelf goTohasAuthorize:weakSelf.hiBuyShareInfoModel.authorizePageUrl];
                }else{
                    [weakSelf goToShare];
                }
            } andFailBlock:^(ResponseModel *model) {
                
            }];
        }
            break;
        case 5023://领取
        {
            if (![[UserInfo sharedInstance]isSignIn])[self getBlackLogin:self];
            WEAKSELF
            [XNetWork requestNetWorkWithUrl:Xtb_product_couponBuy andModel:@{@"productId":self.productId} andSuccessBlock:^(ResponseModel *model) {
                NSNumber *hasAuthorize = model.data[@"hasAuthorize"];
                if (hasAuthorize.integerValue != 1) {
                    [weakSelf goTohasAuthorize:model.data[@"authorizePageUrl"]];
                    
                }else{
                    [weakSelf goTohasAuthorize:model.data[@"couponShareUrl"]];
                }
                
            } andFailBlock:^(ResponseModel *model) {
                
            }];
        }
            break;
            
        default:
            break;
    }
    
}
//分享
- (void)goToShare{
    
}
//领取
- (void)goTohasAuthorize:(NSString *)url{
    BaseWebVC *vc = [[BaseWebVC alloc]init];
    [vc reloadForGetWebView:url];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            return AdaptationWidth(375);
            break;
        case 1:
            return AdaptationWidth(146);
            break;
        case 2:
            return ScreenHeight;
            break;
            
        default:
            break;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        static NSString *reuseIdentifier = @"HiBuyDetialIdentifier";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
//        if (!cell) {
            UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            switch (indexPath.row) {
                case 0:{
                    [cell.contentView addSubview:self.sdcycleScrollView];
                    _sdcycleScrollView.imageURLStringsGroup = self.hiBuyDetailModel.smallPicUrl;
                    if (self.hiBuyDetailModel.smallPicUrl.count == 1) {
                        _sdcycleScrollView.autoScroll = NO;
                    }
                    [self.sdcycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.right.top.bottom.mas_equalTo(cell);
                    }];
                    return cell;
                }
                    break;
                case 1:
                {
                    UILabel *cellDetail = [[UILabel alloc]init];
                    cellDetail.numberOfLines = 2;
                    cellDetail.text = self.hiBuyDetailModel.title;
                    [cellDetail setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
                    [cellDetail setTextColor:LabelMainColor];
                    [cell.contentView addSubview:cellDetail];
                    [cellDetail mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(cell).offset(AdaptationWidth(16));
                        make.right.mas_equalTo(cell).offset(AdaptationWidth(-16));
                        make.top.mas_equalTo(cell).offset(AdaptationWidth(10));
                    }];
                    
                    UILabel *shopLab = [[UILabel alloc]init];
                    shopLab.text = [NSString stringWithFormat:@"店铺信息 %@",self.hiBuyDetailModel.shopTitle];
                    [shopLab setFont:[UIFont systemFontOfSize:AdaptationWidth(12)]];
                    [shopLab setTextColor:LabelAssistantColor];
                    [cell.contentView addSubview:shopLab];
                    [shopLab mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(cell).offset(AdaptationWidth(16));
                        make.top.mas_equalTo(cellDetail.mas_bottom).offset(AdaptationWidth(5));
                    }];
                    
                    UILabel *yuanLab = [[UILabel alloc]init];
                    yuanLab.text = @"￥";
                    [yuanLab setFont:[UIFont systemFontOfSize:AdaptationWidth(12)]];
                    [yuanLab setTextColor:RedColor];
                    [cell.contentView addSubview:yuanLab];
                    [yuanLab mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(cell).offset(AdaptationWidth(16));
                        make.top.mas_equalTo(shopLab.mas_bottom).offset(AdaptationWidth(12));
                    }];
                    UILabel *moneyLab = [[UILabel alloc]init];
                    if (self.hiBuyDetailModel.couponAmount.integerValue) {
                        moneyLab.text = [NSString stringWithFormat:@"%.2f",[self.hiBuyDetailModel.afterCouplePrice doubleValue]];
                    }else{
                        moneyLab.text = [NSString stringWithFormat:@"%.2f",[self.hiBuyDetailModel.zkFinalPrice doubleValue]];
                    }
                    
                    [moneyLab setFont:[UIFont systemFontOfSize:AdaptationWidth(22)]];
                    [moneyLab setTextColor:RedColor];
                    [cell.contentView addSubview:moneyLab];
                    [moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(yuanLab.mas_right).offset(AdaptationWidth(2));
                        make.top.mas_equalTo(shopLab.mas_bottom).offset(AdaptationWidth(10));
                    }];
                    UILabel *juanLab = [[UILabel alloc]init];
                    juanLab.text = @"卷后";
                    [juanLab setFont:[UIFont systemFontOfSize:AdaptationWidth(12)]];
                    [juanLab setTextColor:RedColor];
                    [cell.contentView addSubview:juanLab];
                    [juanLab mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(moneyLab.mas_right).offset(AdaptationWidth(2));
                        make.top.mas_equalTo(shopLab.mas_bottom).offset(AdaptationWidth(12));
                    }];
                    
                    
                    UILabel *numLab = [[UILabel alloc]init];
                    numLab.text = [NSString stringWithFormat:@"销量%@",self.hiBuyDetailModel.volume.description];
                    [numLab setFont:[UIFont systemFontOfSize:AdaptationWidth(12)]];
                    [numLab setTextColor:LabelAssistantColor];
                    [cell.contentView addSubview:numLab];
                    [numLab mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.mas_equalTo(cell).offset(AdaptationWidth(-16));
                        make.bottom.mas_equalTo(moneyLab);
                    }];
                    
                    UILabel *expectLab = [[UILabel alloc]init];
                    expectLab.backgroundColor = XColorWithRGB(255, 227, 227);
                    if (self.hiBuyDetailModel.commissionAmount.integerValue) {
                        expectLab.hidden = NO;
                        expectLab.text = [NSString stringWithFormat:@"预估收益%.2f",[self.hiBuyDetailModel.commissionAmount doubleValue]];
                    }else{
                        expectLab.hidden = YES;
                    }
                    
                    [expectLab setFont:[UIFont systemFontOfSize:AdaptationWidth(12)]];
                    [expectLab setTextColor:RedColor];
                    [cell.contentView addSubview:expectLab];
                    [expectLab mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(cell).offset(AdaptationWidth(16));
                        make.bottom.mas_equalTo(cell).offset(AdaptationWidth(-9));
                    }];
                    
                    UIView *line = [[UIView alloc]init];
                    line.backgroundColor = LineColor;
                    [cell.contentView addSubview:line];
                    [line mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.right.bottom.mas_equalTo(cell);
                        make.height.mas_equalTo(1);
                    }];
                    
                    return cell;
                }
                    break;
                case 2:
                {
                    UIImageView *titleImage = [[UIImageView alloc]init];
                    titleImage.image = [UIImage imageNamed:@"icon_about"];
                    [cell.contentView addSubview:titleImage];
                    [titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.mas_equalTo(cell).offset(AdaptationWidth(10));
                        make.left.mas_equalTo(cell).offset(AdaptationWidth(16));
                    }];
                    UILabel *titleLab = [[UILabel alloc]init];
                    titleLab.text = [NSString stringWithFormat:@"宝贝详情"];
                    [titleLab setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
                    [titleLab setTextColor:LabelMainColor];
                    [cell.contentView addSubview:titleLab];
                    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(titleImage.mas_right).offset(2);
                        make.centerY.mas_equalTo(titleImage);
                    }];
                    
                    WKWebView *webView = [[WKWebView alloc]init];
                    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.hiBuyDetailModel.productDetailPageUrl]]];
                    [cell.contentView addSubview:webView];
                    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.right.bottom.mas_equalTo(cell);
                        make.top.mas_equalTo(cell).offset(AdaptationWidth(37));
                    }];
                    
                    self.hiBuyDetailModel.cellWidth =   webView.size.height + 37;
                    return cell;
                }
                    break;
                    
                default:
                    break;
            }
//        }

    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
 
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
- (HiBuyDetailModel *)hiBuyDetailModel{
    if (!_hiBuyDetailModel) {
        _hiBuyDetailModel = [[HiBuyDetailModel alloc]init];
    }
    return _hiBuyDetailModel;
}
- (HiBuyShareInfoModel *)hiBuyShareInfoModel{
    if (!_hiBuyShareInfoModel) {
        _hiBuyShareInfoModel = [[HiBuyShareInfoModel alloc]init];
    }
    return _hiBuyShareInfoModel;
}
@end
