//
//  MySetVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/20.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "MySetVC.h"
#import "ModifyWalletVC.h"
#import "LoginVC.h"
#import "XCacheHelper.h"

@interface MySetVC ()

@end

@implementation MySetVC
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:BackgroundColor];
    
    
    UIView *cellView = [[UIView alloc]init];
    cellView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:cellView];
    
    [cellView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(10);
        make.height.mas_equalTo(47);
    }];
    
    UILabel *detail = [[UILabel alloc]init];
    detail.text = @"修改钱包密码";
    [detail setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
    [detail setTextColor:LabelMainColor];
    [cellView addSubview:detail];
    [detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cellView).offset(16);
        make.centerY.mas_equalTo(cellView);
    }];
    
    UIButton *bgBtn = [[UIButton alloc]init];

    [bgBtn setImage:[UIImage imageNamed:@"icon_right"] forState:UIControlStateNormal];
    bgBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
    [cellView addSubview:bgBtn];
    [bgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(cellView).offset(-16);
        make.width.mas_equalTo(80);
        make.centerY.mas_equalTo(cellView);
    }];
    UIButton *selectBtn = [[UIButton alloc]init];
    selectBtn.tag = 401;
    [selectBtn addTarget:self action:@selector(btnOnClock:) forControlEvents:UIControlEventTouchUpInside];
    selectBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
    [cellView addSubview:selectBtn];
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(cellView).offset(-16);
        make.left.mas_equalTo(cellView).offset(16);
        make.height.mas_equalTo(30);
        make.centerY.mas_equalTo(cellView);
    }];
    
    //
    UIView *cellView2 = [[UIView alloc]init];
    cellView2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:cellView2];
    
    [cellView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(cellView.mas_bottom).offset(10);
        make.height.mas_equalTo(47);
    }];
    UILabel *noti = [[UILabel alloc]init];
    noti.text = @"消息通知";
    [noti setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
    [noti setTextColor:LabelMainColor];
    [cellView2 addSubview:noti];
    [noti mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cellView2).offset(16);
        make.centerY.mas_equalTo(cellView2);
    }];
    
    UIButton *bgBtn2 = [[UIButton alloc]init];
    [bgBtn2 setImage:[UIImage imageNamed:@"icon_right"] forState:UIControlStateNormal];
    [cellView2 addSubview:bgBtn2];
    [bgBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(cellView2).offset(-16);
        make.width.mas_equalTo(30);
        make.centerY.mas_equalTo(cellView2);
    }];
    
    UILabel *kaiqiLab = [[UILabel alloc]init];
    UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
    if (UIUserNotificationTypeNone == setting.types) {
        kaiqiLab.text = @"避免错误重要通知—去开启";
    }else{
        kaiqiLab.text = @"已开启";
    }
    [kaiqiLab setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
    [kaiqiLab setTextColor:LabelAssistantColor];
    [cellView2 addSubview:kaiqiLab];
    [kaiqiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bgBtn2.mas_left).offset(5);
        make.centerY.mas_equalTo(cellView2);
    }];
    
    UIButton *selectBtn2 = [[UIButton alloc]init];
    selectBtn2.tag = 403;
    [selectBtn2 addTarget:self action:@selector(btnOnClock:) forControlEvents:UIControlEventTouchUpInside];
    selectBtn2.imageEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
    [cellView2 addSubview:selectBtn2];
    [selectBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(cellView2).offset(-16);
        make.left.mas_equalTo(cellView2).offset(16);
        make.height.mas_equalTo(30);
        make.centerY.mas_equalTo(cellView2);
    }];
    
    
    
    

    
    
    UIButton *getOutBtn = [[UIButton alloc]init];
    getOutBtn.tag = 402;
    [getOutBtn setBackgroundColor:blueColor];
    [getOutBtn setCornerValue:4];
    [getOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [getOutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [getOutBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(17)]];
    [getOutBtn addTarget:self action:@selector(btnOnClock:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getOutBtn];
    [getOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(20);
        make.right.mas_equalTo(self.view).offset(-20);
        make.bottom.mas_equalTo(self.view).offset(-60);
        make.height.mas_equalTo(44);
    }];
}
- (void)btnOnClock:(UIButton *)btn{
    switch (btn.tag) {
        case 401:
        {
            ModifyWalletVC *vc = [[ModifyWalletVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 402:{
            
            [XAlertView alertWithTitle:@"提示" message:@"确定退出登录" cancelButtonTitle:@"取消" confirmButtonTitle:@"确定" viewController:self completion:^(UIAlertAction *action, NSInteger buttonIndex) {
                if (buttonIndex == 1) {
                    WEAKSELF
                    [XNetWork requestNetWorkWithUrl:Xlogout andModel:nil andSuccessBlock:^(ResponseModel *model) {
                        [ProgressHUD showProgressHUDInView:nil withText:@"退出成功" afterDelay:1];
                        [XCacheHelper clearCacheFolder];
                        weakSelf.tabBarController.selectedIndex = 0;
                        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                        [XNotificationCenter postNotificationName:LoginSuccessNotification object:nil];
                    } andFailBlock:^(ResponseModel *model) {
                        
                    }];
                }
            }];
        }
            break;
        case 403:{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
            break;
        default:
            break;
    }
}
@end
