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
static NSString *const WXLoginNotification = @"WXLoginNotification";
/**接口名称*/

#define Xget_global_info            @"/mapi/global/get_global_info" //全局
#define Xadvertise_access_log       @"/mapi/global/advertise_access_log"//广告点击记录
#define Xclick_log                  @"/mapi/specail_entry/click_log"//特色入口点击记录

#define Xupload                     @"/mapi/file/upload"//上传文件

#define Xquery_product_list         @"/mapi/specail_entry/query_product_list"//查询产品列表

#define XLogin_Register             @"/mapi/session/register_login"//登录注册
#define Xlogout                     @"/mapi/session/logout"//退出登录
#define Xget_sms_code               @"/mapi/valid/get_sms_code"//获取验证码


#define Xsubmit_feedback_log        @"/mapi/feedback/submit_feedback_log"//意见反馈

#define Xproduct_list               @"/mapi/product/list"   //热门产品列表
#define Xproduct_search             @"/mapi/product/search"//搜索产品
#define Xproduct_detail             @"/mapi/product/detail"//产品详情
#define Xproduct_apply              @"/mapi/product_apply/apply"//领取产品
#define XqueryProductShareInfo      @"/mapi/product/queryProductShareInfo"//分享信息



#define Xproduct_apply_task         @"/mapi/product_apply/list"//查询产品领取列表（任务模块）
#define Xproduct_apply_abandon      @"/mapi/product_apply/abandon"//放弃产品
#define Xproduct_apply_detail       @"/mapi/product_apply/detail"//获取产品q领取d详情数据
#define Xproduct_apply_submit       @"/mapi/product_apply/submit"//提交领取产品

#define Xget_account_info           @"/mapi/ctm/get_account_info"//获取用户账号基本信息
#define Xedit_account_info          @"/mapi/ctm/edit_account_info"//编辑用户账号基本信息
#define Xget_base_info              @"/mapi/ctm/get_base_info"//获取用户资料信息
#define Xedit_head_logo             @"/mapi/ctm/edit_head_logo"//编辑头像

#define Xquery_flow_list            @"/mapi/trade/query_flow_list"//交易流水查询
#define Xquery_withdraw_cfg         @"/mapi/trade/query_withdraw_cfg"//提现o配置信息
#define Xwechat_cash_withdraw       @"/mapi/trade/wechat_cash_withdraw"//微信提现
#define Xset_money_pwd              @"/mapi/session/set_money_pwd"//设置钱袋子密码
#define Xedit_money_pwd             @"/mapi/session/edit_money_pwd"//修改钱包密码
#define Xfind_money_pwd             @"/mapi/session/find_money_pwd"//找回钱包密码

#define Xestimate_list               @"/mapi/profit/estimate_list"//查询预计收益列表

#define Xget_connections_info       @"/mapi/ctm/get_connections_info"//获取人脉信息
#define Xget_first_connections_info @"/mapi/ctm/get_first_connections_info"//一级人脉
#define Xget_second_connections_info       @"/mapi/ctm/get_second_connections_info"//二级人脉
#endif /* AppUitls_h */
