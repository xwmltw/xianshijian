//
//  ExpectModel.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/27.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseParamModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ExpectModel : NSObject
@property (nonatomic ,strong) NSNumber *allEstimateProfit;
@property (nonatomic ,strong) NSNumber *currTypeAllEstimateProfit;
@property (nonatomic ,strong) NSArray *dataRows;
@property (nonatomic ,strong) PageQueryRedModel *pageQueryReq;
//allEstimateProfit (integer, optional): 预计总收益,单位为分 ,
//currTypeAllEstimateProfit (integer, optional): 当前收益类型预计总收益,单位为分 ,
//dataRows (Array[CtmProductEstimateProfitListVo], optional): 查询(分页)结果数据 ,
//pageQueryReq (PageQueryReq, optional): 分页参数bean
@end

@interface ExpectCellModel : NSObject
@property (nonatomic ,strong) NSString *createTime;
@property (nonatomic ,strong) NSNumber *profitAmount;
@property (nonatomic ,strong) NSString *profitAmountDesc;
@property (nonatomic ,strong) NSString *productNo;
@property (nonatomic ,strong) NSString *profitTypeDesc;
@property (nonatomic ,strong) NSString *profitAmountReceiveDesc;
@property (nonatomic ,assign) NSInteger width;
//createTime (string, optional): 创建时间(字符串格式) ,
//profitAmount (integer, optional): 预计收益金额，单位为分 ,
//profitAmountDesc (string, optional): 预计收益说明
//productNo (string, optional): 产品编号（预计收益类型为任务预计收益时有下发） ,
//profitTypeDesc (string, optional): 预计收益类型说明 ,
//profitAmountReceiveDesc (string, optional): 预计收益到账说明)
@end
NS_ASSUME_NONNULL_END
