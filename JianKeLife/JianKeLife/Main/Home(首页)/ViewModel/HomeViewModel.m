//
//  HomeViewModel.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/20.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "HomeViewModel.h"

@implementation HomeViewModel

- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}
- (void)requestData{
    BLOCKSELF
    [XNetWork requestNetWorkWithUrl:Xproduct_list andModel:@{@"pageQueryReq":[self.pageQueryRedModel mj_keyValues],@"listType":self.listType} andSuccessBlock:^(ResponseModel *model) {
        [blockSelf.productList addObjectsFromArray:model.data[@"dataRows"]];
        XBlockExec(blockSelf.responseBlock,model);
    } andFailBlock:^(ResponseModel *model) {
        
    }];
}
- (void)requestSpecialData:(NSInteger)index{
//    NSNumber *isNeedLogin = self.clientGlobalInfo.specialEntryList[index][@"isNeedLogin"];
//    if (isNeedLogin.integerValue == 1) {
//        
//    }
    NSNumber *specialEntryType = self.clientGlobalInfo.specialEntryList[index][@"specialEntryType"];
    NSString *specialId = self.clientGlobalInfo.specialEntryList[index][@"specialEntryId"];
    [XNetWork requestNetWorkWithUrl:Xclick_log andModel:@{@"specialEntryId":specialId} andSuccessBlock:^(ResponseModel *model) {
        
    } andFailBlock:^(ResponseModel *model) {
        
    }];
    switch (specialEntryType.integerValue) {
        case 1:
        {
            XBlockExec(self.responseHotWebBlock,self.clientGlobalInfo.specialEntryList[index][@"specialEntryUrl"]);
        }
            break;
        case 2:
        {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:self.clientGlobalInfo.specialEntryList[index][@"specialEntryUrl"]]];
        }
            break;
        case 3:
        {
            XBlockExec(self.responseHotBlock,specialId,@(index));
//            BLOCKSELF
//            [XNetWork requestNetWorkWithUrl:Xquery_product_list andModel:@{@"pageQueryReq":[self.pageQueryRedModel mj_keyValues],@"specialEntryId":specialId} andSuccessBlock:^(ResponseModel *model) {
////                [blockSelf.productList addObjectsFromArray:model.data[@"dataRows"]];
//                XBlockExec(blockSelf.responseHotBlock,model.data[@"dataRows"],@(index));
//
//            } andFailBlock:^(ResponseModel *model) {
//
//            }];
        }
            break;
            
        default:
            break;
    }
    
}
- (void)requestBannerData:(NSInteger)index{
    NSNumber *adType = self.clientGlobalInfo.bannerAdList[index][@"adType"];
    NSString *adId = self.clientGlobalInfo.bannerAdList[index][@"adId"];
    NSString *adDetailUrl = XNULL_TO_NIL(self.clientGlobalInfo.bannerAdList[index][@"adDetailUrl"]);
    [XNetWork requestNetWorkWithUrl:Xadvertise_access_log andModel:@{@"adId":adId} andSuccessBlock:^(ResponseModel *model) {
        
    } andFailBlock:^(ResponseModel *model) {
        
    }];
    
    switch (adType.integerValue) {
            case 1:
        {
            XBlockExec(self.responseBannerWebBlock,adDetailUrl);
        }
            break;
            case 2:
        {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:adDetailUrl]];
        }
            break;
          
            
        default:
            break;
    }
    
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

- (ClientGlobalInfo *)clientGlobalInfo{
    if (!_clientGlobalInfo) {
        _clientGlobalInfo = [ClientGlobalInfo getClientGlobalInfoModel];
    }
    return _clientGlobalInfo;
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
@end
