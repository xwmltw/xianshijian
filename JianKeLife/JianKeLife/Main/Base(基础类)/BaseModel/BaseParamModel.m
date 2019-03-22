//
//  BaseParamModel.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/21.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "BaseParamModel.h"
#import "XDeviceHelper.h"
#import "UserLocation.h"
#import "XCacheHelper.h"

@implementation BaseParamModel
- (instancetype)init{
    self = [super init];
    if (self) {
    }
    return self;
}
@end

@implementation BaseInfoPM
- (instancetype)init{
    self = [super init];
    if (self) {
        self.accessChannelCode = @"AppStore";
        self.appVersionCode = [NSString stringWithFormat:@"%d",[XDeviceHelper getAppIntVersion]];
        self.cityId = @([[UserLocation sharedInstance].cityCode integerValue]);
        self.clientType = @1;
//        self.data = [[PageQueryDataModel alloc]init];
        self.imei = @"";
        self.uid = [XDeviceHelper getUUID];
        
    }
    return self;
}
//accessChannelCode (string, optional): 渠道识别码 ,
//accessToken (string, optional): token信息. ,
//appVersionCode (string, optional): 客户端版本号 ,
//cityId (integer, optional): 城市id ,
//clientType (integer, optional): 客户端类型, 1 ios, 2 android , 3 wap ,
//data (PageQueryData, optional): 分页参数bean ,
//imei (string, optional): 客户端imei ,
//uid (string, optional): 客户端uid（ios）
@end

@implementation PageQueryDataModel
- (instancetype)init{
    self = [super init];
    if (self) {
        self.pageQueryReq = [PageQueryRedModel new];
    }
    return self;
}
//pageQueryReq (PageQueryReq, optional): 分页参数bean
@end

@implementation PageQueryRedModel
- (instancetype)init{
    self = [super init];
    if (self) {
        self.pageSize = @10;
        self.page = @1;
    }
    return self;
}
//page (integer, optional): 分页的页码,1为第一页,默认1 ,
//pageSize (integer, optional): 页面大小,默认10

@end

@implementation ClientGlobalInfo

MJCodingImplementation
- (void)setClientGlobalInfoModel{
    
    [XCacheHelper saveToFileWithModel:self fileName:@"ClientGlobalInfoModel" isCanClear:NO];
}
+ (ClientGlobalInfo *)getClientGlobalInfoModel{
    return  [XCacheHelper getModelWithFileName:@"ClientGlobalInfoModel" withClass:[ClientGlobalInfo class] isCanClear:NO];
}

//aboutUsUrl (string, optional): 关于我们页面地址 ,
//bannerAdList (Array[AdInfoVo], optional): banner广告列表 ,
//customerContact (string, optional): 客服联系方式 ,
//registerAgreementUrl (string, optional): 注册协议地址 ,
//specialEntryList (Array[SpecialEntryInfoVo], optional): 特色入口列表 ,
//versionInfo (VersionInfoVo, optional): 版本自动更新
@end

@implementation BannerAdList

//adContent (string, optional): 广告内容 ,
//adDetailUrl (string, optional): 广告详情url ,
//adId (integer, optional): 广告id ,
//adImgUrl (string, optional): 广告内图片地址 ,
//adName (string, optional): 广告名称 ,
//adType (integer, optional): 广告类型 1:应用内（本地）打开链接，2:浏览器(新窗口)打开链接

@end

@implementation SpecialEntryList


//isNeedLogin (integer, optional): 进入该特色入口是否需要登录：1是0 否 ,
//specialEntryDesc (string, optional): 特色入口描述语 ,
//specialEntryIcon (string, optional): 特色入口图标地址 ,
//specialEntryId (integer, optional): 特色入口id ,
//specialEntryTitle (string, optional): 特色入口名称 ,
//specialEntryType (integer, optional): 特色入口类型 1:应用内打开链接，2:应用外打开链接 3产品列表 ,
//specialEntryUrl (string, optional): 特色入口url链接

@end

@implementation VersionInfo


//needForceUpdate (integer, optional): 强制升级 1是,0否 ,
//url (string, optional): 升级地址 ,
//version (integer, optional): 版本号 ,
//versionDesc (string, optional): 版本说明
@end

@implementation ResponseModel
@end
