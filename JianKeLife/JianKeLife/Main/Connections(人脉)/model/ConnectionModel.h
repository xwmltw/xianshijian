//
//  ConnectionModel.h
//  JianKeLife
//
//  Created by 肖伟民 on 2019/3/28.
//  Copyright © 2019 xwm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConnectionModel : NSObject
@property(nonatomic ,copy) NSString *connectionsInviteRegUrl;
@property(nonatomic ,copy) NSNumber *firstConnectionsCount;
@property(nonatomic ,copy) NSNumber *firstCut;
@property(nonatomic ,copy) NSNumber *profitAmt;
@property(nonatomic ,copy) NSString *ruleText;
@property(nonatomic ,copy) NSNumber *secondConnectionsCount;
@property(nonatomic ,copy) NSNumber *totalCount;
@property(nonatomic ,copy) NSString *inviteCode;
@property(nonatomic ,copy) NSNumber *connectionProfitAmtOfThisWeek;
@property(nonatomic ,copy) NSNumber *firstConnectionsCountOfThisWeek;
@property(nonatomic ,copy) NSNumber *secondConnectionsCountOfThisWeek;
//connectionsInviteRegUrl (string, optional): 人脉推广注册链接 ,
//firstConnectionsCount (integer, optional): 一级人脉数 ,
//firstCut (number, optional): 一级人脉佣金比例 ,
//profitAmt (integer, optional): 人脉收益(分) ,
//ruleText (string, optional): 奖励规则 ,
//secondConnectionsCount (integer, optional): 二级人脉数 ,
//totalCount (integer, optional): 已邀请人脉总数
//inviteCode (string, optional): 当前登录用户推广码 ,
//connectionProfitAmtOfThisWeek (integer, optional): 本周人脉收益(分) ,
//firstConnectionsCountOfThisWeek (integer, optional): 本周新增一级人脉数 ,
//secondConnectionsCountOfThisWeek (integer, optional): 本周新增二级人脉数
@end
@interface ConnectionFirstModel :NSObject
@property(nonatomic ,copy) NSNumber *firstConnectionsCount;
@property(nonatomic ,copy) NSString *headLogo;
@property(nonatomic ,copy) NSNumber *id;
@property(nonatomic ,copy) NSNumber *profitAmt;
@property(nonatomic ,copy) NSString *telephone;
@property(nonatomic ,copy) NSString *trueName;
//firstConnectionsCount (integer, optional): 下一人脉数 ,
//headLogo (string, optional): 头像 ,
//id (integer, optional): 人脉ID ,
//profitAmt (integer, optional): 累计收益 ,
//telephone (string, optional): 手机号 ,
//trueName (string, optional): 姓名
@end
NS_ASSUME_NONNULL_END
