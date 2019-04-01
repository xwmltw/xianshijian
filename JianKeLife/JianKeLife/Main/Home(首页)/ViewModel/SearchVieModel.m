//
//  SearchVieModel.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/23.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "SearchVieModel.h"

@interface SearchVieModel()

@end

@implementation SearchVieModel

- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}
- (void)requestData{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.keywords forKey:@"keywords"];
    [dic setObject:[self.pageQueryRedModel mj_keyValues] forKey:@"pageQueryReq"];
    WEAKSELF
    [XNetWork requestNetWorkWithUrl:Xproduct_search andModel:dic andSuccessBlock:^(ResponseModel *model) {
        [weakSelf.productList addObjectsFromArray:model.data[@"dataRows"]];
        XBlockExec(weakSelf.responseSearchBlock,model);
    } andFailBlock:^(ResponseModel *model) {
        [weakSelf.footer endRefreshing];
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
- (NSMutableArray *)productList{
    if (!_productList) {
        _productList = [NSMutableArray array];
        
    }
    return _productList;
}
- (PageQueryRedModel *)pageQueryRedModel{
    if (!_pageQueryRedModel) {
        _pageQueryRedModel = [[PageQueryRedModel alloc]init];
    }
    return _pageQueryRedModel;
}
- (NSString *)keywords{
    if (!_keywords) {
        _keywords = @"";
    }
    return _keywords;
}
@end
