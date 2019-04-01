//
//  LoginVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/19.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "LoginVC.h"
#import "XCountDownButton.h"
#import <VerifyCode/NTESVerifyCodeManager.h>
#import "BaseWebVC.h"


@interface LoginVC ()<NTESVerifyCodeManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *smsCode;
@property (nonatomic ,strong) NTESVerifyCodeManager *manager;
@end

@implementation LoginVC
{
    XCountDownButton *_getVerificationButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    XCountDownButton *getVerificationCodeButton = [XCountDownButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:getVerificationCodeButton];
    [getVerificationCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getVerificationCodeButton setTitleColor:blueColor forState:UIControlStateNormal];
    getVerificationCodeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    getVerificationCodeButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(16)];
    [getVerificationCodeButton addTarget:self action:@selector(getVerificationCodeClick:) forControlEvents:UIControlEventTouchUpInside];
    [getVerificationCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).offset(AdaptationWidth(-16));
        make.centerY.mas_equalTo(self.smsCode);
        make.width.mas_equalTo(AdaptationWidth(100));
        make.height.mas_equalTo(AdaptationWidth(30));
    }];
    
    // sdk调用
    self.manager = [NTESVerifyCodeManager sharedInstance];
    self.manager.delegate = self;
    
    // 设置透明度
    self.manager.alpha = 0.7;
    
    // 设置frame
    self.manager.frame = CGRectNull;
    // 设置语言
    self.manager.lang = NTESVerifyCodeLangCN;
    
    
    // 常规验证码（滑块拼图、图中点选、短信上行）
    // NSString *captchaid = @"deecf3951a614b71b4b1502c072be1c1";
     self.manager.mode = NTESVerifyCodeBind;
    
//     智能无感知验证码
    NSString *captchaid = @"f69c29291f754d9a9942cd98f0eea4ce";
    [self.manager configureVerifyCode:captchaid timeout:10];
    
}
- (IBAction)loginBtn:(UIButton *)sender {
   
//    [UserInfo sharedInstance].phoneName = self.phoneTextField.text;
//    UserInfo *asdfa =[UserInfo sharedInstance];
//    [[UserInfo sharedInstance]saveUserInfo:[UserInfo sharedInstance]];
//
//    MyLog(@"%@",[[UserInfo sharedInstance] getUserInfo].phoneName);
//    [[UserInfo sharedInstance]saveUserInfo:[UserInfo sharedInstance]];
    
    if (self.phoneTextField.text.length != 11) {
        [ProgressHUD showProgressHUDInView:nil withText:@"请输入正确的手机号码" afterDelay:1];
        return;
    }
    if (self.smsCode.text.length == 0) {
        [ProgressHUD showProgressHUDInView:nil withText:@"请输入验证码" afterDelay:1];
        return;
    }
     NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.phoneTextField.text forKey:@"phoneNum"];
    [dic setValue:@"" forKey:@"recommendCode"];
    [dic setValue:self.smsCode.text forKey:@"smsCode"];
    
    
    WEAKSELF
    [XNetWork requestNetWorkWithUrl:XLogin_Register andModel:dic andSuccessBlock:^(ResponseModel *model) {
        [ProgressHUD showProgressHUDInView:nil withText:@"登录成功" afterDelay:1];
        [UserInfo sharedInstance].phoneName = weakSelf.phoneTextField.text;
        [UserInfo sharedInstance].token = model.data[@"token"];
        [[UserInfo sharedInstance]saveUserInfo:[UserInfo sharedInstance]];
        

        [self.navigationController popViewControllerAnimated:YES];
        [XNotificationCenter postNotificationName:LoginSuccessNotification object:nil];
    } andFailBlock:^(ResponseModel *model) {
        
    }];
    
}
- (IBAction)protocolBtn:(UIButton *)sender {
    BaseWebVC *vc = [[BaseWebVC alloc]init];
    [vc reloadForGetWebView:self.clientGlobalInfo.registerAgreementUrl];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)getVerificationCodeClick:(XCountDownButton *)btn{
    _getVerificationButton = btn;
    //请求
    
    if (self.phoneTextField.text.length != 11) {
        [ProgressHUD showProgressHUDInView:nil withText:@"请输入正确的手机号码" afterDelay:1];
        return;
    }
    [self.manager openVerifyCodeView];
    

}
- (void)beginCountDown{
    _getVerificationButton.userInteractionEnabled = NO;
    [_getVerificationButton startCountDownWithSecond:60];
    [_getVerificationButton countDownChanging:^NSString *(XCountDownButton *countDownButton,NSUInteger second){
        NSString *title = [NSString stringWithFormat:@"%@s", @(second)];
        return title;
    }];
    [_getVerificationButton countDownFinished:^NSString *(XCountDownButton *countDownButton, NSUInteger second) {
        self->_getVerificationButton.userInteractionEnabled = YES;
        return @"重新发送";
    }];
}

#pragma mark - VerifyDelegate
- (void)verifyCodeInitFinish{
    
}
- (void)verifyCodeInitFailed:(NSArray *)error{
    // App添加自己的处理逻辑
    MyLog(@"%@",error);
}
/**
 * 完成验证之后的回调
 * @param result 验证结果 BOOL:YES/NO
 * @param validate 二次校验数据，如果验证结果为false，validate返回空
 * @param message 结果描述信息
 */
- (void)verifyCodeValidateFinish:(BOOL)result
                        validate:(NSString *)validate
                         message:(NSString *)message{
    if (result) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setValue:self.phoneTextField.text forKey:@"phoneNum"];
            [dic setValue:@"1" forKey:@"optType"];
            [dic setValue:validate forKey:@"neCaptchaValidate"];
            [XNetWork requestNetWorkWithUrl:Xget_sms_code andModel:dic andSuccessBlock:^(ResponseModel *model) {
                [ProgressHUD showProgressHUDInView:nil withText:@"发送成功" afterDelay:1];
                [self beginCountDown];
            } andFailBlock:^(ResponseModel *model) {
        
            }];
    }
    // App添加自己的处理逻辑
    MyLog(@"%@",message);
}


@end
