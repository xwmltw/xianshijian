//
//  HiBuyProductQueryModel.h
//  JianKeLife
//
//  Created by yanqb on 2019/4/22.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HiBuyProductQueryModel : NSObject

@property (nonatomic ,copy) NSNumber *prodClassifyId;
@property (nonatomic ,copy) NSString *keywords;
@property (nonatomic ,copy) NSNumber *orderType;
@property (nonatomic ,copy) NSNumber *minPrice;
@property (nonatomic ,copy) NSNumber *maxPrice;
@property (nonatomic ,strong) PageQueryRedModel *pageQueryReq;

//prodClassifyId (integer, optional): 产品分类id ,
//keywords (string, optional): 搜索关键词 ,
//orderType (integer, optional): 列表排序方式：1佣金由高到低，2佣金由低到高，3优惠券由高到低，4优惠券由低到高，5销量由高到低，6销量由低到高，7价格由高到低，8价格由低到高 ,
//minPrice (integer, optional): (注意)价格区间最小值，单位是元 ,
//maxPrice (integer, optional): (注意)价格区间最大值，单位是元 ,
//pageQueryReq (PageQueryReq): 分页参数bean
@end

NS_ASSUME_NONNULL_END
