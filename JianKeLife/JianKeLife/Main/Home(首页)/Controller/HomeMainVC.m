
//
//  HomeMainVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/5/21.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "HomeMainVC.h"
#import "ArtScrollView.h"
#import "WMPageController.h"
#import "SDCycleScrollView.h"
#import "HiBuyTableViewVC.h"
#import "MessageVC.h"
#import "LLSearchViewController.h"
#import "BaseWebVC.h"
#import "XCommonHepler.h"
#import "SpecialJobListVC.h"
#import "JobDetailVC.h"
#import "SuperProductVC.h"
#import "HiBuyProductdetialVC.h"
#import "HighShareView.h"

#import <ShareSDK/ShareSDK.h>
#import "LaXinView.h"
#import "LaXinModel.h"
#import "WXApi.h"
#import "JobDetailViewModel.h"
#import "QRcodeView.h"
#import "MyPersonShareView.h"


@interface HomeMainVC ()<UIScrollViewDelegate,SDCycleScrollViewDelegate,WMPageControllerDelegate,WMPageControllerDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) WMPageController *wMPageController;
@property (nonatomic, strong) ArtScrollView *containerScrollView;
@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, strong) SDCycleScrollView *sdcycleScrollView;
@property (nonatomic ,strong) UIScrollView *specialScrollViewl;
@property (nonatomic ,strong) UIScrollView *superScrollViewl;
@property (nonatomic ,strong) UIView *adEntryView;

@property (nonatomic ,strong) HighShareView *highShareView;
@property (nonatomic, strong) NSArray *highListAry;
@property (nonatomic, strong) NSString *highTitle;

@property (nonatomic, strong) NSMutableArray *titleData;
@property (nonatomic, strong) NSMutableArray *titleWith;
@property (nonatomic, strong) NSMutableArray *itemsWidthArry;
@property (nonatomic, strong) NSMutableArray *titleName;
@property (nonatomic, strong) NSMutableArray *vcData;
@property (nonatomic, assign) CGFloat itemsWidth;
@property (nonatomic ,strong) UICollectionView *collectionView;
@property (nonatomic ,strong) UIView *bgView;

@property (nonatomic ,strong) UIView *redMessage;

@property (nonatomic ,strong) LaXinModel *laXinModel;
@property (nonatomic ,strong) LaXinView *laXinView;
@property (nonatomic ,strong) QRcodeView *qrCodeView;
@property (nonatomic ,strong) JobDetailViewModel *viewModel;
@property (nonatomic ,strong) MyPersonShareView *myPersonShareView;

@end

