//
//  QRcodeView.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/25.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "QRcodeView.h"

@implementation QRcodeView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
     
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)btnOnClick:(UIButton *)sender {
    XBlockExec(self.btnBlock,sender);
}

@end
