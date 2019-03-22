//
//  BaseParamModel.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/21.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class PageQueryRedModel,PageQueryDataModel,BannerAdList,SpecialEntryList,VersionInfo;

@interface BaseParamModel : NSObject

@end
@interface BaseInfoPM : BaseParamModel
@property (nonatomic ,copy) NSString *accessChannelCode;
@property (nonatomic ,copy) NSString *accessToken;
@property (nonatomic ,copy) NSString *appVersionCode;
@property (nonatomic ,copy) NSNumber *cityId;
@property (nonatomic ,copy) NSNumber *clientType;
@property (nonatomic ,strong) PageQueryDataModel *data;
@property (nonatomic ,copy) NSString *imei;
@property (nonatomic ,copy) NSString *uid;
@end

@interface PageQueryDataModel : BaseParamModel
@property (nonatomic ,strong) PageQueryRedModel *pageQueryReq;
@end

@interface PageQueryRedModel : BaseParamModel
@property (nonatomic ,copy) NSNumber *page;
@property (nonatomic ,copy) NSNumber *pageSize;
@end

@interface ClientGlobalInfo:BaseParamModel
@property (nonatomic ,copy) NSString *aboutUsUrl;
@property (nonatomic ,strong) NSArray *bannerAdList;
@property (nonatomic ,copy) NSString *customerContact;
@property (nonatomic ,copy) NSString *registerAgreementUrl;
@property (nonatomic ,strong) NSArray *specialEntryList;
@property (nonatomic ,strong) VersionInfo *versionInfo;
- (void)setClientGlobalInfoModel;
+ (ClientGlobalInfo *)getClientGlobalInfoModel;
@end

@interface BannerAdList : ClientGlobalInfo
@property (nonatomic ,copy) NSString *adContent;
@property (nonatomic ,copy) NSString *adDetailUrl;
@property (nonatomic ,copy) NSNumber *adId;
@property (nonatomic ,copy) NSString *adImgUrl;
@property (nonatomic ,copy) NSString *adName;
@property (nonatomic ,copy) NSNumber *adType;
@end

@interface SpecialEntryList : ClientGlobalInfo
@property (nonatomic ,copy) NSNumber *isNeedLogin;
@property (nonatomic ,copy) NSString *specialEntryDesc;
@property (nonatomic ,copy) NSString *specialEntryIcon;
@property (nonatomic ,copy) NSNumber *specialEntryId;
@property (nonatomic ,copy) NSString *specialEntryTitle;
@property (nonatomic ,copy) NSNumber *specialEntryType;
@property (nonatomic ,copy) NSString *specialEntryUrl;
@end

@interface VersionInfo : ClientGlobalInfo
@property (nonatomic ,copy) NSNumber *needForceUpdate;
@property (nonatomic ,copy) NSString *url;
@property (nonatomic ,copy) NSNumber *version;
@property (nonatomic ,copy) NSString *versionDesc;
@end

@interface ResponseModel : BaseParamModel
@property (nonatomic ,copy) NSNumber *rspCode;
@property (nonatomic ,copy) NSString *rspMsg;
@property (nonatomic ,copy) NSDictionary *data;
@end
NS_ASSUME_NONNULL_END
