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
//#define SERVICEURL @"https://mapi.xianshijian.com" // 正式环境
#define SERVICEURL @"http://jkl-mapi.pdl001.com" // 测试环境
//#define SERVICEURL @"http://192.168.5.126:8053"
#else
#define SERVICEURL @"https://mapi.xianshijian.com" // 正式环境
#endif

static NSString *const TalkingData_ChannelId = @"AppStore";
static NSString *const AppName = @"今日值享";
static NSString *const APPLOGO = @"LOGO";
static NSString *const AppScheme = @"jiankelife";
static NSString *const AMapKey = @"fb8e853ae0912b459da9ae8a1c2b1217";
static NSString *const TalkingData_AppID =   @"33325C427A76485088AB7D63A0F9CAA2";
static NSString *const JPAppKey = @"923c85c3da3da6f68b4a715d";

/**通知*/
static NSString *const UnLoginNotification = @"UnLoginNotification";
static NSString *const LoginSuccessNotification = @"LoginSuccessNotification";
static NSString *const WXLoginNotification = @"WXLoginNotification";
static NSString *const TaskReturnNotification = @"TaskReturnNotification";
static NSString *const HomeRedNotification = @"HomeRedNotification";
/****进入置顶通知****/
#define kHomeGoTopNotification               @"Home_Go_Top"
/****离开置顶通知****/
#define kHomeLeaveTopNotification            @"Home_Leave_Top"
/**接口名称*/

#define Xget_global_info            @"/mapi/global/get_global_info" //全局
#define Xadvertise_access_log       @"/mapi/global/advertise_access_log"//广告点击记录
#define Xclick_log                  @"/mapi/specail_entry/click_log"//特色入口点击记录

#define Xupload                     @"/mapi/file/upload"//上传文件

#define Xquery_product_list         @"/mapi/specail_entry/query_product_list"//特色查询产品列表

#define XLogin_Register             @"/mapi/session/register_login"//登录注册
#define Xlogout                     @"/mapi/session/logout"//退出登录
#define Xget_sms_code               @"/mapi/valid/get_sms_code"//获取验证码


#define Xsubmit_feedback_log        @"/mapi/feedback/submit_feedback_log"//意见反馈

#define Xproduct_list               @"/mapi/product/list"   //热门产品列表
#define Xproduct_search             @"/mapi/product/search"//搜索产品
#define Xproduct_detail             @"/mapi/product/detail"//产品详情
#define Xproduct_apply              @"/mapi/product_apply/apply"//领取产品
#define XqueryProductShareInfo      @"/mapi/global/query_share_info"//分享信息



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
#define Xcheck_pwd                  @"/mapi/trade/check_pwd"//校验提现密码
#define Xwechat_cash_withdraw       @"/mapi/trade/wechat_cash_withdraw"//微信提现
#define Xset_money_pwd              @"/mapi/session/set_money_pwd"//设置钱袋子密码
#define Xedit_money_pwd             @"/mapi/session/edit_money_pwd"//修改钱包密码
#define Xfind_money_pwd             @"/mapi/session/find_money_pwd"//找回钱包密码

#define Xestimate_list               @"/mapi/profit/estimate_list"//查询预计收益列表
#define Xestimate_list_2             @"/mapi/profit/estimate_list_2"//查询预计收益all列表

#define Xget_connections_info       @"/mapi/ctm/get_connections_info"//获取人脉信息
#define Xlist_member_task           @"/mapi/ctm/list_member_task"//会员信息
#define Xget_first_connections_info @"/mapi/ctm/get_first_connections_info"//一级人脉
#define Xget_second_connections_info       @"/mapi/ctm/get_second_connections_info"//二级人脉

#define Xtb_order_list              @"/mapi/union/tb_order/list"//淘宝订单列表
#define Xtb_classify_list           @"/mapi/union/tb_product/classify_list"//查询商品分类信息
#define Xquery_tb_product_keyword   @"/mapi/global/query_tb_product_keyword"//搜索关键词
#define Xtb_product_list            @"/mapi/union/tb_product/list" //淘宝商品列表
#define Xlist_favorite_product      @"/mapi/union/tb_product/list_favorite_product"//x查询淘宝商品（选品商品）
#define Xtb_product_detail          @"/mapi/union/tb_product/detail"//产品详情
#define Xtb_product_couponBuy       @"/mapi/union/tb_product/couponBuy"//领取产品
#define Xtb_product_getShareInfo    @"/mapi/union/tb_product/getShareInfo"//分享信息
#define Xintroduce_new_complete_data    @"/mapi/activity/introduce_new_complete_data"//拉新信息弹窗


#define Xget_message_list           @"/mapi/message/list"//消息中心列表
#define Xred_point_info             @"/mapi/message/red_point_info"//获取小红点信心

#define Xupdate_push                @"/mapi/global/update_push"//推送信息上传
#endif /* AppUitls_h */
