//
//  TaskStayTableView.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/19.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TaskStayTableView : UITableView
@property (nonatomic ,strong) TaskViewModel *taskViewModel;
@property (nonatomic ,copy) XDoubleBlock taskStayBtnBlcok;
@property (nonatomic ,copy) XBlock taskStayCellselect;
@end

NS_ASSUME_NONNULL_END
