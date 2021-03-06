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
    
    [self.bgView setCornerValue:8];
    
//    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
//    gradientLayer.frame = CGRectMake(0, 0, 90, 29);
//    gradientLayer.startPoint = CGPointMake(0, 0);
//    gradientLayer.endPoint = CGPointMake(1, 0);
//    gradientLayer.locations = @[@(0.5),@(1.0)];//渐变点
//    [gradientLayer setColors:@[(__bridge id)XColorWithRBBA(242, 113, 106, 1).CGColor,(__bridge id)XColorWithRBBA(212, 69, 46, 1).CGColor]];//渐变数组
//
//    [self.moreBtn.layer addSublayer:gradientLayer];
    [self.moreBtn setImage:[UIImage imageNamed:@"icon_箭头_whilt"] forState:UIControlStateNormal];
    [self.moreBtn setTitle:@"更多活动" forState:UIControlStateNormal];
    [self.moreBtn setCornerValue:14];
    
//    gradientLayer.frame = CGRectMake(0, 0, 191, 48);
//    [self.finishBtn.layer addSublayer:gradientLayer];
    [self.finishBtn setCornerValue:24];
    
    self.progressView = [[WJProgressView alloc]initWithFrame:CGRectMake(9, self.proDetailLab.Y -14, self.bgView.Sw-20, 10)];
    [self.progressView setCornerValue:4];
    self.progressView.progress = self.progressNum;
    self.progressView.progressColor = RedColor;
    self.progressView.hidden = self.isProView;
    [self.bgView addSubview:self.progressView];
//    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(self.proDetailLab.mas_top).offset(4);
//        make.left.mas_equalTo(self.bgView).offset(9);
//        make.right.mas_equalTo(self.bgView).offset(-10);
//        make.height.mas_equalTo(10);
//    }];
    
}
- (IBAction)btnOnClick:(UIButton *)sender {

    if (sender.tag == 503) {
        self.hidden = YES;
        return;
    }
    XBlockExec(self.laXinBlock,sender);
}


@end