@implementation HomeMainVC
-(void)setBackNavigationBarItem{
    
}
- (void)creatSearchBtn{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    bgView.backgroundColor = XColorWithRGB(201, 237, 255);
    UIButton *searchBtn = [[UIButton alloc]init];
    searchBtn.tag = 1001;
    searchBtn.frame = CGRectMake(0, 7, AdaptationWidth(315), 30);
    [searchBtn setBackgroundColor:[UIColor whiteColor]];
    [searchBtn setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
    [searchBtn setTitle:@"输入关键词" forState:UIControlStateNormal];
    [searchBtn setTitleColor:LabelAssistantColor forState:UIControlStateNormal];
    [searchBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
    [searchBtn addTarget:self action:@selector(btnOnClockNaV:) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setCornerValue:4];
    [bgView addSubview:searchBtn];
    
    UIButton *messageBtn = [[UIButton alloc]init];
    messageBtn.tag = 1002;
    messageBtn.frame = CGRectMake(ScreenWidth-AdaptationWidth(54), 8, AdaptationWidth(28), AdaptationWidth(28));
    [messageBtn setImage:[UIImage imageNamed:@"icon_noti_message"] forState:UIControlStateNormal];
    [messageBtn addTarget:self action:@selector(btnOnClockNaV:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:messageBtn];
    
    self.redMessage = [[UIView alloc]init];
    [self.redMessage setCornerValue:4];
    self.redMessage.backgroundColor = RedColor;
    [messageBtn addSubview:self.redMessage];
    [self.redMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(messageBtn);
        make.right.mas_equalTo(messageBtn);
        make.width.height.mas_equalTo(8);
    }];
    
    self.navigationItem.titleView = bgView;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.barTintColor = XColorWithRGB(201, 237, 255);
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:XColorWithRGB(201, 237, 255)] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatSearchBtn];
    
    WEAKSELF
    [XNetWork requestNetWorkWithUrl:Xget_global_info andModel:nil andSuccessBlock:^(ResponseModel *model) {
        ClientGlobalInfo *clientGlobalInfo = [[ClientGlobalInfo alloc]init];
        clientGlobalInfo = [ClientGlobalInfo mj_objectWithKeyValues:model.data];
        [clientGlobalInfo setClientGlobalInfoModel];
        
        [weakSelf.homeViewModel requestData];
        weakSelf.homeViewModel.listType = @2;
        [weakSelf.homeViewModel requestData];
        [weakSelf getData];
    } andFailBlock:^(id result) {
        
    }];
    
    //
    _canScroll = YES;
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:kHomeLeaveTopNotification object:nil];
    [XNotificationCenter addObserver:self selector:@selector(messageRedMsg) name:HomeRedNotification object:nil];
}
- (void)getData{
    
    if (self.clientGlobalInfo.versionInfo)
        [XAlertView alertWithTitle:@"更新提示" message:self.clientGlobalInfo.versionInfo.versionDesc cancelButtonTitle:self.clientGlobalInfo.versionInfo.needForceUpdate.integerValue ? @"":@"取消"confirmButtonTitle:@"更新" viewController:self completion:^(UIAlertAction *action, NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:self.clientGlobalInfo.versionInfo.url]];
                exit(0);
            }
        }];
    
    [self creatLaXin];

    
    WEAKSELF
    [XNetWork requestNetWorkWithUrl:Xtb_classify_list andModel:nil andSuccessBlock:^(ResponseModel *model) {
        [weakSelf.titleData addObjectsFromArray:model.data[@"dataRows"]];
        [XNetWork requestNetWorkWithUrl:Xlist_favorite_product andModel:@{@"pageQueryReq":[[PageQueryRedModel new]mj_keyValues]} andSuccessBlock:^(ResponseModel *model) {
            weakSelf.highTitle = model.data[@"listName"];
//            [dataAry addObjectsFromArray:model.data[@"dataRows"]];
            weakSelf.highListAry = [model.data[@"dataRows"] subarrayWithRange:NSMakeRange(0, 3)];
            
            [weakSelf gettitles];
        } andFailBlock:^(ResponseModel *model) {
            
        }];
    } andFailBlock:^(ResponseModel *model) {
        
    }];
    
    
    
}
- (void)gettitles{
    [self.titleData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.titleName addObject:obj[@"classifyName"]];
    }];
    [self.titleName enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGSize size = [obj sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:AdaptationWidth(16)]}];
        self.itemsWidth = self.itemsWidth + size.width +15;
        [self.itemsWidthArry addObject: @(size.width)];
        [self.titleWith addObject:@(size.width + 15)];
    }];
    
    for (int i = 0; i < self.titleData.count; i ++) {
        [self.vcData addObject:[HiBuyTableViewVC new]];
    }
    [self setupView];
}
- (void)setupView {
    
    self.redMessage.hidden = self.clientGlobalInfo.messageCenterRedPoint.integerValue ? NO : YES;
    
    [self.view addSubview:self.containerScrollView];
    [self.containerScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.bottom.trailing.equalTo(self.view).offset(0);
    }];
    
    UIImageView *headImage = [[UIImageView alloc]init];
    [headImage setImage:[UIImage imageNamed:@"icon_headBG"]];
    [self.containerScrollView addSubview:headImage];
    [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.containerScrollView);
    }];
    
    [self.containerScrollView addSubview:self.sdcycleScrollView];
    [self.sdcycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.containerScrollView).offset(AdaptationWidth(16));
        make.top.mas_equalTo(self.containerScrollView);
        make.right.mas_equalTo(self.containerScrollView).offset(AdaptationWidth(-16));
        make.height.mas_equalTo(AdaptationWidth(130));
    }];
    
    [self.containerScrollView addSubview:self.specialScrollViewl];
    [self.specialScrollViewl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.containerScrollView).offset(AdaptationWidth(16));
        make.top.mas_equalTo(self.sdcycleScrollView.mas_bottom).offset(AdaptationWidth(6));
        make.right.mas_equalTo(self.containerScrollView).offset(AdaptationWidth(-16));
        make.height.mas_equalTo(AdaptationWidth(100));
    }];
    
    if (self.homeViewModel.productList.count) {
        UIImageView *image = [[UIImageView alloc]init];
        [image setImage: [UIImage imageNamed:@"icon_super"]];
        [self.containerScrollView addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.containerScrollView).offset(AdaptationWidth(16));
            make.top.mas_equalTo(self.specialScrollViewl.mas_bottom).offset(AdaptationWidth(12));
        }];
        
        [self.containerScrollView addSubview:self.superScrollViewl];
        [self.superScrollViewl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.containerScrollView).offset(AdaptationWidth(16));
            make.top.mas_equalTo(image.mas_bottom).offset(AdaptationWidth(19));
            make.right.mas_equalTo(self.containerScrollView).offset(AdaptationWidth(-16));
            
            make.height.mas_equalTo(AdaptationWidth(155));
        }];
    }
    
    
    [self.containerScrollView addSubview:self.adEntryView];
    [self.adEntryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.containerScrollView).offset(AdaptationWidth(16));
        if (self.homeViewModel.productList.count) {
            make.top.mas_equalTo(self.superScrollViewl.mas_bottom).offset(AdaptationWidth(12));
        }else{
            make.top.mas_equalTo(self.specialScrollViewl.mas_bottom).offset(AdaptationWidth(12));
        }
        
        make.right.mas_equalTo(self.containerScrollView).offset(AdaptationWidth(-16));
        if (self.homeViewModel.clientGlobalInfo.adEntryList.count > 2) {
            make.height.mas_equalTo(AdaptationWidth(159));
        }else{
            make.height.mas_equalTo(AdaptationWidth(76));
        }
        
    }];
    if (self.highListAry.count) {
        [self.containerScrollView addSubview:self.highShareView];
        [self.highShareView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.containerScrollView).offset(AdaptationWidth(16));
            make.top.mas_equalTo(self.adEntryView.mas_bottom).offset(AdaptationWidth(12));
            make.right.mas_equalTo(self.containerScrollView).offset(AdaptationWidth(-16));
            switch (self.highListAry.count) {
                case 1:
                    make.height.mas_equalTo(AdaptationWidth(190));
                    break;
                case 2:
                    make.height.mas_equalTo(AdaptationWidth(310));
                    break;
                case 3:
                    make.height.mas_equalTo(AdaptationWidth(430));
                    break;
                    
                default:
                    break;
            }
            
            
        }];
    }

    [self.containerScrollView addSubview:self.wMPageController.view];
    [self.wMPageController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.highListAry.count) {
            make.top.equalTo(self.highShareView.mas_bottom).offset(AdaptationWidth(18));
        }else{
            make.top.equalTo(self.adEntryView.mas_bottom).offset(AdaptationWidth(16));
        }
        
        make.leading.trailing.bottom.equalTo(self.containerScrollView);
        make.width.equalTo(self.containerScrollView);
        make.height.mas_equalTo(ScreenHeight-120);
    }];
    if (self.itemsWidth > ScreenWidth) {
        UIButton *selectBtn = [[UIButton alloc]init];
        
        [selectBtn setBackgroundColor:[UIColor whiteColor]];
        [selectBtn setImage:[UIImage imageNamed:@"icon_down"] forState:UIControlStateNormal];
        [selectBtn addTarget:self action:@selector(btnOnClockSelect:) forControlEvents:UIControlEventTouchUpInside];
        [self.wMPageController.view addSubview:selectBtn];
        
        [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.mas_equalTo(self.wMPageController.view);
            //            make.top.mas_equalTo(self.view).offset(AdaptationWidth(10));
            make.width.height.mas_equalTo(AdaptationWidth(42));
        }];
    }
    
    [self selectBannerOrSpecial];
}
#pragma mark - banner or Special跳转
- (void)selectBannerOrSpecial{
    WEAKSELF
    [self.homeViewModel setResponseBannerWebBlock:^(id result) {
        BaseWebVC *vc = [[BaseWebVC alloc]init];
        [vc reloadForGetWebView:result];
        
        //        [vc.webParentView setScriptBlock:^(id result) {
        //            [weakSelf webViewWithScript:result];
        //        }];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    [self.homeViewModel setResponseHotWebBlock:^(id result) {
        BaseWebVC *vc = [[BaseWebVC alloc]init];
        [vc reloadForGetWebView:result];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    self.homeViewModel.responseHotBlock = ^(NSNumber *result ,NSNumber *row) {
        SpecialJobListVC *vc = [[SpecialJobListVC alloc]init];
        vc.title = weakSelf.clientGlobalInfo.specialEntryList[row.integerValue][@"specialEntryTitle"];
        vc.specialId = result;
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
}
#pragma mark - 拉新
- (void)creatLaXin{
    //拉新
    WEAKSELF
    [XNetWork requestNetWorkWithUrl:Xintroduce_new_complete_data andModel:nil andSuccessBlock:^(ResponseModel *model) {
        weakSelf.laXinModel = [LaXinModel mj_objectWithKeyValues:model.data];
        if (!weakSelf.laXinModel.isFinished.integerValue && !weakSelf.laXinModel.isCompleteFirstTask.integerValue) {
            
            double num = weakSelf.laXinModel.totalAmount.doubleValue/weakSelf.laXinModel.minWithdrawAmount.doubleValue;
            weakSelf.laXinView = [[NSBundle mainBundle]loadNibNamed:@"LaXinView" owner:nil options:nil].lastObject;
            weakSelf.laXinView.titleLab2.hidden = YES;
            weakSelf.laXinView.progressNum = [UserInfo sharedInstance].isSignIn ? num : 0.18;
            int newNum = (1 -num)*100;
            weakSelf.laXinView.proDetailLab.text = [UserInfo sharedInstance].isSignIn ? [NSString stringWithFormat:@"满%d元即可提现，距离提现还有%d%%",[weakSelf.laXinModel.minWithdrawAmount intValue]/100,newNum] :@"满50元即可提现，距离提现还有82%";
            [weakSelf.laXinView setLaXinBlock:^(UIButton *result) {
                
                switch (result.tag) {
                    case 501:
                    {
                        if (![[UserInfo sharedInstance]isSignIn]){
                            weakSelf.laXinView.hidden = YES;
                            [weakSelf getBlackLogin:weakSelf];
                        }else{
                            weakSelf.laXinView.hidden = YES;
                            BaseWebVC *vc = [[BaseWebVC alloc]init];
                            [vc reloadForGetWebView:weakSelf.laXinModel.activityPageUrl];
                            vc.hidesBottomBarWhenPushed = YES;
                            [weakSelf.navigationController pushViewController:vc animated:YES];
                        }
                    }
                        break;
                    case 502:{
                        if (![[UserInfo sharedInstance]isSignIn]){
                            weakSelf.laXinView.hidden = YES;
                            [weakSelf getBlackLogin:weakSelf];
                        }else{
                            weakSelf.laXinView.hidden = YES;
                        }
                    }
                        
                        break;
                        
                    default:
                        break;
                }
                
            }];
            weakSelf.laXinView.frame = [UIScreen mainScreen].bounds;
            [[UIApplication sharedApplication].keyWindow addSubview: weakSelf.laXinView];
            
            
        }else if(!weakSelf.laXinModel.isFinished.integerValue && weakSelf.laXinModel.isCompleteFirstTask.integerValue && ![UserInfo sharedInstance].isAlertShare){
            
            weakSelf.laXinView = [[NSBundle mainBundle]loadNibNamed:@"LaXinView" owner:nil options:nil].lastObject;
            weakSelf.laXinView.frame = [UIScreen mainScreen].bounds;
            [[UIApplication sharedApplication].keyWindow addSubview: weakSelf.laXinView];
            weakSelf.laXinView.titleLab.hidden = YES;
            weakSelf.laXinView.proDetailLab.hidden = YES;
            weakSelf.laXinView.detailLab.hidden = YES;
            weakSelf.laXinView.titleLab2.text = @"享享注意到你还没有领取分享奖励哦，动动手指轻松得5元";
            weakSelf.laXinView.mainImage.image = [UIImage imageNamed:@"icon_laxin_unShare"];
            weakSelf.laXinView.headImage.hidden = YES;
            weakSelf.laXinView.isProView = YES;
            [weakSelf.laXinView.finishBtn setTitle:@"分享赚5元" forState:UIControlStateNormal];
            [weakSelf.laXinView setLaXinBlock:^(UIButton *result) {
                
                switch (result.tag) {
                    case 501:
                    {
                        weakSelf.laXinView.hidden = YES;
                        BaseWebVC *vc = [[BaseWebVC alloc]init];
                        [vc reloadForGetWebView:weakSelf.laXinModel.activityPageUrl];
                        vc.hidesBottomBarWhenPushed = YES;
                        [weakSelf.navigationController pushViewController:vc animated:YES];
                    }
                        break;
                    case 502:{
                        if (weakSelf.laXinModel.productNo.length) {
                            [weakSelf shareView:weakSelf.laXinModel.productNo];
                        } else {
                            [weakSelf shareAppView];
                            
                        }
                        
                    }
                        
                        break;
                        
                    default:
                        break;
                }
                
            }];
            
        }
    } andFailBlock:^(id result) {
        
    }];
}
//分享app
- (void)shareAppView{
    WEAKSELF
    [XNetWork requestNetWorkWithUrl:Xget_connections_info andModel:nil andSuccessBlock:^(ResponseModel *model) {
        [[UIApplication sharedApplication].keyWindow addSubview: weakSelf.myPersonShareView];
        weakSelf.myPersonShareView.QRImageView.image = [UIImage qrCodeImageWithInfo:model.data[@"connectionsInviteRegUrl"] width:AdaptationWidth(85)];
        weakSelf.myPersonShareView.hidden = NO;
        weakSelf.myPersonShareView.QRMainBGView.hidden = YES;
        weakSelf.myPersonShareView.btnBlock = [weakSelf shareViewBtnBlock:model.data[@"connectionsInviteRegUrl"]];
    } andFailBlock:^(ResponseModel *model) {
        
    }];
}
- (XBlock)shareViewBtnBlock:(NSString *)str{
    BLOCKSELF
    XBlock block = ^(UIButton *btn){
        switch (btn.tag) {
                
            case 3022:
            {
                if (![WXApi isWXAppInstalled]) {
                    [ProgressHUD showProgressHUDInView:nil withText:@"未安装微信" afterDelay:1 ];
                    return ;
                }
                NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
                [shareParams SSDKSetupShareParamsByText:@"购物省钱，分享赚钱 开启你的值享生活"
                                                 images:[UIImage convertViewToImage:blockSelf.myPersonShareView.QRDownBGView]
                                                    url:[NSURL URLWithString:str]
                                                  title:AppName
                                                   type:SSDKContentTypeAuto];
                [ShareSDK share:SSDKPlatformSubTypeWechatSession parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                    [UserInfo sharedInstance].isAlertShare = YES;
                    [[UserInfo sharedInstance]saveUserInfo:[UserInfo sharedInstance]];
                }];
            }
                break;
            case 3023:
            {
                if (![WXApi isWXAppInstalled]) {
                    [ProgressHUD showProgressHUDInView:nil withText:@"未安装微信" afterDelay:1 ];
                    return ;
                }
                NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
                [shareParams SSDKSetupShareParamsByText:@"购物省钱，分享赚钱 开启你的值享生活"
                                                 images:[UIImage convertViewToImage:blockSelf.myPersonShareView.QRDownBGView]
                                                    url:[NSURL URLWithString:str]
                                                  title:AppName
                                                   type:SSDKContentTypeAuto];
                [ShareSDK share:SSDKPlatformSubTypeWechatTimeline parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                    [UserInfo sharedInstance].isAlertShare = YES;
                    [[UserInfo sharedInstance]saveUserInfo:[UserInfo sharedInstance]];
                }];
            }
                break;
            case 3024:
                blockSelf.myPersonShareView.hidden = YES;
                break;
                
            default:
                break;
        }
    };
    return block;
}
//分享任务
- (void)shareView:(NSString *)proid{
    
    self.viewModel = [[JobDetailViewModel alloc]init];
    self.viewModel.productModel.productNo = proid;
    [self.viewModel requestShareData];
    WEAKSELF
    [self.viewModel setProductShareBlock:^(NSDictionary *dic) {
        
        [weakSelf goToShare:dic];
        
    }];
    
    
}
- (void)goToShare:(NSDictionary *)dic{
    
    self.qrCodeView.hidden = NO;
    [self.qrCodeView.QRcodeMainView setCornerValue:8];
    self.qrCodeView.QRtitle.text = dic[@"productTitle"];
    self.qrCodeView.QRmoney.text = [NSString stringWithFormat:@"%.2f",[dic[@"productSalary"] doubleValue]/100];
    [self.qrCodeView.QRimageView sd_setImageWithURL:[NSURL URLWithString:dic[@"productFirstMainPicUrl"]]];
    self.qrCodeView.QRcodeImageView.image = [UIImage qrCodeImageWithInfo:dic[@"productShareUrl"] width:AdaptationWidth(85)];
    
    self.qrCodeView.frame = [UIScreen mainScreen].bounds;
    [[UIApplication sharedApplication].keyWindow addSubview: self.qrCodeView];
    
    BLOCKSELF
    [self.qrCodeView setBtnBlock:^(UIButton *result) {
        switch (result.tag) {
            case 1021:
            {
                [[XCommonHepler sharedInstance] saveImageToPhotoLib:[UIImage convertViewToImage:blockSelf.qrCodeView.QRcodeDownView]];
            }
                break;
            case 1022:
            {
                if (![WXApi isWXAppInstalled]) {
                    [ProgressHUD showProgressHUDInView:nil withText:@"未安装微信" afterDelay:1 ];
                    return ;
                }
                blockSelf.qrCodeView.hidden = YES;
                //                MyLog(@"%@",dic[@"productShareUrl"]);
                NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
                [shareParams SSDKSetupShareParamsByText:dic[@"productTitle"]
                                                 images:[UIImage convertViewToImage:blockSelf.qrCodeView.QRcodeDownView]
                                                    url:[NSURL URLWithString:dic[@"productShareUrl"]]
                                                  title:blockSelf.viewModel.productModel.productTitle
                                                   type:SSDKContentTypeAuto];
                [ShareSDK share:SSDKPlatformSubTypeWechatSession parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                    
                }];
                //小程序分享
                //                [shareParams SSDKSetupWeChatMiniProgramShareParamsByTitle:@"我是天才"
                //                                                              description:@"我是天才"
                //                                                               webpageUrl:[NSURL URLWithString:@"https://www.baidu.com/"]
                //                                                                     path:@"pages/home/main"
                //                                                               thumbImage:nil
                //                                                             hdThumbImage:nil
                //                                                                 userName:@"gh_498c3f38a98d"
                //                                                          withShareTicket:YES
                //                                                          miniProgramType:0
                //                                                       forPlatformSubType:SSDKPlatformSubTypeWechatSession];
                //                [ShareSDK share:SSDKPlatformSubTypeWechatSession parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                //
                //                }];
            }
                break;
            case 1023:
            {
                if (![WXApi isWXAppInstalled]) {
                    [ProgressHUD showProgressHUDInView:nil withText:@"未安装微信" afterDelay:1 ];
                    return ;
                }
                blockSelf.qrCodeView.hidden = YES;
                NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
                [shareParams SSDKSetupShareParamsByText:dic[@"productTitle"]
                                                 images:[UIImage convertViewToImage:blockSelf.qrCodeView.QRcodeDownView]
                                                    url:[NSURL URLWithString:dic[@"productShareUrl"]]
                                                  title:dic[@"productTitle"]
                                                   type:SSDKContentTypeAuto];
                [ShareSDK share:SSDKPlatformSubTypeWechatTimeline parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                    
                }];
            }
                break;
            case 1024:
            {
                blockSelf.qrCodeView.hidden = YES;
            }
                break;
                
            default:
                break;
        }
    }];
    
}
#pragma mark - Datasource & Delegate

