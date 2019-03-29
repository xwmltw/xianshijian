//
//  ConnectionViewModel.m
//  JianKeLife
//
//  Created by 肖伟民 on 2019/3/28.
//  Copyright © 2019 xwm. All rights reserved.
//

#import "ConnectionViewModel.h"

@implementation ConnectionViewModel
- (void)requestData{
    BLOCKSELF
    [XNetWork requestNetWorkWithUrl:Xget_connections_info andModel:nil andSuccessBlock:^(ResponseModel *model) {
        blockSelf.connectionModel = [ConnectionModel mj_objectWithKeyValues:model.data];
        XBlockExec(blockSelf.connectionRequestBlcok ,nil);
    } andFailBlock:^(ResponseModel *model) {
        
    }];
  
}
- (void)requestFirstData{
    BLOCKSELF
    [XNetWork requestNetWorkWithUrl:Xget_first_connections_info andModel:@{@"pageQueryReq":[self.pageQueryRedModel mj_keyValues]} andSuccessBlock:^(ResponseModel *model) {
        [blockSelf.connectionList addObjectsFromArray:model.data[@"dataRows"]];
        XBlockExec(blockSelf.connectionRequestBlcok ,model.data);
    } andFailBlock:^(ResponseModel *model) {
        
    }];
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
    [self requestFirstData];
}
- (ConnectionModel *)connectionModel{
    if (!_connectionModel) {
        _connectionModel = [[ConnectionModel alloc]init];
    }
    return _connectionModel;
}

- (NSMutableArray *)connectionList{
    if (!_connectionList) {
        _connectionList = [NSMutableArray array];
    }
    return _connectionList;
}
- (PageQueryRedModel *)pageQueryRedModel{
    if (!_pageQueryRedModel) {
        _pageQueryRedModel = [[PageQueryRedModel alloc]init];
    }
    return _pageQueryRedModel;
}
@end
