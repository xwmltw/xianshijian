//
//  HiBuyViewModel.m
//  JianKeLife
//
//  Created by yanqb on 2019/4/22.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "HiBuyViewModel.h"

@implementation HiBuyViewModel

- (void)requestTypeDate{
    [self.hiBuyTypeList removeAllObjects];
    self.pageQueryRedModel.page = @(1);
    self.hiBuyProductQueryModel.pageQueryReq = self.pageQueryRedModel;
    WEAKSELF
    [XNetWork requestNetWorkWithUrl:Xtb_product_list andModel:[self.hiBuyProductQueryModel mj_keyValues] andSuccessBlock:^(ResponseModel *model) {
        
//        [weakSelf.hiBuyTypeList arrayByAddingObjectsFromArray:model.data[@"dataRows"]];
        [weakSelf.hiBuyTypeList addObjectsFromArray:model.data[@"dataRows"]];
        XBlockExec(weakSelf.hiBuyQuerBlock,nil);
    } andFailBlock:^(ResponseModel *model) {
        
    }];
}

- (void)requestData{

    self.hiBuyProductQueryModel.pageQueryReq = self.pageQueryRedModel;
    WEAKSELF
    [XNetWork requestNetWorkWithUrl:Xtb_product_list andModel:[self.hiBuyProductQueryModel mj_keyValues] andSuccessBlock:^(ResponseModel *model) {
        [weakSelf.hiBuyTypeList addObjectsFromArray:model.data[@"dataRows"]];
        XBlockExec(weakSelf.hiBuyTypeBlock,nil);
    } andFailBlock:^(ResponseModel *model) {
        
    }];
}
- (MJRefreshAutoNormalFooter *)creatMjRefresh{
    self.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    [self.footer setTitle:@"已经是最后一件咯~" forState:MJRefreshStateIdle];
    [self.footer setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    self.footer.stateLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:AdaptationWidth(12)];
    self.footer.stateLabel.textColor = XColorWithRBBA(34, 58, 80, 0.32);
    
    return self.footer;
}
- (void)footerRefresh{
    self.pageQueryRedModel.page = @(self.pageQueryRedModel.page.integerValue +1);
    [self requestData];
}

- (NSMutableArray *)hiBuyTypeList{
    if (!_hiBuyTypeList) {
        _hiBuyTypeList = [NSMutableArray array];
    }
    return _hiBuyTypeList;
}
- (PageQueryRedModel *)pageQueryRedModel{
    if (!_pageQueryRedModel) {
        _pageQueryRedModel = [[PageQueryRedModel alloc]init];
    }
    return _pageQueryRedModel;
}
- (HiBuyProductQueryModel *)hiBuyProductQueryModel{
    if (!_hiBuyProductQueryModel) {
        _hiBuyProductQueryModel = [[HiBuyProductQueryModel alloc]init];
    }
    return _hiBuyProductQueryModel;
}
- (HiBuyProductModel *)hiBuyProductModel{
    if (!_hiBuyProductModel) {
        _hiBuyProductModel = [[HiBuyProductModel alloc]init];
    }
    return _hiBuyProductModel;
}
@end
