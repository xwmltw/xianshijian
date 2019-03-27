//
//  SetWalletPasswordView.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/27.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "SetWalletPasswordView.h"

@implementation SetWalletPasswordView

- (void)layoutSubviews{
     [self.bgView setCornerValue:4];
    [self.sureBtn setCornerValue:2];
}
- (IBAction)btnOnClick:(UIButton *)sender {
    XBlockExec(self.setPasswordBtnBlock ,sender);
}

@end
