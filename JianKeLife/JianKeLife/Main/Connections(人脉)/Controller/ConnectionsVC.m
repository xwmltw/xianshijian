//
//  ConnectionsVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/19.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "ConnectionsVC.h"
#import "ExtendTableView.h"
#import "MyPersonTableView.h"
#import "ConnectionViewModel.h"
#import "MyPersonSecondVC.h"
#import "MyPersonShareView.h"
#import "XCommonHepler.h"
#import "RuleAlertView.h"
#import "UnLoginView.h"
#import "ProfitVC.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareSheetConfiguration.h>
#import "WXApi.h"
@interface ConnectionsVC ()
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UILabel *personNumLab;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *firstLab;
@property (weak, nonatomic) IBOutlet UILabel *secondLab;
@property (weak, nonatomic) IBOutlet UIButton *extendBtn;
@property (weak, nonatomic) IBOutlet UIButton *myPersonBtn;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *selectView;

@property (nonatomic ,strong) ExtendTableView *extendTableView;
@property (nonatomic ,strong) MyPersonTableView *myPersonTableView;
@property (nonatomic ,strong) ConnectionViewModel *connectionViewModel;
@property (nonatomic ,strong) MyPersonShareView *myPersonShareView;
@property (nonatomic ,strong) RuleAlertView *ruleAlertView;
@property (nonatomic ,strong) UnLoginView *unLoginView;
@end

@implementation ConnectionsVC
- (void)viewWillAppear:(BOOL)animated{
//- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    if (![UserInfo sharedInstance].isSignIn){
        WEAKSELF
        self.unLoginView.hidden = NO;
        [self.unLoginView setBtnBlock:^(id result) {
            [weakSelf goToLogin];
        }];
        
    }else{
        self.unLoginView.hidden = YES;
        [self getData];
        UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
        statusBar.backgroundColor = XColorWithRGB(171, 216, 255);
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    statusBar.backgroundColor = [UIColor clearColor];
}

