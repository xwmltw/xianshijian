//
//  WalletTableView.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/26.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfitViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface WalletTableView : UITableView
@property (nonatomic ,strong) ProfitViewModel *profitViewModel;
@end

NS_ASSUME_NONNULL_END
