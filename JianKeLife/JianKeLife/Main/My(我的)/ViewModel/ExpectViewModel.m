//
//  ExpectViewModel.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/27.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "ExpectViewModel.h"

@implementation ExpectViewModel
- (void)requestData{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@(self.viewModelType) forKey:@"profitType"];
    [dic setObject:[self.pageQueryRedModel mj_keyValues] forKey:@"pageQueryReq"];
    BLOCKSELF
    [XNetWork requestNetWorkWithUrl:Xestimate_list andModel:dic andSuccessBlock:^(ResponseModel *model) {
        blockSelf.expectModel = [ExpectModel mj_objectWithKeyValues:model.data];
        [blockSelf.expectList addObjectsFromArray:blockSelf.expectModel.dataRows];
        XBlockExec(blockSelf.expectListBlock,nil);
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
- (NSMutableArray *)expectList{
    if (!_expectList) {
        _expectList = [NSMutableArray array];
    }
    return _expectList;
}
- (ExpectModel *)expectModel{
    if (!_expectModel) {
        _expectModel = [[ExpectModel alloc]init];
    }
    return _expectModel;
}
- (PageQueryRedModel *)pageQueryRedModel{
    if (!_pageQueryRedModel) {
        _pageQueryRedModel = [[PageQueryRedModel alloc]init];
    }
    return _pageQueryRedModel;
}
@end
