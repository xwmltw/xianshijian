//
//  XNetWork.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/18.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "XNetWork.h"

@implementation XNetWork
/**
 微信授权登录请求
 
 @param appID <#appID description#>
 @param secret <#secret description#>
 @param block <#block description#>
 */
- (void)getWXLoginAppID:(NSString *)appID andSecret:(NSString *)secret andCode:(NSString *)code andBlock:(XBlock)block{
    
     NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",appID,secret,code];
    
    [NetWorkManager requestDataForPOSTWithURL:url parameters:nil Controller:nil UploadProgress:nil success:^(id responseObject) {
        XBlockExec(block, responseObject);
    } failure:^(NSError *error) {
        XBlockExec(block, error);
    }];
    
}

/**
 请求接口
 
 @param url 请求地址
 @param model 参数
 @param successBlock 回调信息
 */
+ (void)requestNetWorkWithUrl:(NSString *)url andModel:(NSObject * _Nullable)model andSuccessBlock:(ResponseBlock)successBlock andFailBlock:(ResponseBlock)failBlock{
    
    
    UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
    UIViewController *appRootVC = topWindow.rootViewController;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:appRootVC.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.animationType = MBProgressHUDAnimationFade;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor clearColor];
    
    NSMutableDictionary *params = [[[BaseInfoPM alloc]init] mj_keyValues];
    NSMutableDictionary *content = [NSMutableDictionary dictionary];
    [content addEntriesFromDictionary:[model mj_keyValues]];
    
    [params setObject:[UserInfo sharedInstance].token.length > 0 ? [UserInfo sharedInstance].token :@"" forKey:@"accessToken"];
    [params setObject:content forKey:@"data"];
    

    
    [NetWorkManager requestDataForPOSTWithURL:url parameters:params Controller:nil UploadProgress:nil success:^(id responseObject) {
        if (hud) {
            [hud hideAnimated:YES];
        }

        MyLog(@"%@->返回数据%@",url,responseObject);
        ResponseModel *responseModel = [ResponseModel mj_objectWithKeyValues:responseObject];
        if (responseModel.rspCode.integerValue == 0) {
            XBlockExec(successBlock, responseModel);
        }else{
            [ProgressHUD showProgressHUDInView:nil withText:responseModel.rspMsg afterDelay:1];
            XBlockExec(failBlock, responseModel);
        }
    } failure:^(NSError *error) {
        if (hud) {
            [hud hideAnimated:YES];
        }
          MyLog(@"%@->返回数据%@",url,error);
        
    }];
}
@end
