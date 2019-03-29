//
//  RuleAlertView.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/29.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "RuleAlertView.h"

@implementation RuleAlertView

- (void)layoutSubviews{
    [self.bgView  setCornerValue:4];
}
- (IBAction)btnOnClick:(UIButton *)sender {
    XBlockExec(self.ruleBtnBlcok ,nil);
}

@end