#pragma mark 返回子页面的个数
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titleData.count;
}

#pragma mark 返回某个index对应的页面
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    HiBuyTableViewVC *vc = self.vcData[index];
    vc.hiBuyViewModel.hiBuyProductQueryModel.prodClassifyId = self.titleData[index][@"classifyId"];
    vc.isFirstType = index == 0 ? YES : NO;
    return vc;
    
}

#pragma mark 返回index对应的标题
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    return self.titleData[index][@"classifyName"];
}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView{
    return CGRectMake(0, AdaptationWidth(42), ScreenWidth, ScreenHeight-AdaptationWidth(151));
}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView{
    if (self.itemsWidth > ScreenWidth) {
        return CGRectMake(0, 0, ScreenWidth-40, AdaptationWidth(42));
    }
    return CGRectMake(0, 0, self.itemsWidth + 20, AdaptationWidth(42));
}
#pragma mark -UICollectionView
//有多少的分组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}
//每个分组里有多少个item
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titleData.count;
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(AdaptationWidth(54), AdaptationWidth(75));
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(AdaptationWidth(10), AdaptationWidth(20), AdaptationWidth(10), AdaptationWidth(20));
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                  withReuseIdentifier:@"CollectionHeadTypeView"
                                                                                         forIndexPath:indexPath];
        UILabel *lab = [[UILabel alloc]init];
        [lab setText:@"全部分类"];
        [lab setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
        [lab setTextColor:XColorWithRGB(124, 124, 124)];
        [headerView addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(headerView).offset(AdaptationWidth(16));
            make.top.mas_equalTo(headerView).offset(AdaptationWidth(10));
        }];
        
        UIButton *selectBtn = [[UIButton alloc]init];
       
        [selectBtn setBackgroundColor:[UIColor whiteColor]];
        [selectBtn setImage:[UIImage imageNamed:@"icon_down"] forState:UIControlStateNormal];
        [selectBtn addTarget:self action:@selector(btnOnClockDown:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:selectBtn];
        [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(headerView).offset(AdaptationWidth(-16));
            make.top.mas_equalTo(headerView).offset(AdaptationWidth(10));
            make.width.height.mas_equalTo(AdaptationWidth(30));
        }];
        return headerView;
    }
    return nil;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    
    return CGSizeMake(ScreenWidth, AdaptationWidth(42));
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //根据identifier从缓冲池里去出cell
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HiBuyTypeCell" forIndexPath:indexPath];
    UIImageView *imageCell = [[UIImageView alloc]init];
    
    [imageCell sd_setImageWithURL:[NSURL URLWithString:XNULL_TO_NIL(self.titleData[indexPath.row][@"classifyImgUrl"])] placeholderImage:[UIImage imageNamed:@"今日值享logo定稿"]];
    //    [imageCell sd_setImageWithURL:[NSURL URLWithString:self.titleData[indexPath.row][@"classifyImgUrl"]]];
    [cell.contentView addSubview:imageCell];
    [imageCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(cell);
        make.height.mas_equalTo(AdaptationWidth(54));
    }];
    
    UILabel *lab = [[UILabel alloc]init];
    [lab setText:self.titleName[indexPath.row]];
    [lab setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
    [lab setTextColor:LabelMainColor];
    [cell.contentView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(cell);
        make.top.mas_equalTo(imageCell.mas_bottom).offset(1);
    }];
    
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.bgView.hidden = YES;
    self.wMPageController.selectIndex = (int)indexPath.row;
    
}
#pragma mark - notification

