//
//  LaXinView.m
//  JianKeLife
//
//  Created by 肖伟民 on 2019/4/22.
//  Copyright © 2019 xwm. All rights reserved.
//

#import "LaXinView.h"

@implementation LaXinView


- (void)drawRect:(CGRect)rect {
    
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = self.moreBtn.frame;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.locations = @[@(0.5),@(1.0)];//渐变点
//    [gradientLayer setColors:@[(__bridge id)XCGColorWithRGBA(242, 113, 106, 1),(__bridge id)XCGColorWithRGBA(212, 69, 46, 1)]];//渐变数组
    [self.moreBtn.layer addSublayer:gradientLayer];
    [self.moreBtn setTitle:@"xwm" forState:UIControlStateNormal];
}


@end
