//
//  WJProgressView.m
//  JianKeLife
//
//  Created by yanqb on 2019/4/25.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "WJProgressView.h"

@interface WJProgressView ()

@property (nonatomic,strong)CALayer *progressLayer;
@property (nonatomic,assign)CGFloat currentViewWidth;

@end
@implementation WJProgressView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.progressLayer = [CALayer layer];
        self.backgroundColor = [UIColor whiteColor];
        self.progressLayer.backgroundColor = [UIColor whiteColor].CGColor;
        self.progressLayer.frame = CGRectMake(0, 0, 0, frame.size.height);
        [self.layer addSublayer:self.progressLayer];
        //储存当前view的宽度值
        self.currentViewWidth = frame.size.width;
    }
    return self;
}

#pragma mark - 重写setter,getter方法

@synthesize progress = _progress;
- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    if (progress <= 0) {
        self.progressLayer.frame = CGRectMake(0, 0, 0, self.frame.size.height);
    }else if (progress <= 1) {
        self.progressLayer.frame = CGRectMake(0, 0, progress *self.currentViewWidth, self.frame.size.height);
    }else {
        self.progressLayer.frame = CGRectMake(0, 0, self.currentViewWidth, self.frame.size.height);
    }
}

- (CGFloat)progress {
    return _progress;
}

@synthesize progressColor = _progressColor;
- (void)setProgressColor:(UIColor *)progressColor {
    _progressColor = progressColor;
    self.progressLayer.backgroundColor = progressColor.CGColor;
}

- (UIColor *)progressColor {
    return _progressColor;
}

@end