-(void)acceptMsg : (NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    NSString *canScroll = userInfo[@"canScroll"];
    if ([canScroll isEqualToString:@"1"]) {
        _canScroll = YES;
    }
}
- (void)messageRedMsg{
    self.redMessage.hidden = YES;
}
#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat maxOffsetY = self.wMPageController.view.Y;
    CGFloat offsetY = scrollView.contentOffset.y;
//    self.navigationController.navigationBar.alpha = offsetY/136;
    if (offsetY>=maxOffsetY) {
        scrollView.contentOffset = CGPointMake(0, maxOffsetY);
        //NSLog(@"滑动到顶端");
//        if (_canScroll) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kHomeGoTopNotification object:nil userInfo:@{@"canScroll":@"1"}];
//        }
        
        _canScroll = NO;
    } else {
        //NSLog(@"离开顶端");
        if (!_canScroll) {
            scrollView.contentOffset = CGPointMake(0, maxOffsetY);
        }
    }
}
#pragma  mark - btn
- (void)btnOnClockNaV:(UIButton *)btn{
 
    if (btn.tag == 1001) {
        LLSearchViewController *vc = [[LLSearchViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
        if (![[UserInfo sharedInstance]isSignIn]) {
            [XNetWork unLoginNotification];
            return;
        }
        
//        self.redMessage.hidden = YES;
        MessageVC *vc = [[MessageVC alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
   
}
- (void)btnOnClockSelect:(UIButton *)btn{
    [self.wMPageController.view addSubview:self.bgView];
    self.bgView.hidden = NO;
}
- (void)btnOnClockDown:(UIButton *)btn{
    self.bgView.hidden = YES;
}
- (void)btnOnClick:(UIButton *)btn{
    
    [TalkingData trackEvent:@"首页-点击【特色入口】"];
    [self.homeViewModel requestSpecialData:btn.tag-1021];
}
- (void)btnOnClickSuper:(UIButton *)btn{
    if (btn.tag == 1059) {
        SuperProductVC*vc = [[SuperProductVC alloc]init];
        vc.superType = @1;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        JobDetailVC *vc = [[JobDetailVC alloc]init];
        vc.productNo = self.homeViewModel.productList[btn.tag-1050][@"productNo"];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)btnOnClickAd:(UIButton *)btn{
    
    NSNumber *isLogin = self.homeViewModel.clientGlobalInfo.adEntryList[btn.tag-1031][@"isNeedLogin"];
    if (isLogin.integerValue == 1) {
        if (![[UserInfo sharedInstance]isSignIn]) {
            [XNetWork unLoginNotification];
            return;
        }
    }
    [TalkingData trackEvent:@"首页-点击【广告入口】"];
    NSNumber *adType = self.homeViewModel.clientGlobalInfo.adEntryList[btn.tag-1031][@"adEntryType"];
    NSString *adId = self.homeViewModel.clientGlobalInfo.adEntryList[btn.tag-1031][@"id"];
    NSNumber *adDetailUrl = XNULL_TO_NIL(self.homeViewModel.clientGlobalInfo.adEntryList[btn.tag-1031][@"configContent"]);
    [XNetWork requestNetWorkWithUrl:Xadvertise_access_log andModel:@{@"adId":adId} andSuccessBlock:^(ResponseModel *model) {
        
    } andFailBlock:^(ResponseModel *model) {
        
    }];
    if (!adDetailUrl) {
        [ProgressHUD showProgressHUDInView:nil withText:@"任务已经过期" afterDelay:1];
        return;
    }
    switch (adType.integerValue) {
        case 1:
        {
            BaseWebVC *vc = [[BaseWebVC alloc]init];
            [vc reloadForGetWebView:adDetailUrl.description];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:adDetailUrl.description]];
            break;
        case 3:
        {
            JobDetailVC *vc = [[JobDetailVC alloc]init];
            vc.productNo = adDetailUrl.description;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            HiBuyProductdetialVC *vc = [[HiBuyProductdetialVC alloc]init];
            vc.productId = adDetailUrl;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:
        {
            BaseWebVC *vc = [[BaseWebVC alloc]init];
            [vc reloadForGetWebView:adDetailUrl.description];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
            
        default:
            break;
    }
}
#pragma mark -SDCycleScrollView delegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSNumber *isLogin = self.homeViewModel.clientGlobalInfo.bannerAdList[index][@"isNeedLogin"];
    if (isLogin.integerValue == 1) {
        if (![[UserInfo sharedInstance]isSignIn]) {
            [XNetWork unLoginNotification];
            return;
        }
        
    }
    [TalkingData trackEvent:@"首页-点击【Banner广告】"];
    [self.homeViewModel requestBannerData:index];
}
#pragma mark - getter
- (SDCycleScrollView *)sdcycleScrollView{
    if (!_sdcycleScrollView) {
        NSMutableArray *imageArry = [NSMutableArray array];
        [self.homeViewModel.clientGlobalInfo.bannerAdList enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [imageArry addObject:obj[@"adImgUrl"]];
        }];
        _sdcycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"iamge_rule"]];
        [_sdcycleScrollView setCornerValue:AdaptationWidth(8)];
        _sdcycleScrollView.imageURLStringsGroup = imageArry;
        _sdcycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
        _sdcycleScrollView.autoScrollTimeInterval = 3;
        _sdcycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _sdcycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _sdcycleScrollView.pageDotColor = XColorWithRBBA(255, 255, 255, 0.4);
        if (imageArry.count == 1) {
            _sdcycleScrollView.autoScroll = NO;
        }
    }
    return _sdcycleScrollView;
}
- (UIScrollView *)specialScrollViewl{
    if (!_specialScrollViewl) {
        _specialScrollViewl  = [[UIScrollView alloc]init];
        _specialScrollViewl.contentSize = CGSizeMake(self.homeViewModel.clientGlobalInfo.specialEntryList.count *AdaptationWidth(80), 0);
        _specialScrollViewl.showsVerticalScrollIndicator = NO;
        _specialScrollViewl.showsHorizontalScrollIndicator = NO;
        _specialScrollViewl.pagingEnabled = NO;
        _specialScrollViewl.bounces = NO;
        
        
        for (int i=0; i < self.homeViewModel.clientGlobalInfo.specialEntryList.count; i++) {
            UIButton *balckBtn = [[UIButton alloc]init];
            balckBtn.tag = 1021 + i;
            [balckBtn setTitle:self.homeViewModel.clientGlobalInfo.specialEntryList[i][@"specialEntryTitle"] forState:UIControlStateNormal];
            
            [balckBtn setTitleColor:LabelMainColor forState:UIControlStateNormal];
            [balckBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
            //            [balckBtn sd_setImageWithURL:self.homeViewModel.clientGlobalInfo.specialEntryList[i][@"specialEntryIcon"] forState:UIControlStateNormal];
            
            [balckBtn sd_setImageWithURL:self.homeViewModel.clientGlobalInfo.specialEntryList[i][@"specialEntryIcon"] forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                balckBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 20, 0);
                balckBtn.titleEdgeInsets = UIEdgeInsetsMake(AdaptationWidth(70), -image.size.width, 0,  -5);
            }];

            [balckBtn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_specialScrollViewl addSubview:balckBtn];
            if (self.homeViewModel.clientGlobalInfo.specialEntryList.count > 4) {
                [balckBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(self->_specialScrollViewl).offset(AdaptationWidth(80)*i);
                    make.top.mas_equalTo(self->_specialScrollViewl);
                    make.height.mas_equalTo(AdaptationWidth(75));
                    make.width.mas_equalTo(AdaptationWidth(56));
                }];
            }else{
                [balckBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(self->_specialScrollViewl).offset(AdaptationWidth(95)*i);
                    make.top.mas_equalTo(self->_specialScrollViewl);
                    make.height.mas_equalTo(AdaptationWidth(75));
                    make.width.mas_equalTo(AdaptationWidth(56));
                }];
            }
            
        }
    }
    return _specialScrollViewl;
}
- (UIScrollView *)superScrollViewl{
    if (!_superScrollViewl) {
        _superScrollViewl  = [[UIScrollView alloc]init];
        if (self.homeViewModel.productList.count > 5) {
            _superScrollViewl.contentSize = CGSizeMake(5 *AdaptationWidth(138) + AdaptationWidth(100), 0);
        }else{
            _superScrollViewl.contentSize = CGSizeMake(self.homeViewModel.productList.count *AdaptationWidth(138) + AdaptationWidth(100), 0);
        }
        
        
        _superScrollViewl.showsVerticalScrollIndicator = NO;
        _superScrollViewl.showsHorizontalScrollIndicator = NO;
        _superScrollViewl.pagingEnabled = NO;
        _superScrollViewl.bounces = NO;
        
        NSInteger row = self.homeViewModel.productList.count > 5 ? 5 : self.homeViewModel.productList.count;
        
        for (int i=0; i < row; i++) {
            UIView *view = [[UIView alloc]init];
            [view setCornerValue:AdaptationWidth(6)];
            [view setBorderWidth:1 andColor:XColorWithRGB(238, 238, 238)];
            [_superScrollViewl addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self->_superScrollViewl).offset(AdaptationWidth(138)*i);
                make.top.mas_equalTo(self->_superScrollViewl);
                make.height.mas_equalTo(AdaptationWidth(150));
                make.width.mas_equalTo(AdaptationWidth(130));
            }];
            
            UIImageView *image = [[UIImageView alloc]init];
            [image sd_setImageWithURL:[NSURL URLWithString:self.homeViewModel.productList[i][@"productFirstMainPicUrl"]]];
            [view addSubview:image];
            [image mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.mas_equalTo(view);
                make.height.mas_equalTo(AdaptationWidth(86));
            }];
            
            UILabel *detailtitle = [[UILabel alloc]init];
            detailtitle.text = self.homeViewModel.productList[i][@"productTitle"];
            [detailtitle setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(14)]];
            [detailtitle setTextColor:LabelMainColor];
            [view addSubview:detailtitle];
            [detailtitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(view).offset(AdaptationWidth(6));
                make.right.mas_equalTo(view).offset(AdaptationWidth(-6));
                make.top.mas_equalTo(image.mas_bottom).offset(AdaptationWidth(8));
                
            }];
            
            UILabel *moneyLab = [[UILabel alloc]init];
            moneyLab.text = @"领取￥";
            [moneyLab setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(12)]];
            [moneyLab setTextColor:RedColor];
            [view addSubview:moneyLab];
            [moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(view).offset(AdaptationWidth(6));
                make.top.mas_equalTo(detailtitle.mas_bottom).offset(AdaptationWidth(8));
                
            }];
            UILabel *money = [[UILabel alloc]init];
            money.text = [NSString stringWithFormat:@"%.2f",[self.homeViewModel.productList[i][@"productSalary"] doubleValue]/100];
            [money setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(18)]];
            [money setTextColor:RedColor];
            [view addSubview:money];
            [money mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(moneyLab.mas_right).offset(AdaptationWidth(2));
                make.bottom.mas_equalTo(moneyLab).offset(2);
                
            }];
            
            
            UIButton *balckBtn = [[UIButton alloc]init];
            balckBtn.tag = 1050 + i;
            [balckBtn addTarget:self action:@selector(btnOnClickSuper:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:balckBtn];
            [balckBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(view);
                
            }];
            
            if ((row-1) == i) {
                UIButton *allBtn = [[UIButton alloc]init];
                allBtn.tag = 1059 ;
                [allBtn setTitle:@"查看全部" forState:UIControlStateNormal];
                [allBtn setImage:[UIImage imageNamed:@"icon_super_all"] forState:UIControlStateNormal];
                [allBtn setTitleColor:LabelAssistantColor forState:UIControlStateNormal];
                [allBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
                allBtn.imageEdgeInsets = UIEdgeInsetsMake(0, AdaptationWidth(58), 0, 0);
                allBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -AdaptationWidth(37), 0, 0);
                [allBtn addTarget:self action:@selector(btnOnClickSuper:) forControlEvents:UIControlEventTouchUpInside];
                [_superScrollViewl addSubview:allBtn];
                [allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.mas_equalTo(self->_superScrollViewl);
                    make.left.mas_equalTo(view.mas_right).offset(AdaptationWidth(15));
                }];
            }
        }
        
    }
    return _superScrollViewl;
}
- (UIView *)adEntryView{
    if (!_adEntryView) {
        _adEntryView = [[UIView alloc]init];
        
        switch (self.homeViewModel.clientGlobalInfo.adEntryList.count) {
            case 1:
            {
                UIButton *adBtn = [[UIButton alloc]init];
                adBtn.tag = 1031;
                [adBtn sd_setImageWithURL:[NSURL URLWithString:self.homeViewModel.clientGlobalInfo.adEntryList[0][@"adEntryImgUrl"]] forState:UIControlStateNormal];
                [adBtn addTarget:self action:@selector(btnOnClickAd:) forControlEvents:UIControlEventTouchUpInside];
                [_adEntryView addSubview:adBtn];
                [adBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.mas_equalTo(self->_adEntryView);
                }];
            }
                break;
            case 2:
            {
                UIButton *adBtn = [[UIButton alloc]init];
                adBtn.tag = 1031;
                [adBtn sd_setImageWithURL:[NSURL URLWithString:self.homeViewModel.clientGlobalInfo.adEntryList[0][@"adEntryImgUrl"]] forState:UIControlStateNormal];
                [adBtn addTarget:self action:@selector(btnOnClickAd:) forControlEvents:UIControlEventTouchUpInside];
                [_adEntryView addSubview:adBtn];
                [adBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.top.bottom.mas_equalTo(self->_adEntryView);
                    make.width.mas_equalTo(AdaptationWidth(168));
                    make.height.mas_equalTo(AdaptationWidth(76));
                }];
                
                UIButton *adBtn2 = [[UIButton alloc]init];
                adBtn2.tag = 1032;
                [adBtn2 sd_setImageWithURL:[NSURL URLWithString:self.homeViewModel.clientGlobalInfo.adEntryList[1][@"adEntryImgUrl"]] forState:UIControlStateNormal];
                [adBtn2 addTarget:self action:@selector(btnOnClickAd:) forControlEvents:UIControlEventTouchUpInside];
                [_adEntryView addSubview:adBtn2];
                [adBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.top.bottom.mas_equalTo(self->_adEntryView);
                    make.width.mas_equalTo(AdaptationWidth(168));
                    make.height.mas_equalTo(AdaptationWidth(76));
                }];
            }
                break;
            case 3:
            {
                UIButton *adBtn = [[UIButton alloc]init];
                adBtn.tag = 1031;
                [adBtn sd_setImageWithURL:[NSURL URLWithString:self.homeViewModel.clientGlobalInfo.adEntryList[0][@"adEntryImgUrl"]] forState:UIControlStateNormal];
                [adBtn addTarget:self action:@selector(btnOnClickAd:) forControlEvents:UIControlEventTouchUpInside];
                [_adEntryView addSubview:adBtn];
                [adBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.top.mas_equalTo(self->_adEntryView);
                    make.width.mas_equalTo(AdaptationWidth(168));
                    make.height.mas_equalTo(AdaptationWidth(76));
                }];
                
                UIButton *adBtn2 = [[UIButton alloc]init];
                adBtn2.tag = 1032;
                [adBtn2 sd_setImageWithURL:[NSURL URLWithString:self.homeViewModel.clientGlobalInfo.adEntryList[1][@"adEntryImgUrl"]] forState:UIControlStateNormal];
                [adBtn2 addTarget:self action:@selector(btnOnClickAd:) forControlEvents:UIControlEventTouchUpInside];
                [_adEntryView addSubview:adBtn2];
                [adBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.top.mas_equalTo(self->_adEntryView);
                    make.width.mas_equalTo(AdaptationWidth(168));
                    make.height.mas_equalTo(AdaptationWidth(76));
                }];
                
                UIButton *adBtn3 = [[UIButton alloc]init];
                adBtn3.tag = 1033;
                [adBtn3 sd_setImageWithURL:[NSURL URLWithString:self.homeViewModel.clientGlobalInfo.adEntryList[2][@"adEntryImgUrl"]] forState:UIControlStateNormal];
                [adBtn3 addTarget:self action:@selector(btnOnClickAd:) forControlEvents:UIControlEventTouchUpInside];
                [_adEntryView addSubview:adBtn3];
                [adBtn3 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.left.bottom.mas_equalTo(self->_adEntryView);
                    make.height.mas_equalTo(AdaptationWidth(76));
                }];
            }
                break;
            case 4:
            {
                UIButton *adBtn = [[UIButton alloc]init];
                adBtn.tag = 1031;
                [adBtn sd_setImageWithURL:[NSURL URLWithString:self.homeViewModel.clientGlobalInfo.adEntryList[0][@"adEntryImgUrl"]] forState:UIControlStateNormal];
                [adBtn addTarget:self action:@selector(btnOnClickAd:) forControlEvents:UIControlEventTouchUpInside];
                [_adEntryView addSubview:adBtn];
                [adBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.top.mas_equalTo(self->_adEntryView);
                    make.width.mas_equalTo(AdaptationWidth(168));
                    make.height.mas_equalTo(AdaptationWidth(76));
                }];
                
                UIButton *adBtn2 = [[UIButton alloc]init];
                adBtn2.tag = 1032;
                [adBtn2 sd_setImageWithURL:[NSURL URLWithString:self.homeViewModel.clientGlobalInfo.adEntryList[1][@"adEntryImgUrl"]] forState:UIControlStateNormal];
                [adBtn2 addTarget:self action:@selector(btnOnClickAd:) forControlEvents:UIControlEventTouchUpInside];
                [_adEntryView addSubview:adBtn2];
                [adBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.top.mas_equalTo(self->_adEntryView);
                    make.width.mas_equalTo(AdaptationWidth(168));
                    make.height.mas_equalTo(AdaptationWidth(76));
                }];
                
                UIButton *adBtn3 = [[UIButton alloc]init];
                adBtn3.tag = 1033;
                [adBtn3 sd_setImageWithURL:[NSURL URLWithString:self.homeViewModel.clientGlobalInfo.adEntryList[2][@"adEntryImgUrl"]] forState:UIControlStateNormal];
                [adBtn3 addTarget:self action:@selector(btnOnClickAd:) forControlEvents:UIControlEventTouchUpInside];
                [_adEntryView addSubview:adBtn3];
                [adBtn3 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.bottom.mas_equalTo(self->_adEntryView);
                    make.height.mas_equalTo(AdaptationWidth(76));
                    make.width.mas_equalTo(AdaptationWidth(168));
                }];
                
                UIButton *adBtn4 = [[UIButton alloc]init];
                adBtn4.tag = 1034;
                [adBtn4 sd_setImageWithURL:[NSURL URLWithString:self.homeViewModel.clientGlobalInfo.adEntryList[3][@"adEntryImgUrl"]] forState:UIControlStateNormal];
                [adBtn4 addTarget:self action:@selector(btnOnClickAd:) forControlEvents:UIControlEventTouchUpInside];
                [_adEntryView addSubview:adBtn4];
                [adBtn4 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.bottom.mas_equalTo(self->_adEntryView);
                    make.height.mas_equalTo(AdaptationWidth(76));
                    make.width.mas_equalTo(AdaptationWidth(168));
                }];
            }
                break;
                
            default:
                break;
        }
     
    }
    return _adEntryView;
}
- (HighShareView *)highShareView{
    if (!_highShareView) {
        _highShareView = [[HighShareView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_highShareView setCornerValue:6];
        _highShareView.highListTitle = self.highTitle;
        _highShareView.highListAry = self.highListAry;
        [_highShareView creatInitTableView];
    }
    return _highShareView;
}
- (NSArray *)highListAry {
    if (!_highListAry) {
        _highListAry = [NSArray array];
    }
    return _highListAry;
}
- (ArtScrollView *)containerScrollView {
    if (!_containerScrollView) {
        _containerScrollView = [[ArtScrollView alloc] init];
        _containerScrollView.delegate = self;
        _containerScrollView.showsVerticalScrollIndicator = NO;
        _containerScrollView.backgroundColor = BackgroundColor;
//        _containerScrollView.autoresizingMask = UIViewAutoresizingNone;
    }
    return _containerScrollView;
}
- (WMPageController *)wMPageController{
    if (!_wMPageController) {
        _wMPageController = [[WMPageController alloc]init];
        _wMPageController.delegate = self;
        _wMPageController.dataSource = self;
        //        _wMPageController.titles = self.titleName;
        _wMPageController.viewControllerClasses = self.vcData;
        _wMPageController.titleSizeNormal = AdaptationWidth(16);
        _wMPageController.titleSizeSelected = AdaptationWidth(16);
        _wMPageController.menuViewStyle = WMMenuViewStyleLine;
        //    if (self.titleData.count < 7) {
        //        self.menuItemWidth = [UIScreen mainScreen].bounds.size.width / self.titleData.count;
        //    }else{
        //        self.menuItemWidth = [UIScreen mainScreen].bounds.size.width / 7;
        //    }
        _wMPageController.itemsWidths = self.titleWith;
        
        _wMPageController.titleColorSelected = blueColor;
        _wMPageController.titleColorNormal = LabelMainColor;
        _wMPageController.progressColor = blueColor;
        //    self.progressWidth = AdaptationWidth(36); // 这里可以设置不同的宽度
        _wMPageController.progressViewWidths = self.itemsWidthArry;
        _wMPageController.progressHeight = 4;
//        _wMPageController.view.backgroundColor = BackgroundColor;
        
    }
    return _wMPageController;
}
- (NSMutableArray *)titleData {
    if (!_titleData) {
        _titleData = [NSMutableArray array];
    }
    return _titleData;
}
- (NSMutableArray *)titleWith {
    if (!_titleWith) {
        _titleWith = [NSMutableArray array];
    }
    return _titleWith;
}
- (NSMutableArray *)itemsWidthArry {
    if (!_itemsWidthArry) {
        _itemsWidthArry = [NSMutableArray array];
    }
    return _itemsWidthArry;
}
- (NSMutableArray *)titleName {
    if (!_titleName) {
        _titleName = [NSMutableArray array];
    }
    return _titleName;
}
- (NSMutableArray *)vcData {
    if (!_vcData) {
        _vcData = [NSMutableArray array];
        
    }
    return _vcData;
}
- (HomeViewModel *)homeViewModel{
    if (!_homeViewModel) {
        _homeViewModel = [[HomeViewModel alloc]init];
        _homeViewModel.listType = @1;
        
    }
    return _homeViewModel;
}
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _bgView.backgroundColor = XColorWithRBBA(0, 0, 0, 0.3);
        
        [_bgView addSubview:self.collectionView];
    }
    return _bgView;
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, AdaptationWidth(324)) collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"HiBuyTypeCell"];
        [_collectionView registerClass:[UICollectionReusableView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:@"CollectionHeadTypeView"];
    }
    return _collectionView;
}


- (LaXinModel *)laXinModel{
    if (!_laXinModel) {
        _laXinModel = [[LaXinModel alloc]init];
    }
    return _laXinModel;
}
- (QRcodeView *)qrCodeView{
    if (!_qrCodeView) {
        _qrCodeView = [[[NSBundle mainBundle]loadNibNamed:@"QRcodeView" owner:nil options:nil]lastObject];
    }
    return _qrCodeView;
}
- (MyPersonShareView *)myPersonShareView{
    if (!_myPersonShareView) {
        _myPersonShareView = [[NSBundle mainBundle]loadNibNamed:@"MyPersonShareView" owner:nil options:nil].lastObject;
        _myPersonShareView.frame = [UIScreen mainScreen].bounds;
    }
    return _myPersonShareView;
}
- (void)dealloc{
    [XNotificationCenter removeObserver:HomeRedNotification];
    [XNotificationCenter removeObserver:self];
}
@end