- (IBAction)btnOnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 301:
        {

            self.extendBtn.selected = YES;
            self.myPersonBtn.selected = NO;
            self.lineView.X = self.selectView.Sw/4-20;
            self.extendTableView.hidden = NO;
            self.myPersonTableView.hidden = YES;
        }
            break;
        case 302:
        {
            self.extendBtn.selected = NO;
            self.myPersonBtn.selected = YES;
            
            self.lineView.X = self.selectView.Sw/4*3-20;
            
            self.extendTableView.hidden = YES;
            self.myPersonTableView.hidden = NO;
        }
            break;
        case 303:
        {
            ProfitVC *vc = [[ProfitVC alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self.headerView setCornerValue:2];
    [self.selectView setCornerValue:2];
    [self.firstLab setBorderWidth:1 andColor:LabelAssistantColor];
    [self.firstLab setCornerValue:2];
    [self.secondLab setBorderWidth:1 andColor:LabelAssistantColor];
    [self.secondLab setCornerValue:2];
    
    self.extendTableView.hidden = NO;
    [self.extendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.selectView).offset (AdaptationWidth(10));
        make.centerX.mas_equalTo(self.selectView).multipliedBy(0.5);
    }];
    [self.myPersonBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.selectView).offset (AdaptationWidth(10));
        make.centerX.mas_equalTo(self.selectView).multipliedBy(1.5);
    }];
    
    
}
- (void)getData{
    [self.connectionViewModel requestData];
    BLOCKSELF
    [self.connectionViewModel setConnectionRequestBlcok:^(id result) {
        blockSelf.moneyLab.text = [NSString stringWithFormat:@"%.2f",[blockSelf.connectionViewModel.connectionModel.profitAmt doubleValue]/100];
        blockSelf.personNumLab.text = [NSString stringWithFormat:@"已邀请人脉%@人",blockSelf.connectionViewModel.connectionModel.totalCount.description];
        blockSelf.firstLab.text = [NSString stringWithFormat:@"一级%@人",blockSelf.connectionViewModel.connectionModel.firstConnectionsCount.description];
        blockSelf.secondLab.text = [NSString stringWithFormat:@"二级%@人",blockSelf.connectionViewModel.connectionModel.secondConnectionsCount.description];
        blockSelf.extendTableView.firstCut = blockSelf.connectionViewModel.connectionModel.firstCut;
        [blockSelf.extendTableView reloadData];
    }];
}
#pragma block回调
- (XIntegerBlock)extendCellBlcok{
    BLOCKSELF
    XIntegerBlock blcok = ^(NSInteger result){
        switch (result) {
            case 0:
            {
               
                
                [[UIApplication sharedApplication].keyWindow addSubview: blockSelf.myPersonShareView];
//                [blockSelf.myPersonShareView mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.edges.mas_equalTo(blockSelf.view);
//                }];
                blockSelf.myPersonShareView.QRImageView.image = [UIImage qrCodeImageWithInfo:blockSelf.connectionViewModel.connectionModel.connectionsInviteRegUrl width:AdaptationWidth(85)];
                blockSelf.myPersonShareView.hidden = NO;
                blockSelf.myPersonShareView.QRMainBGView.hidden = NO;
                blockSelf.myPersonShareView.btnBlock = [blockSelf shareViewBtnBlock];
            }
                break;
            case 1:
            {
                [[UIApplication sharedApplication].keyWindow addSubview: blockSelf.myPersonShareView];
                blockSelf.myPersonShareView.QRImageView.image = [UIImage qrCodeImageWithInfo:blockSelf.connectionViewModel.connectionModel.connectionsInviteRegUrl width:AdaptationWidth(85)];
                blockSelf.myPersonShareView.hidden = NO;
                blockSelf.myPersonShareView.QRMainBGView.hidden = YES;
                blockSelf.myPersonShareView.btnBlock = [blockSelf shareViewBtnBlock];
            }
                break;
            case 2:
            {
//                [[UIApplication sharedApplication].keyWindow addSubview: blockSelf.myPersonShareView];
//                blockSelf.myPersonShareView.QRImageView.image = [UIImage qrCodeImageWithInfo:blockSelf.connectionViewModel.connectionModel.connectionsInviteRegUrl width:AdaptationWidth(85)];
//                blockSelf.myPersonShareView.hidden = NO;
//                blockSelf.myPersonShareView.QRMainBGView.hidden = YES;
//                blockSelf.myPersonShareView.btnBlock = [blockSelf shareViewBtnBlock];
                blockSelf.ruleAlertView.hidden = NO;
            }
                break;
                
            default:
                break;
        }
    };
    return blcok;
}
- (XBlock)MyPersonFirstBlock{
    BLOCKSELF
    XBlock Blcok = ^(id result){
        MyPersonSecondVC *vc = [[MyPersonSecondVC alloc]init];
        vc.model = result;
        vc.hidesBottomBarWhenPushed = YES;
        [blockSelf.navigationController pushViewController:vc animated:YES];
    };
    return Blcok;
}
- (XBlock)shareViewBtnBlock{
    BLOCKSELF
    XBlock block = ^(UIButton *btn){
        switch (btn.tag) {
            case 3021:
            {
                [[XCommonHepler sharedInstance] saveImageToPhotoLib:[UIImage convertViewToImage:blockSelf.myPersonShareView.QRDownBGView]];
            }
                break;
            case 3022:
            {
                if (![WXApi isWXAppInstalled]) {
                    [ProgressHUD showProgressHUDInView:nil withText:@"未安装微信" afterDelay:1 ];
                    return ;
                }
                NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
                [shareParams SSDKSetupShareParamsByText:@"购物省钱，分享赚钱 开启你的值享生活"
                                                 images:[UIImage convertViewToImage:blockSelf.myPersonShareView.QRDownBGView]
                                                    url:[NSURL URLWithString:blockSelf.connectionViewModel.connectionModel.connectionsInviteRegUrl]
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
                                                    url:[NSURL URLWithString:blockSelf.connectionViewModel.connectionModel.connectionsInviteRegUrl]
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
#pragma  mark - 懒加载
- (ExtendTableView *)extendTableView{
    if (!_extendTableView) {
        _extendTableView = [[ExtendTableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        [self.view addSubview:_extendTableView];
        [_extendTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view).offset(10);
            make.right.mas_equalTo(self.view).offset(-10);
            make.top.mas_equalTo(self.selectView.mas_bottom);
            make.height.mas_equalTo(AdaptationWidth(340));
        }];
        [_extendTableView setExtendCellSelectBlcok:[self extendCellBlcok]];
        BLOCKSELF
        [_extendTableView setExtendBtnSelectBlcok:^(id result) {
            blockSelf.ruleAlertView.hidden = NO;
            
        }];
    }
    return _extendTableView;
}
- (MyPersonTableView *)myPersonTableView{
    if (!_myPersonTableView) {
        _myPersonTableView = [[MyPersonTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:_myPersonTableView];
        [_myPersonTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view).offset(10);
            make.right.mas_equalTo(self.view).offset(-10);
            make.top.mas_equalTo(self.selectView.mas_bottom);
            make.bottom.mas_equalTo(self.view);
        }];
        _myPersonTableView.connectionCellSelectBlock = [self MyPersonFirstBlock];
    }
    return _myPersonTableView;
}


- (ConnectionViewModel *)connectionViewModel{
    if (!_connectionViewModel) {
        _connectionViewModel = [[ConnectionViewModel alloc]init];
    }
    return _connectionViewModel;
}
- (MyPersonShareView *)myPersonShareView{
    if (!_myPersonShareView) {
        _myPersonShareView = [[NSBundle mainBundle]loadNibNamed:@"MyPersonShareView" owner:nil options:nil].lastObject;
        _myPersonShareView.frame = [UIScreen mainScreen].bounds;
    }
    return _myPersonShareView;
}
- (RuleAlertView *)ruleAlertView{
    if (!_ruleAlertView) {
        _ruleAlertView = [[NSBundle mainBundle]loadNibNamed:@"RuleAlertView" owner:nil options:nil].lastObject;
        _ruleAlertView.frame = [UIScreen mainScreen].bounds;
        [[UIApplication sharedApplication].keyWindow addSubview: _ruleAlertView];
        _ruleAlertView.labContent.text = _connectionViewModel.connectionModel.ruleText;
        BLOCKSELF
        [_ruleAlertView setRuleBtnBlcok:^(id result) {
            blockSelf.ruleAlertView.hidden = YES;
        }];
    }
    return _ruleAlertView;
}
- (UnLoginView *)unLoginView{
    if (!_unLoginView) {
        _unLoginView = [[NSBundle mainBundle]loadNibNamed:@"UnLogin" owner:nil options:nil].lastObject;
        [self.view addSubview: _unLoginView];
        [_unLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
        _unLoginView.hidden = NO;
    }
    return _unLoginView;
}
@end
