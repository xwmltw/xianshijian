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


/**
 微信授权登录请求

 @param appID <#appID description#>
 @param secret <#secret description#>
 @param block <#block description#>
 */
- (void)getWXLoginAppID:(NSString *)appID andSecret:(NSString *)secret andCode:(NSString *)code andBlock:(XBlock)block;


/**
 请求接口

 @param url 请求地址
 @param model 参数
 @param SuccessBlock 回调信息
 */
+ (void)requestNetWorkWithUrl:(NSString *)url andModel:(NSObject *_Nullable)model andSuccessBlock:(ResponseBlock)successBlock andFailBlock:(ResponseBlock)failBlock;
@end

NS_ASSUME_NONNULL_END
