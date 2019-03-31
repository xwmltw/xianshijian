//
//  XNetWork.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/18.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ResponseBlock)(ResponseModel *model);
NS_ASSUME_NONNULL_BEGIN

@interface XNetWork : NSObject
@property (nonatomic ,copy) NSString *netUrl;
@property (nonatomic ,strong) NSObject *_Nullable netDic;
@property (nonatomic ,copy) ResponseBlock block;
+ (instancetype)sharedInstance;
/**
 微信授权登录请求

 @param appID <#appID description#>
 @param secret <#secret description#>
 @param block <#block description#>
 */
+ (void)getWXLoginAppID:(NSString *)appID andSecret:(NSString *)secret andCode:(NSString *)code andBlock:(XBlock)block;


/**
 请求接口

 @param url 请求地址
 @param model 参数
 @param SuccessBlock 回调信息
 */
+ (void)requestNetWorkWithUrl:(NSString *)url andModel:(NSObject *_Nullable)model andSuccessBlock:(ResponseBlock)successBlock andFailBlock:(ResponseBlock _Nullable)failBlock;


/**
 上传

 @param url <#url description#>
 @param images <#images description#>
 @param width <#width description#>
 @param successBlock <#successBlock description#>
 @param failBlock <#failBlock description#>
 */
+ (void)UploadPicturesWithUrl:(NSString *)url  images:(NSArray *)images targetWidth:(CGFloat )width andSuccessBlock:(ResponseBlock)successBlock andFailBlock:(ResponseBlock)failBlock;

@end

NS_ASSUME_NONNULL_END
