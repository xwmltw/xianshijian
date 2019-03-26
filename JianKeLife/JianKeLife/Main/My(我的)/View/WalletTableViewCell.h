//
//  WalletTableViewCell.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/26.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfitModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface WalletTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labDetail;
@property (weak, nonatomic) IBOutlet UILabel *labDate;
@property (weak, nonatomic) IBOutlet UILabel *labMoney;
@property (nonatomic ,strong) ProtifDetailModel *model;
@end

NS_ASSUME_NONNULL_END
