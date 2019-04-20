//
//  MytasktableViewVC.h
//  JianKeLife
//
//  Created by yanqb on 2019/4/20.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MytasktableViewVC : UITableViewController
@property (nonatomic ,strong) TaskViewModel *taskViewModel;
@property (nonatomic ,copy) XDoubleBlock taskStayBtnBlcok;
@property (nonatomic ,copy) XBlock taskStayCellselect;
@end

NS_ASSUME_NONNULL_END
