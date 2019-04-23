//
//  HiBuyTableViewVC.h
//  JianKeLife
//
//  Created by yanqb on 2019/4/22.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseMainVC.h"
#import "HiBuyViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HiBuyTableViewVC : BaseMainVC
@property (nonatomic ,assign) BOOL isFirstType;
@property (nonatomic ,strong) HiBuyViewModel *hiBuyViewModel;

@end

NS_ASSUME_NONNULL_END
