//
//  ProfitModel.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/26.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfitModel : NSObject
@property (nonatomic ,strong) NSNumber *actualReceviceAmt;
@property (nonatomic ,strong) NSArray *dataRows;
@property (nonatomic ,strong) NSDictionary *pageQueryReq;
@property (nonatomic ,strong) NSNumber *totalAmount;
//actualReceviceAmt (integer, optional): 到账总收益,单位为分 ,
//dataRows (Array[CtmTradeFlowListVo], optional): 查询(分页)结果数据 ,
//pageQueryReq (PageQueryReq, optional): 分页参数bean ,
//totalAmount (integer, optional): 账户余额,单位为分
@end

@interface ProtifDetailModel : NSObject
@property (nonatomic ,strong) NSString *moneyFlowTitle;
@property (nonatomic ,strong) NSString *moneyFlowTypeDesc;
@property (nonatomic ,strong) NSNumber *tradeAmount;
@property (nonatomic ,strong) NSString *tradeTime;
//moneyFlowTitle (string, optional): 流水标题 ,
//moneyFlowTypeDesc (string, optional): 流水类型描述 ,
//tradeAmount (integer, optional): 流水金额，单位为分,正数表示入账、负数表示出账 ,
//tradeTime (string, optional): 交易时间(字符串格式)
@end
NS_ASSUME_NONNULL_END
