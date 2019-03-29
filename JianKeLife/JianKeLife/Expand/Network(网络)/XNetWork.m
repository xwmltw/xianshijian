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
+ (void)getWXLoginAppID:(NSString *)appID andSecret:(NSString *)secret andCode:(NSString *)code andBlock:(XBlock)block{
    
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
    
    [params setObject:[[UserInfo sharedInstance]getUserInfo].token.length > 0 ? [[UserInfo sharedInstance]getUserInfo].token :@"" forKey:@"accessToken"];
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
            if(![url isEqualToString:Xget_account_info])
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
//上传图片
+ (void)UploadPicturesWithUrl:(NSString *)url  images:(NSArray *)images targetWidth:(CGFloat )width andSuccessBlock:(ResponseBlock)successBlock andFailBlock:(ResponseBlock)failBlock{
    
    UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
    UIViewController *appRootVC = topWindow.rootViewController;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:appRootVC.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.animationType = MBProgressHUDAnimationFade;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor clearColor];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    [params setObject:[[UserInfo sharedInstance]getUserInfo].token.length > 0 ? [[UserInfo sharedInstance]getUserInfo].token :@"" forKey:@"accessToken"];
   
    [NetWorkManager UploadPicturesWithURL:url parameters:params images:images targetWidth:width UploadProgress:nil success:^(id responseObject) {
        if (hud) {
            [hud hideAnimated:YES];
        }
        MyLog(@"%@->返回数据%@",url,responseObject);
        ResponseModel *responseModel = [ResponseModel mj_objectWithKeyValues:responseObject];
        if (responseModel.rspCode.integerValue == 0) {
            XBlockExec(successBlock, responseModel);
        }else{
            if(![url isEqualToString:Xget_account_info])
                [ProgressHUD showProgressHUDInView:nil withText:responseModel.rspMsg afterDelay:1];
            XBlockExec(failBlock, responseModel);
        }
    } failure:^(NSError *error) {
        if (hud) {
            [hud hideAnimated:YES];
        }
        MyLog(@"%@->返回数据%@",url,error);
    }];
    
    
//    NSData * imageData = UIImageJPEGRepresentation(images[0], 0.1);
////
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
//                                                         @"text/html",
//                                                         @"image/jpeg",
//                                                         @"image/png",
//                                                         @"application/octet-stream",
//                                                         @"text/json",
//                                                         @"text/plain",
//                                                         nil];
//    NSString *str = [NSString stringWithFormat:@"%@%@",SERVICEURL,url];
//    NSURLSessionDataTask *task = [manager POST:str parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        NSData *imageDatas = imageData;
//
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        formatter.dateFormat = @"yyyyMMddHHmmss";
//        NSString *str = [formatter stringFromDate:[NSDate date]];
//        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
//        //上传的参数(上传图片，以文件流的格式)
//        [formData appendPartWithFileData:imageDatas
//                                    name:@"image"
//                                fileName:fileName
//                                mimeType:@"image/jpg"];
//
////        [params setObject:formData forKey:@"image"];
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        //上传进度
//
//        NSLog(@"%@",uploadProgress);
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        //上传成功
//        NSLog(@"上传成功");
//        if (hud) {
//            [hud hideAnimated:YES];
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        //上传失败
//        NSLog(@"上传失败========>%@",error);
//        if (hud) {
//            [hud hideAnimated:YES];
//        }
//    }];
//    [task resume];
}
@end
