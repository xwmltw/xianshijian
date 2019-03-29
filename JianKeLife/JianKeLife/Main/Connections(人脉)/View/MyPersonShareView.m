//
//  MyPersonShareView.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/29.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "MyPersonShareView.h"

@implementation MyPersonShareView

- (void)layoutSubviews{
    [self.QRMainBGView setCornerValue:4];
    [self.QRBGView setCornerValue:4];
}
- (IBAction)btnOnClick:(UIButton *)sender {
    XBlockExec(self.btnBlock,sender);
}

@end
