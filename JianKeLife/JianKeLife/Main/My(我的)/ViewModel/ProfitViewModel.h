//
//  ProfitViewModel.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/26.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProfitModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProfitViewModel : NSObject
@property (nonatomic, copy) NSNumber *tradeType;
@property (nonatomic, strong) NSMutableArray *profitList;
@property (nonatomic, strong) PageQueryRedModel *pageQueryRedModel;
@property (nonatomic, copy) XBlock profitListBlock;
@property (nonatomic ,strong) ProfitModel *profitModel;
@property (nonatomic ,strong) MJRefreshAutoNormalFooter *footer;
- (MJRefreshAutoNormalFooter *)creatMjRefresh;
- (void)footerRefresh;
- (void)requestProfitData;
@end

NS_ASSUME_NONNULL_END
