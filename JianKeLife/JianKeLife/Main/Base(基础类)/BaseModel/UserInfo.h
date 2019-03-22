//
//  UserInfo.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/21.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfo : NSObject
@property(nonatomic,copy)NSString *phoneName;
@property(nonatomic,copy)NSString *password;
@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *token;
+ (instancetype)sharedInstance;
- (void)saveUserInfo:(UserInfo *)model;
- (BOOL)isSignIn;
@end

NS_ASSUME_NONNULL_END
