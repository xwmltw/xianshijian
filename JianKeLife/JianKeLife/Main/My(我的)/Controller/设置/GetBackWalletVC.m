//
//  GetBackWalletVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/27.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "GetBackWalletVC.h"
#import "XCountDownButton.h"
#import <VerifyCode/NTESVerifyCodeManager.h>

@interface GetBackWalletVC ()<NTESVerifyCodeManagerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordtextField;
@property (nonatomic ,strong) NTESVerifyCodeManager *manager;

@end

@implementation GetBackWalletVC
{
    XCountDownButton *_getVerificationButton;
}
- (IBAction)btnOnClick:(UIButton *)sender {
    switch (sender.tag) {
        
        case 4351:
        {
            
        }
            break;
        case 4352:
        {
            
        }
            break;
            
        default:
            break;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回钱包密码";
    
    XCountDownButton *getVerificationCodeButton = [XCountDownButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:getVerificationCodeButton];
    [getVerificationCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getVerificationCodeButton setTitleColor:blueColor forState:UIControlStateNormal];
    getVerificationCodeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    getVerificationCodeButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(16)];
    [getVerificationCodeButton addTarget:self action:@selector(getVerificationCodeClick:) forControlEvents:UIControlEventTouchUpInside];
    [getVerificationCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).offset(-20);
        make.centerY.mas_equalTo(self.codeTextField);
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
//        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//        [dic setValue:self.phoneTextField.text forKey:@"phoneNum"];
//        [dic setValue:@"1" forKey:@"optType"];
//        [dic setValue:validate forKey:@"neCaptchaValidate"];
//        [XNetWork requestNetWorkWithUrl:Xget_sms_code andModel:dic andSuccessBlock:^(ResponseModel *model) {
//            [ProgressHUD showProgressHUDInView:nil withText:@"发送成功" afterDelay:1];
//            [self beginCountDown];
//        } andFailBlock:^(ResponseModel *model) {
//
//        }];
    }
    // App添加自己的处理逻辑
    MyLog(@"%@",message);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
