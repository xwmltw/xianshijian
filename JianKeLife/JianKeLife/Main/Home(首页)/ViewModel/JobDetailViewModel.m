//
//  JobDetailViewModel.m
//  JianKeLife
//
//  Created by 肖伟民 on 2019/3/24.
//  Copyright © 2019 xwm. All rights reserved.
//

#import "JobDetailViewModel.h"

@implementation JobDetailViewModel
- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)requestDetialData{
    BLOCKSELF
    [XNetWork requestNetWorkWithUrl:Xproduct_detail andModel:@{@"productNo":self.productModel.productNo} andSuccessBlock:^(ResponseModel *model) {
        blockSelf.productModel = [ProductModel mj_objectWithKeyValues:model.data];
        XBlockExec(blockSelf.productDetailBlock,blockSelf.productModel);
        XBlockExec(blockSelf.productStateBlock,blockSelf.productModel);
    } andFailBlock:^(ResponseModel *model) {
        
    }];
}

- (ProductModel *)productModel{
    if (!_productModel) {
        _productModel = [[ProductModel alloc]init];
    }
    return _productModel;
}
@end
