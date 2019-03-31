//
//  UnLoginView.m
//  JianKeLife
//
//  Created by 肖伟民 on 2019/3/31.
//  Copyright © 2019 xwm. All rights reserved.
//

#import "UnLoginView.h"

@implementation UnLoginView

- (void)layoutSubviews{
    [self.loginBtn setCornerValue:4];
}
- (IBAction)btnOnClick:(UIButton *)sender {
    XBlockExec(self.btnBlock, nil);
}

@end
