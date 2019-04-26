//
//  HiBuyViewModel.h
//  JianKeLife
//
//  Created by yanqb on 2019/4/22.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HiBuyProductQueryModel.h"
#import "HiBuyProductModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HiBuyViewModel : NSObject
@property (nonatomic, strong) NSMutableArray *hiBuyTypeList;
@property (nonatomic, copy) XBlock hiBuyTypeBlock;
@property (nonatomic, copy) XBlock hiBuyQuerBlock;
@property (nonatomic ,strong) HiBuyProductQueryModel *hiBuyProductQueryModel;
@property (nonatomic ,strong) HiBuyProductModel *hiBuyProductModel;
@property (nonatomic, strong) PageQueryRedModel *pageQueryRedModel;
@property (nonatomic ,strong) MJRefreshAutoNormalFooter *footer;
- (MJRefreshAutoNormalFooter *)creatMjRefresh;
- (void)footerRefresh;
- (void)requestData;
- (void)requestTypeDate;
@end

NS_ASSUME_NONNULL_END
