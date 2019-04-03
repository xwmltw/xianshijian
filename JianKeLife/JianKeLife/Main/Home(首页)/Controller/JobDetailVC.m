//
//  JobDetailVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/20.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "JobDetailVC.h"
#import "JobDetailTableView.h"
#import "BaseWebVC.h"
#import "QRcodeView.h"
#import "XCommonHepler.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareSheetConfiguration.h>
@interface JobDetailVC ()
@property (nonatomic ,strong) JobDetailTableView *tableView;
@property (nonatomic ,strong) QRcodeView *qrCodeView;
@end

@implementation JobDetailVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.tableView.jobDetailViewModel requestDetialData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[JobDetailTableView alloc]initWithFrame:CGRectMake(0, -20, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.jobDetailViewModel.productModel.productNo = self.productNo;
    
    [self.view addSubview: self.tableView];

    UIButton *balckBtn = [[UIButton alloc]init];
    balckBtn.tag = 1011;
    [balckBtn setCornerValue:AdaptationWidth(20)];
    [balckBtn setBackgroundImage:[UIImage createImageWithColor:XColorWithRBBA(255, 255, 255, 0.13)] forState:UIControlStateNormal];
    [balckBtn setImage:[UIImage imageNamed:@"icon_back-white"] forState:UIControlStateNormal];
    [balckBtn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:balckBtn];
    [balckBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(30);
        make.left.mas_equalTo(self.view).offset(16);
        make.height.width.mas_equalTo(AdaptationWidth(40));
    }];
    
    
    UIButton *shareBtn = [[UIButton alloc]init];
    shareBtn.tag = 1012;
    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [shareBtn setBackgroundColor:blueColor];
    [shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(AdaptationWidth(48));
        make.width.mas_equalTo(AdaptationWidth(188));
    }];
    
    UIButton *shareSalary = [[UIButton alloc]init];
    [shareSalary setBackgroundImage:[UIImage imageNamed:@"Detail_share_background"] forState:UIControlStateNormal];
    [shareSalary.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(12)]];
    [shareSalary setTitle:@"领￥1.20" forState:UIControlStateNormal];
    [shareSalary setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:shareSalary];
    [shareSalary mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(shareBtn).offset(AdaptationWidth(-7));
        make.top.mas_equalTo(shareBtn).offset(AdaptationWidth(-10));
        make.height.mas_equalTo(AdaptationWidth(21));
        make.width.mas_equalTo(AdaptationWidth(74));
    }];
    
    UIButton *recevieBtn = [[UIButton alloc]init];
    recevieBtn.tag = 1013;
    recevieBtn.enabled = YES;
    [recevieBtn setTitle:@"去领取" forState:UIControlStateNormal];
    [recevieBtn setBackgroundColor:RedColor];
    [recevieBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [recevieBtn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:recevieBtn];
    [recevieBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(AdaptationWidth(48));
        make.width.mas_equalTo(AdaptationWidth(188));
    }];
     
     [self.tableView.jobDetailViewModel setProductStateBlock:^(ProductModel *model) {
         [shareSalary setTitle:[NSString stringWithFormat:@"领￥%.2f",[model.productShareSalary doubleValue]/100] forState:UIControlStateNormal];
         model.hasApplyProd.integerValue ?
         [recevieBtn setTitle:@"已领取 去办理" forState:UIControlStateNormal] :
         [recevieBtn setTitle:[NSString stringWithFormat:@"去领取￥%.2f",[model.productSalary doubleValue]/100] forState:UIControlStateNormal];
         if (model.hasApplyProd.integerValue && model.prodTradeStatus.integerValue == 3) {
             if (model.prodTradeAuditStatus.integerValue == 1 || model.prodTradeAuditStatus.integerValue == 2) {
                 recevieBtn.enabled = NO;
                 [recevieBtn setBackgroundColor:[UIColor grayColor]];
                
             }
         }

     }];
}
-(void)btnOnClick:(UIButton *)btn{
    
    switch (btn.tag) {
        case 1011:
        {
            
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case 1012:
        {
            
            if(![[UserInfo sharedInstance]isSignIn]){
                [self getBlackLogin:self];
                return;
            }
            [self.tableView.jobDetailViewModel requestShareData];
            BLOCKSELF
            [self.tableView.jobDetailViewModel setProductShareBlock:^(NSDictionary *result) {
                [blockSelf goToShare:result];
            }];

        }
            break;
        case 1013:
        {
            if(![[UserInfo sharedInstance]isSignIn]) [self getBlackLogin:self];
            
            [XAlertView alertWithTitle:@"提示"
                               message:self.tableView.jobDetailViewModel.productModel.hasApplyProd.integerValue ? @"您已领取过返佣资格，确认将直接跳转至产品体验链接" : @"确认领取返佣资格？"
                     cancelButtonTitle:@"取消"
                    confirmButtonTitle:@"确定"
                        viewController:self
                            completion:^(UIAlertAction *action, NSInteger buttonIndex) {
                if (buttonIndex == 1) {
                    if (self.tableView.jobDetailViewModel.productModel.hasApplyProd.integerValue) {
                        BaseWebVC *vc = [[BaseWebVC alloc]init];
                        [vc reloadForGetWebView:[self.tableView.jobDetailViewModel getProductUrl]];
                        [self.navigationController pushViewController:vc animated:YES];
                        return ;
                    }
                    [self.tableView.jobDetailViewModel requestReceive];
                    BLOCKSELF
                    [self.tableView.jobDetailViewModel setProductReceiveBlock:^(id result) {
                        BaseWebVC *vc = [[BaseWebVC alloc]init];
                        [vc reloadForGetWebView:[blockSelf.tableView.jobDetailViewModel getProductUrl]];
                        [blockSelf.navigationController pushViewController:vc animated:YES];
                    }];
                    
                }
            }];
        }
            break;
            
        default:
            break;
    }
}

- (void)goToShare:(NSDictionary *)dic{
    
    self.qrCodeView.hidden = NO;
    [self.qrCodeView.QRcodeMainView setCornerValue:8];
    self.qrCodeView.QRtitle.text = self.tableView.jobDetailViewModel.productModel.productTitle;
    self.qrCodeView.QRmoney.text = [NSString stringWithFormat:@"%.2f",[self.tableView.jobDetailViewModel.productModel.productSalary doubleValue]/100];
    [self.qrCodeView.QRimageView sd_setImageWithURL:[NSURL URLWithString:self.tableView.jobDetailViewModel.productModel.productMainPicUrl.firstObject]];
    self.qrCodeView.QRcodeImageView.image = [UIImage qrCodeImageWithInfo:dic[@"productShareUrl"] width:AdaptationWidth(85)];
    [self.view addSubview:self.qrCodeView];
    [self.qrCodeView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
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
                MyLog(@"%@",dic[@"productShareUrl"]);
                NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
                [shareParams SSDKSetupShareParamsByText:blockSelf.tableView.jobDetailViewModel.productModel.productGroupOrientedDesc
                                                 images:[UIImage convertViewToImage:blockSelf.qrCodeView.QRcodeDownView]
                                                    url:[NSURL URLWithString:dic[@"productShareUrl"]]
                                                  title:blockSelf.tableView.jobDetailViewModel.productModel.productTitle
                                                   type:SSDKContentTypeAuto];
                [ShareSDK share:SSDKPlatformSubTypeWechatSession parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                    
                }];
            }
                break;
            case 1023:
            {
                NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
                [shareParams SSDKSetupShareParamsByText:blockSelf.tableView.jobDetailViewModel.productModel.productGroupOrientedDesc
                                                 images:[UIImage convertViewToImage:blockSelf.qrCodeView.QRcodeDownView]
                                                    url:[NSURL URLWithString:dic[@"productShareUrl"]]
                                                  title:blockSelf.tableView.jobDetailViewModel.productModel.productTitle
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
    
//    return;
//    NSArray *imageArry = @[[UIImage imageNamed:@"icon_my_红包"]];
//    if (imageArry) {
//        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
//        [shareParams SSDKSetupShareParamsByText:dic[@"productTitle"]
//                                         images:imageArry
//                                            url:[NSURL URLWithString:dic[@"productShareUrl"]]
//                                          title:dic[@"productTitle"]
//                                           type:SSDKContentTypeAuto];
//
//
//
//        SSUIShareSheetConfiguration *config = [[SSUIShareSheetConfiguration alloc]init];
//        //设置分享菜单为简洁样式
//        config.style = SSUIActionSheetStyleSystem;
//
//        //设置竖屏有多少个item平台图标显示
//        config.columnPortraitCount = 5;
//
//        //设置横屏有多少个item平台图标显示
//        config.columnLandscapeCount = 8;
//
//        //设置取消按钮标签文本颜色
//        config.cancelButtonTitleColor = LabelMainColor;
//
//
//        //设置对齐方式（简约版菜单无居中对齐）
//        config.itemAlignment = SSUIItemAlignmentCenter;
//
//        //设置标题文本颜色
//        config.itemTitleColor = LabelMainColor;
//
//        //设置分享菜单栏状态栏风格
//        config.statusBarStyle = UIStatusBarStyleDefault;
//
//        //设置支持的页面方向（单独控制分享菜单栏）
//        config.interfaceOrientationMask = UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationMaskLandscape;
//
//        //设置分享菜单栏的背景颜色
//        config.menuBackgroundColor = [UIColor whiteColor];
//
//        //取消按钮是否隐藏，默认不隐藏
//        //                config.cancelButtonHidden = YES;
//
//        //设置直接分享的平台（不弹编辑界面）
//        //                config.directSharePlatforms = @[@(SSDKPlatformTypeSinaWeibo),@(SSDKPlatformTypeTwitter)];
//
//
//
//
//        //2.弹出分享菜单
//        [ShareSDK showShareActionSheet:nil
//                           customItems:nil
//                           shareParams:shareParams
//                    sheetConfiguration:config
//                        onStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType,
//                                         NSDictionary *userData, SSDKContentEntity *contentEntity,
//                                         NSError *error, BOOL end) {
//                            switch (state) {
//                                case SSDKResponseStateSuccess:
//                                {
//                                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
//                                                                                        message:nil
//                                                                                       delegate:nil
//                                                                              cancelButtonTitle:@"确定"
//                                                                              otherButtonTitles:nil];
//                                    [alertView show];
//                                }
//                                    break;
//                                case SSDKResponseStateFail:
//                                {
//                                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
//                                                                                    message:[NSString stringWithFormat:@"%@",error]
//                                                                                   delegate:nil
//                                                                          cancelButtonTitle:@"OK"
//                                                                          otherButtonTitles:nil, nil];
//                                    [alert show];
//                                }
//                                    break;
//                                case SSDKResponseStateCancel:{
//                                    self.qrCodeView.hidden = YES;
//                                }
//                                    return ;
//                                default:
//                                    break;
//                            }
//
//                        }];
//
//    }
}
- (QRcodeView *)qrCodeView{
    if (!_qrCodeView) {
        _qrCodeView = [[[NSBundle mainBundle]loadNibNamed:@"QRcodeView" owner:nil options:nil]lastObject];
    }
    return _qrCodeView;
}
@end
