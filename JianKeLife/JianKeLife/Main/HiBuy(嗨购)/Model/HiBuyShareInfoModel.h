//
//  HiBuyShareInfoModel.h
//  JianKeLife
//
//  Created by yanqb on 2019/4/23.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HiBuyShareInfoModel : NSObject
@property (nonatomic ,strong) NSNumber *hasAuthorize;
@property (nonatomic ,strong) NSString *authorizePageUrl;
@property (nonatomic ,strong) NSString *tpwd;
@property (nonatomic ,strong) NSString *tpwdTextDesc;
@property (nonatomic ,strong) NSString *title;
@property (nonatomic ,strong) NSString *zkFinalPrice;
@property (nonatomic ,strong) NSString *afterCouplePrice;
@property (nonatomic ,strong) NSString *couponAmount;
@property (nonatomic ,strong) NSString *commissionAmount;
@property (nonatomic ,strong) NSArray *smallPicUrl;
@property (nonatomic ,strong) NSString *couponShareUrl;
//hasAuthorize (integer, optional): 是否已经授权：1是 0否 ,
//authorizePageUrl (string, optional): 授权页面地址，未授权的情况下下发 ,
//tpwd (string, optional): 淘口令文案 ,
//tpwdTextDesc (string, optional): 淘口令文案描述 ,
//title (string, optional): 商品信息-商品名称 ,
//zkFinalPrice (number, optional): 商品信息-商品折扣价格 ,
//afterCouplePrice (number, optional): 商品信息-商品券后价格（优惠券面额>0时显示这个） ,
//couponAmount (integer, optional): 优惠券信息-优惠券面额 ,
//commissionAmount (number, optional): 返佣金额,金额为0时，不展示字段 ,
//smallPicUrl (Array[Inline Model 1], optional): 商品小图列表，json数组 ,
//couponShareUrl (string, optional): 链接-宝贝+券二合一页面链接
@end

NS_ASSUME_NONNULL_END
