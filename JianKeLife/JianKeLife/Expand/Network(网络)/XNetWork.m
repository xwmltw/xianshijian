//
//  XNetWork.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/18.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "XNetWork.h"
#import "XControllerViewHelper.h"
#import "LoginVC.h"

@implementation XNetWork
XSharedInstance(XNetWork)
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
+ (void)requestNetWorkWithUrl:(NSString *)url andModel:(NSObject * _Nullable)model andSuccessBlock:(ResponseBlock)successBlock andFailBlock:(ResponseBlock _Nullable)failBlock{
    
    
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
    
    [XNetWork sharedInstance].block = successBlock;
    [XNetWork sharedInstance].netDic = model;
    [XNetWork sharedInstance].netUrl = url;
    
    [NetWorkManager requestDataForPOSTWithURL:url parameters:params Controller:nil UploadProgress:nil success:^(id responseObject) {
        if (hud) {
            [hud hideAnimated:YES];
        }

        MyLog(@"%@->返回数据%@",url,responseObject);
        ResponseModel *responseModel = [ResponseModel mj_objectWithKeyValues:responseObject];
        if (responseModel.rspCode.integerValue == 0) {
            XBlockExec(successBlock, responseModel);
        }else{
            if (responseModel.rspCode.integerValue == 1011) {

                [XNetWork unLoginNotification];
                return;
            }
            if(![url isEqualToString:Xget_account_info])
            [ProgressHUD showProgressHUDInView:nil withText:responseModel.rspMsg afterDelay:1];
            XBlockExec(failBlock, responseModel);
        }
    } failure:^(NSError *error) {
        if (hud) {
            [hud hideAnimated:YES];
        }
        [XNetWork creatNoDataView];
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
+ (void)unLoginNotification{
    [XAlertView alertWithTitle:@"提示" message:@"未登录或登录信息过期~请前往登录!" cancelButtonTitle:@"取消" confirmButtonTitle:@"登录" viewController:[XControllerViewHelper getTopViewController] completion:^(UIAlertAction *action, NSInteger buttonIndex) {
        
        if (buttonIndex == 1) {
            LoginVC *vc = [[LoginVC alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [[XControllerViewHelper getTopViewController].navigationController pushViewController:vc animated:YES];
        }
        return ;
    }];
}

+ (void)creatNoDataView{
//    UIViewController *vc = [XControllerViewHelper getTopViewController];
    UIView *noDataView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    
    noDataView.tag = 99999;
    noDataView.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication].keyWindow addSubview:noDataView];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"icon_noNetword"];
    [noDataView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(noDataView);
        make.top.mas_equalTo(noDataView).offset(140);
        
    }];
    UILabel *lab = [[UILabel alloc]init];
    [lab setText:@"无网络状态"];
    [lab setFont:[UIFont systemFontOfSize:16]];
    [lab setTextColor:LabelMainColor];
    [noDataView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(noDataView);
        make.top.mas_equalTo(imageView.mas_bottom).offset(34);
    }];
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:@"刷新一下" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [btn setBackgroundColor:blueColor];
    [btn setCornerValue:4];
    [btn addTarget:[XNetWork sharedInstance] action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [noDataView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(noDataView);
        make.top.mas_equalTo(lab.mas_bottom).offset(20);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
}
- (void)btnOnClick:(UIButton *)btn{
    [XNetWork requestNetWorkWithUrl:self.netUrl andModel:self.netDic andSuccessBlock:self.block andFailBlock:nil];
    UIView *new = (UIView *)[[XControllerViewHelper getTopView] viewWithTag:99999];
    [new removeFromSuperview];

}
@end
