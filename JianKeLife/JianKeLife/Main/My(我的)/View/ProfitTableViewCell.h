//
//  ProfitTableViewCell.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/26.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfitModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProfitTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labDetial;
@property (weak, nonatomic) IBOutlet UILabel *labMoney;
@property (weak, nonatomic) IBOutlet UILabel *labState;
@property (weak, nonatomic) IBOutlet UILabel *labDate;
@property (nonatomic ,strong) ProtifDetailModel *model;
@end

NS_ASSUME_NONNULL_END
