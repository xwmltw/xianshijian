//
//  UserInfo.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/21.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "UserInfo.h"
#import "XcacheHelper.h"

static  NSString * const userInfo = @"UserInfo";
static  UserInfo * userInfoModel = nil;   /*!< 用户信息 */

@implementation UserInfo
XSharedInstance(UserInfo);
MJCodingImplementation

- (void)saveUserInfo:(UserInfo *)model{
    
    [XCacheHelper saveByNSKeyedUnarchiverWith:self fileName:userInfo isCanClear:YES];
}
- (UserInfo *)getUserInfo{
    userInfoModel = [XCacheHelper getByNSKeyedUnarchiver:userInfo withClass:[UserInfo class] isCanClear:YES];
    return userInfoModel;
}
- (BOOL)isSignIn{
    userInfoModel  = [self getUserInfo];
    if (userInfoModel.token && userInfoModel.token.length > 0) {
        return YES;
    }
    return NO;
}
@end
