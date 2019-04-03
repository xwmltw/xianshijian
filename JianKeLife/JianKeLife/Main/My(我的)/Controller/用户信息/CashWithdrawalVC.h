//
//  CashWithdrawalVC.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/26.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "BaseMainVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface CashWithdrawalVC : BaseMainVC
@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;
@property (weak, nonatomic) IBOutlet UILabel *balanceLab;
@property (weak, nonatomic) IBOutlet UILabel *detailbLab;
@property (weak, nonatomic) IBOutlet UILabel *firstLab;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIButton *wxBtn;
@property (nonatomic ,copy) NSNumber *balance;
@end
NS_ASSUME_NONNULL_END
