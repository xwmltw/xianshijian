//
//  ProductModel.h
//  JianKeLife
//
//  Created by 肖伟民 on 2019/3/24.
//  Copyright © 2019 xwm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductModel : NSObject
@property (nonatomic ,copy) NSNumber *hasApplyProd;
@property (nonatomic ,copy) NSNumber *prodApplyCount;
@property (nonatomic ,copy) NSNumber *prodTradeAuditStatus;
@property (nonatomic ,copy) NSNumber *prodTradeStatus;
@property (nonatomic ,copy) NSString *productDeadTimeDesc;
@property (nonatomic ,copy) NSString *productDesc;
@property (nonatomic ,copy) NSString *productGroupOrientedDesc;
@property (nonatomic ,copy) NSArray *productMainPicUrl;
@property (nonatomic ,copy) NSString *productNo;
@property (nonatomic ,copy) NSNumber *productApplyId;
@property (nonatomic ,copy) NSString *productSubmitType;
@property (nonatomic ,copy) NSNumber *productSalary;
@property (nonatomic ,copy) NSNumber *productShareSalary;
@property (nonatomic ,copy) NSString *productTitle;
@property (nonatomic ,copy) NSString *productUrl;
@property (nonatomic ,assign) NSInteger cellWidth;
@property (nonatomic ,assign) NSInteger cell2Width;

//hasApplyProd (integer, optional): 当前用户是否已经领取过当前产品：1是 0否 ,
//prodApplyCount (integer, optional): 产品已领取量 ,
//prodTradeAuditStatus (integer, optional): 产品领取审核状态：1系统通过 2验收通过 3未通过 ,
//prodTradeStatus (integer, optional): 产品领取状态：1已领取 2已提交 3已完结 4已失效 5已放弃 ,
//productDeadTimeDesc (string, optional): 产品领取期限描述(整个字符串) ,
//productDesc (string, optional): 产品简介 ,
//productGroupOrientedDesc (string, optional): 产品面向群体说明 ,
//productMainPicUrl (Array[Inline Model 1], optional): 产品主图地址，json数组 ,
//productNo (string, optional): 产品uuid编号 ,
//productSalary (integer, optional): 产品薪资单价，单位为分 ,
//productShareSalary (integer, optional): 产品分享单价，单位为分 ,
//productTitle (string, optional): 产品名称 ,
//productUrl (string, optional): 产品链接
@end

NS_ASSUME_NONNULL_END
