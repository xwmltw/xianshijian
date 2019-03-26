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
    
    UIButton *selectBtn = [[UIButton alloc]init];
    selectBtn.tag = 401;
    [selectBtn setImage:[UIImage imageNamed:@"icon_right"] forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(btnOnClock:) forControlEvents:UIControlEventTouchUpInside];
    selectBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
    [cellView addSubview:selectBtn];
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(cellView).offset(-16);
        make.width.mas_equalTo(80);
        make.centerY.mas_equalTo(cellView);
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
            BLOCKSELF
            [XNetWork requestNetWorkWithUrl:Xlogout andModel:nil andSuccessBlock:^(ResponseModel *model) {
                [ProgressHUD showProgressHUDInView:nil withText:@"退出成功" afterDelay:1];
                [XCacheHelper clearCacheFolder];
                LoginVC *vc = [[LoginVC alloc]init];
                [blockSelf.navigationController pushViewController:vc animated:YES];
                [XNotificationCenter postNotificationName:LoginSuccessNotification object:nil];
            } andFailBlock:^(ResponseModel *model) {
                
            }];
           
        }
            break;
        default:
            break;
    }
}
@end
