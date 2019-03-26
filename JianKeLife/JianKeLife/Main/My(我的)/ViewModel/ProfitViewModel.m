//
//  ProfitViewModel.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/26.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "ProfitViewModel.h"

@implementation ProfitViewModel
- (void)requestProfitData{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.tradeType forKey:@"tradeType"];
    [dic setObject:[self.pageQueryRedModel mj_keyValues] forKey:@"pageQueryReq"];
    BLOCKSELF
    [XNetWork requestNetWorkWithUrl:Xquery_flow_list andModel:dic andSuccessBlock:^(ResponseModel *model) {
        blockSelf.profitModel = [ProfitModel mj_objectWithKeyValues:model.data];
        [blockSelf.profitList addObjectsFromArray:blockSelf.profitModel.dataRows];
        XBlockExec(blockSelf.profitListBlock,blockSelf.profitModel);
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
    [self requestProfitData];
}
- (NSMutableArray *)profitList{
    if (!_profitList) {
        _profitList = [NSMutableArray array];
    }
    return _profitList;
}
- (PageQueryRedModel *)pageQueryRedModel{
    if (!_pageQueryRedModel) {
        _pageQueryRedModel = [[PageQueryRedModel alloc]init];
    }
    return _pageQueryRedModel;
}
- (ProfitModel *)profitModel{
    if (!_profitModel) {
        _profitModel = [[ProfitModel alloc]init];
    }
    return _profitModel;
}
@end
