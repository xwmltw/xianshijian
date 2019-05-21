//
//  HomeVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/18.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "HomeVC.h"
#import "HomeCollectionView.h"
#import "JobDetailVC.h"
#import "SearchVC.h"
#import "BaseWebVC.h"
#import "SpecialJobListVC.h"
#import "WSLWaterFlowLayout.h"
#import <ShareSDK/ShareSDK.h>
#import "LaXinView.h"
#import "LaXinModel.h"
#import "WXApi.h"
#import "JobDetailViewModel.h"
#import "QRcodeView.h"
#import "XCommonHepler.h"
#import "MyPersonShareView.h"
#import "MessageVC.h"

#import "HomeMainVC.h"

@interface HomeVC ()<WSLWaterFlowLayoutDelegate>
{
     WSLWaterFlowLayout * _flow;
}
@property (nonatomic ,strong) HomeCollectionView *collectionView;

@property (nonatomic ,strong) LaXinModel *laXinModel;
@property (nonatomic ,strong) LaXinView *laXinView;
@property (nonatomic ,strong) QRcodeView *qrCodeView;
@property (nonatomic ,strong) JobDetailViewModel *viewModel;
@property (nonatomic ,strong) MyPersonShareView *myPersonShareView;
@end

@implementation HomeVC
- (void)setBackNavigationBarItem{};
- (void)viewDidLoad {
    [super viewDidLoad];
    WEAKSELF
    [XNetWork requestNetWorkWithUrl:Xget_global_info andModel:nil andSuccessBlock:^(ResponseModel *model) {
        ClientGlobalInfo *clientGlobalInfo = [[ClientGlobalInfo alloc]init];
        clientGlobalInfo = [ClientGlobalInfo mj_objectWithKeyValues:model.data];
        [clientGlobalInfo setClientGlobalInfoModel];

        [weakSelf getData];
    } andFailBlock:^(id result) {
        
    }];
    
    
    
    
}
- (void)getData{
    

    [self creatSearchBtn];
    _flow = [[WSLWaterFlowLayout alloc] init];
    _flow.delegate = self;
    _flow.flowLayoutStyle = WSLWaterFlowVerticalEqualWidth;
    self.collectionView = [[HomeCollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:_flow];
    if (self.clientGlobalInfo.bannerAdList.count) {
        [self.collectionView.headArray addObject:@(HomeCollectionHeadBanner)];
    }
    if (self.clientGlobalInfo.specialEntryList.count) {
        [self.collectionView.headArray addObject:@(HomeCollectionHeadSpecial)];
    }
    
    [self.collectionView.headArray addObject:@(HomeCollectionHeadHot)];
    HomeMainVC *vc = [[HomeMainVC alloc]init];
  
    self.view  = vc.view;
    [self scrollViewSelect];
    [self specialViewSelect];
    [self collectionCellSelect];
    
    if (self.clientGlobalInfo.versionInfo)
    [XAlertView alertWithTitle:@"更新提示" message:self.clientGlobalInfo.versionInfo.versionDesc cancelButtonTitle:self.clientGlobalInfo.versionInfo.needForceUpdate.integerValue ? @"":@"取消"confirmButtonTitle:@"更新" viewController:self completion:^(UIAlertAction *action, NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:self.clientGlobalInfo.versionInfo.url]];
            exit(0);
        }
    }];
    

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



