//
//  MyModel.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/18.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyModel : NSObject
@property (nonatomic ,strong) NSNumber *actualReceviceAmt;
@property (nonatomic ,strong) NSNumber *forecastReceviceAmt;
@property (nonatomic ,strong) NSString *headLogo;
@property (nonatomic ,strong) NSString *telephone;
@property (nonatomic ,strong) NSNumber *totalAmount;
@property (nonatomic ,strong) NSString *trueName;
//actualReceviceAmt (integer, optional): 到账总收益 ,
//forecastReceviceAmt (integer, optional): 预计收益 ,
//headLogo (string, optional): 头像 ,
//telephone (string, optional): 手机号 ,
//totalAmount (integer, optional): 钱包余额 ,
//trueName (string, optional): 姓名
@end

NS_ASSUME_NONNULL_END
