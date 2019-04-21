//
//  TaskViewModel.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/28.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "TaskViewModel.h"

@implementation TaskViewModel

- (void)requestTaskData{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (self.taskType != MyTaskTableViewTypeAll) {
        [dic setObject:@(self.taskType) forKey:@"listType"];
    }
    [dic setObject:[self.pageQueryRedModel mj_keyValues] forKey:@"pageQueryReq"];
    BLOCKSELF
    [XNetWork requestNetWorkWithUrl:Xproduct_apply_task andModel:dic andSuccessBlock:^(ResponseModel *model) {
        [blockSelf.taskList addObjectsFromArray:model.data[@"dataRows"]];
        XBlockExec(self.taskListBlock,nil);
    } andFailBlock:^(ResponseModel *model) {
        
    }];
}

-  (void)requestTaskCancelData:(NSNumber *)productApplyId{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:productApplyId forKey:@"productApplyId"];
    
    BLOCKSELF
    [XNetWork requestNetWorkWithUrl:Xproduct_apply_abandon andModel:dic andSuccessBlock:^(ResponseModel *model) {
        [ProgressHUD showProgressHUDInView:nil withText:@"放弃成功" afterDelay:1];
        [blockSelf headerRefresh];
    } andFailBlock:^(ResponseModel *model) {
        
    }];
}
- (MJRefreshStateHeader *)creatMjRefreshHeader{
    self.header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    [self.header setTitle:@"" forState:MJRefreshStateIdle];
    [self.header setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    self.header.stateLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:AdaptationWidth(12)];
    self.header.stateLabel.textColor = XColorWithRBBA(34, 58, 80, 0.32);
    self.header.lastUpdatedTimeLabel.hidden = YES;
    self.header.stateLabel.hidden = YES;
    return  self.header;
}

- (MJRefreshAutoNormalFooter *)creatMjRefresh{
    
    self.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    [self.footer setTitle:@"" forState:MJRefreshStateIdle];
    [self.footer setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    self.footer.stateLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:AdaptationWidth(12)];
    self.footer.stateLabel.textColor = XColorWithRBBA(34, 58, 80, 0.32);
    
    return self.footer;
}
- (void)footerRefresh{
    self.pageQueryRedModel.page = @(self.pageQueryRedModel.page.integerValue +1);
    [self requestTaskData];
}
- (void)headerRefresh{
    [self.taskList removeAllObjects];
    self.pageQueryRedModel.page = @(1);
    [self requestTaskData];
}
- (NSMutableArray *)taskList{
    if (!_taskList) {
        _taskList = [NSMutableArray array];
    }
    return _taskList;
}

- (PageQueryRedModel *)pageQueryRedModel{
    if (!_pageQueryRedModel) {
        _pageQueryRedModel = [[PageQueryRedModel alloc]init];
    }
    return _pageQueryRedModel;
}
- (TaskModel *)taskModel{
    if (!_taskModel) {
        _taskModel = [[TaskModel alloc]init];
    }
    return _taskModel;
}
@end
