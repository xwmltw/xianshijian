//
//  JobDetailTableView.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/20.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobDetailViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface JobDetailTableView : UITableView
@property (nonatomic ,copy) XIntegerBlock jobDetailCellBlock;
@property (nonatomic ,strong) JobDetailViewModel *jobDetailViewModel;
@end

NS_ASSUME_NONNULL_END
