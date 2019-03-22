//
//  AppUitls.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/4.
//  Copyright © 2019年 xwm. All rights reserved.
//

#ifndef AppUitls_h
#define AppUitls_h
/** APP配置信息*/
#ifdef DEBUG
#define SERVICEURL @"http://jkl-mapi.pdl001.com" // 测试环境
#else
#define SERVICEURL @"" // 正式环境
#endif

static NSString *const TalkingData_ChannelId = @"AppStore";
static NSString *const AppName = @"兼客生活";
static NSString *const APPLOGO = @"LOGO";
static NSString *const AppScheme = @"jiankelife";
static NSString *const AMapKey = @"d40775054eee7a471c44abbf3760b95c";
static NSString *const TalkingData_AppID =   @"";

/**通知*/

static NSString *const LoginSuccessNotification = @"LoginSuccessNotification";

/**接口名称*/

#define Xget_global_info  @"/mapi/global/get_global_info" //全局

#define XLogin_Register   @"/mapi/session/register_login"//登录注册
#define  Xlogout           @"/mapi/session/logout"//r退出登录
#define Xget_sms_code     @"/mapi/valid/get_sms_code"//获取验证码
#define Xedit_money_pwd   @"/mapi/session/edit_money_pwd"//修改钱包密码


#define Xproduct_list     @"/mapi/product/list"   //热门产品列表
#endif /* AppUitls_h */
