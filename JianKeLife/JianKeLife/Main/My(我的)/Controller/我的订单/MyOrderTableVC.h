//
//  MyOrderTableVC.h
//  JianKeLife
//
//  Created by yanqb on 2019/4/18.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrderViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyOrderTableVC : UITableViewController
@property (nonatomic ,strong) MyOrderViewModel *myOrderViewModel;
@end

NS_ASSUME_NONNULL_END
