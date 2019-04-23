//
//  HiBuyDetailModel.h
//  JianKeLife
//
//  Created by yanqb on 2019/4/23.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HiBuyDetailModel : NSObject
@property (nonatomic ,strong) NSNumber *id;
@property (nonatomic ,strong) NSString *title;
@property (nonatomic ,strong) NSString *shopTitle;
@property (nonatomic ,strong) NSArray *smallPicUrl;
@property (nonatomic ,strong) NSNumber *volume;
@property (nonatomic ,strong) NSNumber *zkFinalPrice;
@property (nonatomic ,strong) NSNumber *afterCouplePrice;
@property (nonatomic ,strong) NSNumber *couponAmount;
@property (nonatomic ,strong) NSNumber *commissionAmount;
@property (nonatomic ,strong) NSString *productDetailPageUrl;
@property (nonatomic ,assign) NSInteger cellWidth;
//id (integer, optional): 商品id ,
//title (string, optional): 商品信息-商品名称 ,
//shopTitle (string, optional): 店铺信息-店铺名称 ,
//smallPicUrl (Array[Inline Model 1], optional): 商品小图列表，json数组 ,
//volume (integer, optional): 商品信息-30天销量 ,
//zkFinalPrice (number, optional): 商品信息-商品折扣价格，单位是元 ,
//afterCouplePrice (number, optional): 商品信息-商品券后价格（优惠券面额>0时显示这个），单位是元 ,
//couponAmount (integer, optional): 优惠券信息-优惠券面额，单位是元 ,
//commissionAmount (number, optional): 返佣金额，单位是元,金额为0时，不展示字段 ,
//productDetailPageUrl (string, optional): 商品详情-页面地址
@end

NS_ASSUME_NONNULL_END
