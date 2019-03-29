//
//  TaskModel.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/28.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TaskModel : NSObject
@property (nonatomic ,copy) NSNumber *ctmSubmitDeadTimeLeft;
@property (nonatomic ,copy) NSNumber *entAuditDeadTimeLeft;
@property (nonatomic ,copy) NSString *prodTradeAuditRemark;
@property (nonatomic ,copy) NSNumber *prodTradeAuditStatus;
@property (nonatomic ,copy) NSNumber *prodTradeFinishTime;
@property (nonatomic ,copy) NSNumber *productApplyId;
@property (nonatomic ,copy) NSString *productFirstMainPicUrl;
@property (nonatomic ,copy) NSString *productNo;
@property (nonatomic ,copy) NSNumber *productSalary;
@property (nonatomic ,copy) NSNumber *productShareSalary;
@property (nonatomic ,copy) NSString *productSubmitType;
@property (nonatomic ,copy) NSString *productTitle;
//ctmSubmitDeadTimeLeft (integer, optional): 兼客截止提交任务剩余的时间戳，毫秒数 ,
//entAuditDeadTimeLeft (integer, optional): 雇主截止验收任务剩余的时间戳，毫秒数 ,
//prodTradeAuditRemark (string, optional): 雇主审核备注(不通过理由等) ,
//prodTradeAuditStatus (integer, optional): 审核状态：1系统通过 2验收通过 3未通过 ,
//prodTradeFinishTime (integer, optional): 审核时间 ,
//productApplyId (integer, optional): 产品领取id ,
//productFirstMainPicUrl (string, optional): 产品第一张主图地址 ,
//productNo (string, optional): 产品编号 ,
//productSalary (integer, optional): 产品薪资单价，单位为分 ,
//productShareSalary (integer, optional): 产品分享单价，单位为分 ,
//productSubmitType (string, optional): 任务提交方式说明(多种提交方式用,隔开)：1截图提交 2文本提交 ,
//productTitle (string, optional): 产品名称
@end


NS_ASSUME_NONNULL_END
