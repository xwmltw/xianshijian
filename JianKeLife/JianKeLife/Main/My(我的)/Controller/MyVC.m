//
//  MyVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/18.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "MyVC.h"
#import "MyTableView.h"

#import "MyInfoVC.h"
#import "MySetVC.h"
#import "FeedbackVC.h"
#import "BaseWebVC.h"
#import "ProfitVC.h"
#import "WalletVC.h"
#import "ExpectVC.h"
#import "LoginVC.h"

@interface MyVC ()
@property (nonatomic ,strong) MyTableView *tableView;
@end

@implementation MyVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    statusBar.backgroundColor = blueColor;
    
    
    if ([UserInfo sharedInstance].isSignIn) {
        
        [self.tableView.viewModel requestUserInfo];
    }
}
//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
//    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
//    statusBar.backgroundColor = blueColor;
//}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    statusBar.backgroundColor = [UIColor clearColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView  = [[MyTableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    self.view = self.tableView;
    
    [self tableViewCellPushVC];
    [self headBtnPushVC];
    
    [XNotificationCenter addObserver:self selector:@selector(loginSuccessNotification:) name:LoginSuccessNotification object:nil];
}
- (void)tableViewCellPushVC{
    
    
    WEAKSELF
    [self.tableView setCellSelectBlock:^(NSInteger result) {
        
        switch (result) {
            case 0:
            {
     
                FeedbackVC *vc = [[FeedbackVC alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:
            {
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                
                pasteboard.string = [weakSelf.clientGlobalInfo.customerContact componentsSeparatedByString:@"："][1];
                [ProgressHUD showProgressHUDInView:nil withText:@"复制成功" afterDelay:1];
            }
                break;
            case 2:
            {
                BaseWebVC *vc = [[BaseWebVC alloc]init];
                [vc reloadForGetWebView:weakSelf.clientGlobalInfo.aboutUsUrl];
                vc.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 3:
            {
                if (![UserInfo sharedInstance].isSignIn) {
                    
                    LoginVC *vc = [[LoginVC alloc]init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                    return ;
                }
                MySetVC *vc = [[MySetVC alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.title = @"设置";
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            default:
                break;
        }
    }];
}
- (void)headBtnPushVC{
    WEAKSELF
    [self.tableView setBtnBlock:^(UIButton *result) {
        if (![[UserInfo sharedInstance]isSignIn]) {
            [weakSelf goToLogin];
        }
        switch (result.tag) {
            case 402:
            {
                MyInfoVC *vc = [[MyInfoVC alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 403:{
                ProfitVC *vc = [[ProfitVC alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 404:{
                WalletVC *vc = [[WalletVC alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 405:{
                ExpectVC *vc = [[ExpectVC alloc]init];
                vc.moneyLb = weakSelf.tableView.viewModel.myModel.forecastReceviceAmt;
                vc.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:vc animated:YES];
                }
                break;
            default:
                break;
        }
    }];
}

- (void)loginSuccessNotification:(NSNotificationCenter *)sender{
    [self.tableView reloadData];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
