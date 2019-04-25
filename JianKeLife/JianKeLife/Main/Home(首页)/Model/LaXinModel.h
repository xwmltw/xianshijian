//
//  LaXinModel.h
//  JianKeLife
//
//  Created by yanqb on 2019/4/25.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LaXinModel : NSObject
@property (nonatomic ,strong) NSNumber *isFinished;
@property (nonatomic ,strong) NSNumber *isCompleteFirstTask;
@property (nonatomic ,strong) NSNumber *totalAmount;
@property (nonatomic ,strong) NSNumber *minWithdrawAmount;
@property (nonatomic ,strong) NSString *activityPageUrl;
@property (nonatomic ,strong) NSString *productNo;
//isFinished (integer, optional): 活动是否已经结束：1是 0否 ,
//isCompleteFirstTask (integer, optional): 是否已经完成首单任务：1是 0否 ,
//totalAmount (integer, optional): 当前账户余额(单位是分) ,
//minWithdrawAmount (integer, optional): 最低提现金额(单位是分) ,
//activityPageUrl (string, optional): 拉新活动页面地址 ,
//productNo (string, optional): 产品uuid编号(有完成任务的情况下会下发)
@end

NS_ASSUME_NONNULL_END