- (void)creatSearchBtn{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    
    UIButton *searchBtn = [[UIButton alloc]init];
    searchBtn.tag = 1001;
    searchBtn.frame = CGRectMake(0, 7, AdaptationWidth(325), 30);
    [searchBtn setBackgroundColor:LineColor];
    [searchBtn setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
    [searchBtn setTitle:@"输入关键词" forState:UIControlStateNormal];
    [searchBtn setTitleColor:LabelAssistantColor forState:UIControlStateNormal];
    [searchBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
    [searchBtn addTarget:self action:@selector(btnOnClock:) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setCornerValue:4];
    [bgView addSubview:searchBtn];
    
    UIButton *messageBtn = [[UIButton alloc]init];
    messageBtn.tag = 1002;
    messageBtn.frame = CGRectMake(ScreenWidth-AdaptationWidth(44), 8, AdaptationWidth(28), AdaptationWidth(28));
    [messageBtn setImage:[UIImage imageNamed:@"icon_noti_message"] forState:UIControlStateNormal];
    [messageBtn addTarget:self action:@selector(btnOnClock:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:messageBtn];
    
    self.navigationItem.titleView = bgView;
}
- (void)scrollViewSelect{
    WEAKSELF
    [self.collectionView.homeViewModel setResponseBannerWebBlock:^(id result) {
        BaseWebVC *vc = [[BaseWebVC alloc]init];
        [vc reloadForGetWebView:result];
        
//        [vc.webParentView setScriptBlock:^(id result) {
//            [weakSelf webViewWithScript:result];
//        }];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
}
- (void)specialViewSelect{
    BLOCKSELF
    [self.collectionView.homeViewModel setResponseHotWebBlock:^(id result) {
        BaseWebVC *vc = [[BaseWebVC alloc]init];
        [vc reloadForGetWebView:result];
        vc.hidesBottomBarWhenPushed = YES;
        [blockSelf.navigationController pushViewController:vc animated:YES];
    }];
    self.collectionView.homeViewModel.responseHotBlock = ^(NSNumber *result ,NSNumber *row) {
        SpecialJobListVC *vc = [[SpecialJobListVC alloc]init];
        vc.title = blockSelf.clientGlobalInfo.specialEntryList[row.integerValue][@"specialEntryTitle"];
        vc.specialId = result;
        vc.hidesBottomBarWhenPushed = YES;
        [blockSelf.navigationController pushViewController:vc animated:YES];
    };
}
- (void)collectionCellSelect{

    WEAKSELF
    self.collectionView.collectionSelectBlock = ^(NSDictionary *result) {

        JobDetailVC *vc = [[JobDetailVC alloc]init];
        vc.productNo = result[@"productNo"];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
}
- (void)btnOnClock:(UIButton *)btn{
    
    
    if (btn.tag == 1001) {
        SearchVC *vc = [[SearchVC alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        MessageVC *vc = [[MessageVC alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
}
//#pragma mark - js交互
//- (void)webViewWithScript:(WKScriptMessage *)message{
//    if ([message.name isEqualToString:@"triggerAppMethod_laxin_XCX"]) {
//        if (![WXApi isWXAppInstalled]) {
//            [ProgressHUD showProgressHUDInView:nil withText:@"未安装微信" afterDelay:1 ];
//            return ;
//        }
////        小程序分享
//        NSDictionary *dic = [message.body mj_JSONObject];
//
//        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
//        [shareParams SSDKSetupWeChatMiniProgramShareParamsByTitle:AppName
//                                                      description:AppName
//                                                       webpageUrl:[NSURL URLWithString:@"https://www.baidu.com/"]
//                                                             path:dic[@"page"]
//                                                       thumbImage:nil
//                                                     hdThumbImage:[UIImage imageNamed:@"LaunchScreen_LOGO"]
//                                                         userName:dic[@"userName"]
//                                                  withShareTicket:YES
//                                                  miniProgramType:[dic[@"type"] integerValue]
//                                               forPlatformSubType:SSDKPlatformSubTypeWechatSession];
//        [ShareSDK share:SSDKPlatformSubTypeWechatSession parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
//
//        }];
//    }
//}
#pragma  mark - WSLWaterFlowLayout delegate

//返回每个item大小
- (CGSize)waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
   NSString *str = self.collectionView.homeViewModel.productList[indexPath.row][@"productTitle"];
    CGSize detailSize = [str boundingRectWithSize:CGSizeMake(AdaptationWidth(100), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:nil context:nil].size;
     if (detailSize.height < 14) {
        return CGSizeMake(0, AdaptationWidth(205));
    }
    return CGSizeMake(0, AdaptationWidth(225));
    
}

/** 头视图Size */
-(CGSize )waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout sizeForHeaderViewInSection:(NSInteger)section{
    HomeCollectionHead row = [self.collectionView.headArray[section]integerValue];
    switch (row) {
        case HomeCollectionHeadBanner:{
            if (self.clientGlobalInfo.bannerAdList.count) {
                return CGSizeMake(self.view.Sw, AdaptationWidth(130));
            }else{
                return CGSizeMake(self.view.Sw, 0.1);
            }
            
        }
            break;
        case HomeCollectionHeadSpecial:{
            if (self.clientGlobalInfo.specialEntryList.count) {
                return CGSizeMake(self.view.Sw, AdaptationWidth(90));
            }else{
                return CGSizeMake(self.view.Sw, 0.1);
            }
            
        }
            break;
        case HomeCollectionHeadHot:{
            return CGSizeMake(self.view.Sw, AdaptationWidth(40));
        }
            break;
        default:
            break;
    }
    return CGSizeZero;
}
/** 脚视图Size */
-(CGSize )waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout sizeForFooterViewInSection:(NSInteger)section{
    HomeCollectionHead row = [self.collectionView.headArray[section] integerValue];
    if (row == HomeCollectionHeadHot) {
        if (self.collectionView.homeViewModel.productList.count == 0) {
            return CGSizeMake(self.view.Sw, AdaptationWidth(289));
        }
    }
    return CGSizeZero;
}

///** 列数*/
//-(CGFloat)columnCountInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
//    return 3;
//}
///** 行数*/
//-(CGFloat)rowCountInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
//    return 5;
//}
/** 列间距*/
-(CGFloat)columnMarginInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return 5;
}
/** 行间距*/
-(CGFloat)rowMarginInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return 5;
}
/** 边缘之间的间距*/
-(UIEdgeInsets)edgeInsetInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
/*
 #pragma mark - Navi;gation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
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
@end
