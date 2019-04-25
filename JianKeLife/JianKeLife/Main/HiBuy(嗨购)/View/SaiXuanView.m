//
//  SaiXuanView.m
//  JianKeLife
//
//  Created by yanqb on 2019/4/25.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "SaiXuanView.h"

@implementation SaiXuanView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel *lab = [[UILabel alloc]init];
        [lab setText:@"价格区间（元）"];
        [lab setFont:[UIFont systemFontOfSize:14]];
        [lab setTextColor:XColorWithRGB(124, 124, 124)];
        [self addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(AdaptationWidth(16));
            make.top.mas_equalTo(self).offset(AdaptationWidth(10));
        }];
        
        self.nimText = [[UITextField alloc]init];
        self.nimText.textAlignment = NSTextAlignmentCenter;
        self.nimText.backgroundColor = BackgroundColor;
        self.nimText.borderStyle = UITextBorderStyleNone;
        self.nimText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"最低价" attributes:@{NSForegroundColorAttributeName:LabelAssistantColor}];
        self.nimText.font = [UIFont systemFontOfSize:AdaptationWidth(14)];
        //    [oldPassword addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        self.nimText.keyboardType = UIKeyboardTypeNumberPad;
        [self.nimText setCornerValue:14];
        [self.nimText setTextColor:XColorWithRGB(124, 124, 124)];
        [self addSubview:self.nimText];
        [self.nimText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(AdaptationWidth(16));
            make.top.mas_equalTo(lab.mas_bottom).offset(AdaptationWidth(10));
            make.width.mas_equalTo(AdaptationWidth(100));
            make.height.mas_equalTo(AdaptationWidth(29));
        }];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = XColorWithRGB(124, 124, 124);
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nimText.mas_right).offset(AdaptationWidth(1));
            make.centerY.mas_equalTo(self.nimText);
            make.width.mas_equalTo(AdaptationWidth(25));
            make.height.mas_equalTo(AdaptationWidth(1));
        }];
        
        self.maxText = [[UITextField alloc]init];
        self.maxText.textAlignment = NSTextAlignmentCenter;
        self.maxText.backgroundColor = BackgroundColor;
        self.maxText.borderStyle = UITextBorderStyleNone;
        self.maxText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"最低价" attributes:@{NSForegroundColorAttributeName:LabelAssistantColor}];
        self.maxText.font = [UIFont systemFontOfSize:AdaptationWidth(14)];
        //    [oldPassword addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        self.maxText.keyboardType = UIKeyboardTypeNumberPad;
        [self.maxText setCornerValue:14];
        [self.maxText setTextColor:XColorWithRGB(124, 124, 124)];
        [self addSubview:self.maxText];
        [self.maxText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(line.mas_right).offset(AdaptationWidth(1));
            make.top.mas_equalTo(self.nimText);
            make.width.mas_equalTo(AdaptationWidth(100));
            make.height.mas_equalTo(AdaptationWidth(29));
        }];
        
        UIButton *getOutBtn = [[UIButton alloc]init];
        getOutBtn.tag = 901;
        [getOutBtn setBackgroundColor:[UIColor whiteColor]];
        [getOutBtn setCornerValue:4];
        [getOutBtn setBorderWidth:1 andColor:blueColor];
        [getOutBtn setTitle:@"重置" forState:UIControlStateNormal];
        [getOutBtn setTitleColor:blueColor forState:UIControlStateNormal];
        [getOutBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(17)]];
        [getOutBtn addTarget:self action:@selector(btnOnClock:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:getOutBtn];
        [getOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(AdaptationWidth(16));
            make.width.mas_equalTo(AdaptationWidth(164));
            make.top.mas_equalTo(self.maxText.mas_bottom).offset(AdaptationWidth(25));
            make.height.mas_equalTo(AdaptationWidth(36));
        }];
        
        UIButton *sureBtn = [[UIButton alloc]init];
        sureBtn.tag = 902;
        [sureBtn setBackgroundColor:blueColor];
        [sureBtn setCornerValue:4];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sureBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(17)]];
        [sureBtn addTarget:self action:@selector(btnOnClock:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sureBtn];
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).offset(AdaptationWidth(-16));
            make.width.mas_equalTo(AdaptationWidth(164));
            make.top.mas_equalTo(self.maxText.mas_bottom).offset(AdaptationWidth(25));
            make.height.mas_equalTo(AdaptationWidth(36));
        }];

    }
    return self;
}
- (void)btnOnClock:(UIButton *)btn{
    if (btn.tag == 902) {
        XBlockExec(self.btnBlock ,self.nimText.text,self.maxText.text);
    }else{
        self.nimText.text = @"";
        self.maxText.text = @"";
    }
    
}
@end
