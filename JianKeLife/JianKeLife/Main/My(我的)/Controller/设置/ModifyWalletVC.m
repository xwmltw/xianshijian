//
//  ModifyWalletVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/20.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "ModifyWalletVC.h"

@interface ModifyWalletVC ()

@end

@implementation ModifyWalletVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改钱包密码";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UITextField *oldPassword = [[UITextField alloc]init];
    oldPassword.backgroundColor = [UIColor whiteColor];
    oldPassword.borderStyle = UITextBorderStyleNone;
    oldPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"原始钱包密码" attributes:@{NSForegroundColorAttributeName:LabelAssistantColor}];
    oldPassword.font = [UIFont systemFontOfSize:AdaptationWidth(16)];
//    [oldPassword addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    oldPassword.keyboardType = UIKeyboardTypeNumberPad;
    [oldPassword setTextColor:LabelMainColor];
    [self.view addSubview:oldPassword];
    [oldPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(16);
        make.right.mas_equalTo(self.view).offset(-16);
        make.top.mas_equalTo(self.view).offset(20);
        make.height.mas_equalTo(40);
    }];
    
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = LineColor;
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(16);
        make.right.mas_equalTo(self.view).offset(-16);
        make.top.mas_equalTo(oldPassword.mas_bottom).offset(2);
        make.height.mas_equalTo(0.5);
    }];
    
    
    
    UITextField *newPassword = [[UITextField alloc]init];
    newPassword.backgroundColor = [UIColor whiteColor];
    newPassword.borderStyle = UITextBorderStyleNone;
    newPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"6位新密码" attributes:@{NSForegroundColorAttributeName:LabelAssistantColor}];
    newPassword.font = [UIFont systemFontOfSize:AdaptationWidth(16)];
    //    [oldPassword addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    newPassword.keyboardType = UIKeyboardTypeNumberPad;
    [newPassword setTextColor:LabelMainColor];
    [self.view addSubview:newPassword];
    [newPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(16);
        make.right.mas_equalTo(self.view).offset(-16);
        make.top.mas_equalTo(line1.mas_bottom).offset(2);
        make.height.mas_equalTo(40);
    }];
    
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = LineColor;
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(16);
        make.right.mas_equalTo(self.view).offset(-16);
        make.top.mas_equalTo(newPassword.mas_bottom).offset(2);
        make.height.mas_equalTo(0.5);
    }];
    
    
    
    
    UITextField *againPassword = [[UITextField alloc]init];
    againPassword.backgroundColor = [UIColor whiteColor];
    againPassword.borderStyle = UITextBorderStyleNone;
    againPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"确认新密码" attributes:@{NSForegroundColorAttributeName:LabelAssistantColor}];
    againPassword.font = [UIFont systemFontOfSize:AdaptationWidth(16)];
    //    [oldPassword addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    againPassword.keyboardType = UIKeyboardTypeNumberPad;
    [againPassword setTextColor:LabelMainColor];
    [self.view addSubview:againPassword];
    [againPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(16);
        make.right.mas_equalTo(self.view).offset(-16);
        make.top.mas_equalTo(line2.mas_bottom).offset(2);
        make.height.mas_equalTo(40);
    }];
    
    UIView *line3 = [[UIView alloc]init];
    line3.backgroundColor = LineColor;
    [self.view addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(16);
        make.right.mas_equalTo(self.view).offset(-16);
        make.top.mas_equalTo(againPassword.mas_bottom).offset(2);
        make.height.mas_equalTo(0.5);
    }];
    
    
    
    
    UIButton *getOutBtn = [[UIButton alloc]init];
    [getOutBtn setBackgroundColor:blueColor];
    [getOutBtn setCornerValue:4];
    [getOutBtn setTitle:@"确定" forState:UIControlStateNormal];
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
    
}
@end
