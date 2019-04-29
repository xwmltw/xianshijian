//
//  MyTaskVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/4/20.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "MyTaskVC.h"
#import "MytasktableViewVC.h"
#import "TaskReturnVC.h"
#import "TaskDetailVC.h"
#import "TaskResultVC.h"
#import "JobDetailVC.h"

#import "LaXinView.h"
#import "LaXinModel.h"
#import "BaseWebVC.h"
#import "JobDetailViewModel.h"
#import "QRcodeView.h"
#import "XCommonHepler.h"
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
@interface MyTaskVC ()<WMPageControllerDataSource>
@property (nonatomic, strong) NSArray *titleData;
@property (nonatomic ,strong) LaXinModel *laXinModel;
@property (nonatomic ,strong) LaXinView *laXinView;
@property (nonatomic ,strong) QRcodeView *qrCodeView;
@property (nonatomic ,strong)JobDetailViewModel *viewModel;
@property (nonatomic ,copy) NSString *productNo;
@end

@implementation MyTaskVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
/**
 创建返回按钮
 */
-(void)setBackNavigationBarItem{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 64, 44)];
    view.userInteractionEnabled = YES;
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_back"]];
    imageV.frame = CGRectMake(0, 8, 28, 28);
    imageV.userInteractionEnabled = YES;
    [view addSubview:imageV];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 64, 44);
    button.tag = 9999;
    [button addTarget:self action:@selector(BarbuttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:view];
    self.navigationItem.leftBarButtonItem = item;
    UIView *ringhtV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 64, 44)];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:ringhtV];
    self.navigationItem.rightBarButtonItem = rightItem;
}
/**
 导航栏按钮的点击事件
 
 @param button 被点击的导航栏按钮 tag：9999 表示返回按钮
 */
-(void)BarbuttonClick:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewDidLoad {
    self.titles = self.titleData;
    self.viewControllerClasses = [NSArray arrayWithObjects:[MytasktableViewVC class], [MytasktableViewVC class],[MytasktableViewVC class],[MytasktableViewVC class], nil];
    self.titleSizeNormal = AdaptationWidth(16);
    self.titleSizeSelected = AdaptationWidth(16);
    self.menuViewStyle = WMMenuViewStyleLine;
    self.menuItemWidth = [UIScreen mainScreen].bounds.size.width / self.titleData.count;
    self.titleColorSelected = blueColor;
    self.titleColorNormal = LabelMainColor;
    self.progressColor = blueColor;
    self.progressWidth = AdaptationWidth(36); // 这里可以设置不同的宽度
    self.progressHeight = 4;//下划线的高度，需要WMMenuViewStyleLine样式
    
    self.selectIndex = self.wmPageSelect;
    
    
    //这里注意，需要写在最后面，要不然上面的效果不会出现
    [super viewDidLoad];
    self.title = @"我的任务";
    
    [self setBackNavigationBarItem];
    
    [TalkingData trackEvent:@"我的任务"];
}

#pragma mark - Datasource & Delegate

#pragma mark 返回子页面的个数
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titleData.count;
}

#pragma mark 返回某个index对应的页面
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    
    switch (index) {
        case 0:{
            
            MytasktableViewVC   *vcClass = [[MytasktableViewVC alloc] init];
            vcClass.taskViewModel.taskType = MyTaskTableViewTypeAll;
            vcClass.taskStayBtnBlcok = [self taskBtnBlcok];
            vcClass.taskStayCellselect = [self taskOverCellBlock];
            return vcClass;
        }
            
            break;
        case 1:{
            
            MytasktableViewVC *vcClass = [MytasktableViewVC new];
            vcClass.taskViewModel.taskType = MyTaskTableViewTypeStay;
            vcClass.taskStayBtnBlcok = [self taskBtnBlcok];
            vcClass.taskStayCellselect = [self taskOverCellBlock];
            return vcClass;
            
        }
            break;
        case 2:{
            
            MytasktableViewVC *vcClass = [MytasktableViewVC new];
            vcClass.taskViewModel.taskType = MyTaskTableViewTypeIng;
            vcClass.taskStayBtnBlcok = [self taskBtnBlcok];
            vcClass.taskStayCellselect = [self taskOverCellBlock];
            return vcClass;
            
        }
            break;
        case 3:{
            MytasktableViewVC *vcClass = [MytasktableViewVC new];
            vcClass.taskViewModel.taskType = MyTaskTableViewTypeOver;
            vcClass.taskStayBtnBlcok = [self taskResultBlcok];
            vcClass.taskStayCellselect = [self taskOverCellBlock];
            return vcClass;
        }
            break;
        default:
            
            break;
    }
    return nil;
    
}

#pragma mark 返回index对应的标题
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    return self.titleData[index];
}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView{
    return CGRectMake(0, AdaptationWidth(42), ScreenWidth, ScreenHeight-AdaptationWidth(42));
}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView{
    return CGRectMake(0, 0, ScreenWidth, AdaptationWidth(42));
}

