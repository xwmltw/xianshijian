//
//  FeedbackVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/20.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "FeedbackVC.h"
#import "XPlaceHolderTextView.h"

@interface FeedbackVC ()
@property (nonatomic ,strong) XPlaceHolderTextView *textView;
@end

@implementation FeedbackVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    [self.view setBackgroundColor:BackgroundColor];
    
    
    self.textView = [[XPlaceHolderTextView alloc]init];
    self.textView.placeholder = @"留下你的问题或建议吧~";
    self.textView.placeholderColor = LabelAssistantColor;
    self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.font = [UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(16)];
    [self.view addSubview:self.textView];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(15);
        make.right.mas_equalTo(self.view).offset(-15);
        make.top.mas_equalTo(self.view).offset(15);
        make.height.mas_equalTo(258);
    }];
    
    UIButton *getOutBtn = [[UIButton alloc]init];
    [getOutBtn setBackgroundColor:blueColor];
    [getOutBtn setCornerValue:4];
    [getOutBtn setTitle:@"提交反馈" forState:UIControlStateNormal];
    [getOutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [getOutBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(17)]];
    [getOutBtn addTarget:self action:@selector(btnOnClock:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getOutBtn];
    [getOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(20);
        make.right.mas_equalTo(self.view).offset(-20);
        make.bottom.mas_equalTo(self.view).offset(-60);
        make.height.mas_equalTo(44);
    }];
}
- (void)btnOnClock:(UIButton *)btn{
    
    
}
- (void)BarbuttonClick:(UIButton *)button{
    [self check:^(id result) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
- (void)check:(XBlock)block{
    if (self.textView.text.length != 0) {
        
        [XAlertView alertWithTitle:@"温馨提示" message:@"您输入的意见尚未保存,确认退出?" cancelButtonTitle:@"取消" confirmButtonTitle:@"退出" viewController:self completion:^(UIAlertAction *action, NSInteger buttonIndex) {
            switch (buttonIndex) {
                case 1:
                    XBlockExec(block,nil);
                    break;
                    
                default:
                    break;
            }
        }];
    }
    XBlockExec(block,nil);
}
@end
