//
//  TaskViewModel.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/28.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskModel.h"

typedef NS_ENUM(NSInteger ,TaskTableViewType) {
    TaskTableViewTypeStay = 1,
    TaskTableViewTypeIng,
    TaskTableViewTypeOver,
};

NS_ASSUME_NONNULL_BEGIN

@interface TaskViewModel : NSObject
@property (nonatomic ,assign) TaskTableViewType taskType;
@property (nonatomic ,strong) TaskModel *taskModel;
@property (nonatomic, strong) PageQueryRedModel *pageQueryRedModel;
@property (nonatomic, strong) NSMutableArray *taskList;
@property (nonatomic, copy) XBlock taskListBlock;
@property (nonatomic ,strong) MJRefreshAutoNormalFooter *footer;
@property (nonatomic ,strong) MJRefreshStateHeader *header;
- (MJRefreshAutoNormalFooter *)creatMjRefresh;
- (MJRefreshStateHeader *)creatMjRefreshHeader;
- (void)headerRefresh;
- (void)footerRefresh;
- (void)requestTaskData;
-  (void)requestTaskCancelData:(NSString *)productNo;//放弃产品
@end

NS_ASSUME_NONNULL_END
