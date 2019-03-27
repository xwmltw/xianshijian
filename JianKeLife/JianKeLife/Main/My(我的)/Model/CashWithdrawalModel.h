//
//  CashWithdrawalModel.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/27.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CashWithdrawalModel : NSObject
@property (nonatomic ,strong) NSNumber *isSetPwd;
@property (nonatomic ,strong) NSNumber *minwithdrawAmount;
@property (nonatomic ,strong) NSArray *withdrawRuleDesc;
@property (nonatomic ,strong) NSString *withdrawServiceRate;
@property (nonatomic ,strong) NSString *wxAppId;
@property (nonatomic ,strong) NSString *wxAppSecret;
//isSetPwd (integer, optional): 是否设置过密码 0未设置 1已设置 ,
//minwithdrawAmount (integer, optional): 最低提现金额，单位为分 ,
//withdrawRuleDesc (Array[Inline Model 1], optional): 提现规则说明(json数组) ,
//withdrawServiceRate (string, optional): 提现服务费比例(百分比) ,
//wxAppId (string, optional): wxAppId ,
//wxAppSecret (string, optional): wxAppSecret
@end

NS_ASSUME_NONNULL_END