#pragma mark -点击回调
-(XDoubleBlock)taskBtnBlcok{
    BLOCKSELF
    XDoubleBlock block = ^(UIButton * btn,NSDictionary *dic){
        switch (btn.tag) {
            case 202:
            {
                [TalkingData trackEvent:@"我的任务-点击【去返佣】"];
                TaskReturnVC *vc = [[TaskReturnVC alloc]init];
                vc.productNo = dic[@"productNo"];
                blockSelf.productNo = dic[@"productNo"];
                vc.productApplyId = dic[@"productApplyId"];
                vc.productSubmitType = dic[@"productSubmitType"];
                vc.hidesBottomBarWhenPushed = YES;
                WEAKSELF
                [vc setReBlock:^(id result) {
                    [weakSelf laXinNoti:1];
                }];
                [blockSelf.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 203:
            {
                [TalkingData trackEvent:@"我的任务-点击【审核详情】"];
                TaskDetailVC *vc = [[TaskDetailVC alloc]init];
                vc.model = [TaskModel mj_objectWithKeyValues:dic];
                vc.hidesBottomBarWhenPushed = YES;
                [blockSelf.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 204:{
                [TalkingData trackEvent:@"我的任务-点击【审核结果】"];
                TaskResultVC*vc = [[TaskResultVC alloc]init];
                vc.resultModel = [TaskModel mj_objectWithKeyValues:dic];
                vc.hidesBottomBarWhenPushed = YES;
                [blockSelf.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }
        
    };
    
    return block;
}
//结果
-(XDoubleBlock)taskResultBlcok{
    BLOCKSELF
    XDoubleBlock block = ^(UIButton * btn,id result){
        [TalkingData trackEvent:@"我的任务-点击【审核结果】"];
        TaskResultVC*vc = [[TaskResultVC alloc]init];
        vc.resultModel = [TaskModel mj_objectWithKeyValues:result];
        vc.hidesBottomBarWhenPushed = YES;
        [blockSelf.navigationController pushViewController:vc animated:YES];
    };
    return block;
}
//任务详情
- (XBlock)taskOverCellBlock{
    WEAKSELF
    XBlock block = ^(NSString *proid){
        [TalkingData trackEvent:@"我的任务-点击【任务详情】"];
        JobDetailVC *vc = [[JobDetailVC alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.productNo  = proid;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    return block;
}
- (void)laXinNoti:(NSInteger)row{
    //拉新
    WEAKSELF
    [XNetWork requestNetWorkWithUrl:Xintroduce_new_complete_data andModel:nil andSuccessBlock:^(ResponseModel *model) {
        weakSelf.laXinModel = [LaXinModel mj_objectWithKeyValues:model.data];
        if (!weakSelf.laXinModel.isFinished.integerValue) {
            
            
            weakSelf.laXinView = [[NSBundle mainBundle]loadNibNamed:@"LaXinView" owner:nil options:nil].lastObject;
            weakSelf.laXinView.titleLab2.text = row ==1 ? @"哇，恭喜你提交成功，现在分享还能活动额外现金奖励哦~":@"继续分享到群，奖励金额将会大大增加，上不封顶";
            weakSelf.laXinView.detailLab.hidden = YES;
            weakSelf.laXinView.headImage.hidden = YES;
            weakSelf.laXinView.titleLab.hidden = YES;
            weakSelf.laXinView.mainImage.image = row == 1 ? [UIImage imageNamed:@"icon_laxin_success"] :[UIImage imageNamed:@"icon_laxin_again"];
            [weakSelf.laXinView.finishBtn setTitle:@"分享赚更多" forState:UIControlStateNormal];
            double num = weakSelf.laXinModel.totalAmount.doubleValue/weakSelf.laXinModel.minWithdrawAmount.doubleValue;
            weakSelf.laXinView.progressNum = num;
            int newNum = (1 -num)*100;
            weakSelf.laXinView.proDetailLab.text = [NSString stringWithFormat:@"满%d元即可提现，距离提现还有%d%%",[weakSelf.laXinModel.minWithdrawAmount intValue]/100,newNum];
            [weakSelf.laXinView setLaXinBlock:^(UIButton *result) {
                weakSelf.laXinView.hidden = YES;
                switch (result.tag) {
                    case 501:
                    {
                        weakSelf.laXinView.hidden = YES;
                        BaseWebVC *vc = [[BaseWebVC alloc]init];;
                        [vc reloadForGetWebView:weakSelf.laXinModel.activityPageUrl];
                        [weakSelf.navigationController pushViewController:vc animated:YES];
                        
                        
                        
                    }
                        break;
                    case 502:{
                        
                        [weakSelf shareView:weakSelf.productNo];
                        
                        
                    }
                        
                        break;
                        
                    default:
                        break;
                }
                
            }];
            weakSelf.laXinView.frame = [UIScreen mainScreen].bounds;
            [[UIApplication sharedApplication].keyWindow addSubview: weakSelf.laXinView];
            
            
        }
    } andFailBlock:^(id result) {
        
    }];
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
                    [UserInfo sharedInstance].isAlertShare = YES;
                    [[UserInfo sharedInstance]saveUserInfo:[UserInfo sharedInstance]];
                    if (![blockSelf.laXinView.titleLab2.text isEqualToString:@"继续分享到群，奖励金额将会大大增加，上不封顶"] ) {
                        [blockSelf laXinNoti:2];
                    }
                    
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
                    [UserInfo sharedInstance].isAlertShare = YES;
                    [[UserInfo sharedInstance]saveUserInfo:[UserInfo sharedInstance]];
                    if (![blockSelf.laXinView.titleLab2.text isEqualToString:@"继续分享到群，奖励金额将会大大增加，上不封顶"] ) {
                        [blockSelf laXinNoti:2];
                    }
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

#pragma mark 标题数组
- (NSArray *)titleData {
    if (!_titleData) {
        _titleData = @[@"全部", @"待返佣", @"进行中",@"已完成"];
    }
    return _titleData;
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
@end
