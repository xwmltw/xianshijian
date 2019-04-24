//
//  HiBuyShareCodeView.m
//  JianKeLife
//
//  Created by yanqb on 2019/4/24.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "HiBuyShareCodeView.h"
#import "XCommonHepler.h"

@implementation HiBuyShareCodeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)btnOnClick:(UIButton *)sender {
    [[XCommonHepler sharedInstance] saveImageToPhotoLib:[UIImage convertViewToImage:self.bgView]];
}

@end
