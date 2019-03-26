//
//  MyViewModel.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/18.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "MyViewModel.h"
#import "MyModel.h"
@implementation MyViewModel
- (void)requestUserInfo{
    BLOCKSELF
    [XNetWork requestNetWorkWithUrl:Xget_account_info andModel:nil andSuccessBlock:^(ResponseModel *model) {
        blockSelf.myModel = [MyModel mj_objectWithKeyValues:model.data];
        XBlockExec(blockSelf.requestMyInfoBlock,blockSelf.myModel)
    } andFailBlock:^(ResponseModel *model) {
        
    }];
}
- (MyModel *)myModel{
    if (!_myModel) {
        _myModel = [[MyModel alloc]init];
    }
    return _myModel;
}
@end
