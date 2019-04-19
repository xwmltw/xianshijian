//
//  MyOrderViewModel.m
//  JianKeLife
//
//  Created by yanqb on 2019/4/19.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "MyOrderViewModel.h"

@implementation MyOrderViewModel
- (void)requestData{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@(self.viewModelType) forKey:@"tkStatus"];
    [dic setObject:[self.pageQueryRedModel mj_keyValues] forKey:@"pageQueryReq"];
    WEAKSELF
    [XNetWork requestNetWorkWithUrl:Xtb_order_list andModel:dic andSuccessBlock:^(ResponseModel *model) {
        [weakSelf.myOrderList addObjectsFromArray:model.data[@"PageRstInf"][@"dataRows"]];
        XBlockExec(weakSelf.myOrderListBlock ,nil);
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
    [self requestData];
}
- (NSMutableArray *)myOrderList{
    if (!_myOrderList) {
        _myOrderList = [NSMutableArray array];
    }
    return _myOrderList;
}

- (PageQueryRedModel *)pageQueryRedModel{
    if (!_pageQueryRedModel) {
        _pageQueryRedModel = [[PageQueryRedModel alloc]init];
    }
    return _pageQueryRedModel;
}
@end
