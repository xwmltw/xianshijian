//
//  MyOrderModel.h
//  JianKeLife
//
//  Created by yanqb on 2019/4/19.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyOrderModel : NSObject
@property (nonatomic ,strong) NSString *orderType;
@property (nonatomic ,strong) NSString *orderCreateTime;
@property (nonatomic ,strong) NSString *itemTitle;
@property (nonatomic ,strong) NSString *tradeId;
@property (nonatomic ,strong) NSNumber *tkStatus;
@property (nonatomic ,strong) NSNumber *alipayTotalPrice;
@property (nonatomic ,strong) NSNumber *pubSharePreFee;
@property (nonatomic ,strong) NSString *pictUrl;
//orderType (string, optional): 订单类型，如天猫，淘宝 ,
//orderCreateTime (string, optional): 订单创建时间 ,
//itemTitle (string, optional): 商品标题 ,
//tradeId (string, optional): 淘宝订单号 ,
//tkStatus (string, optional): 淘客订单状态，3：订单结算，12：订单付款， 13：订单失效，14：订单成功 ,
//alipayTotalPrice (number, optional): 付款金额 ,
//pubSharePreFee (number, optional): 预估收益 ,
//pictUrl (string, optional): 商品信息-商品主图
@end

NS_ASSUME_NONNULL_END
