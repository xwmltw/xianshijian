//
//  MyOrderViewModel.h
//  JianKeLife
//
//  Created by yanqb on 2019/4/19.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyOrderViewModel : NSObject
@property (nonatomic ,assign) MyOrderTableViewType viewModelType;
@property (nonatomic, strong) PageQueryRedModel *pageQueryRedModel;
@property (nonatomic, strong) NSMutableArray *myOrderList;
@property (nonatomic, copy) XBlock myOrderListBlock;
@property (nonatomic ,strong) MJRefreshAutoNormalFooter *footer;
- (MJRefreshAutoNormalFooter *)creatMjRefresh;
- (void)footerRefresh;
- (void)requestData;
@end

NS_ASSUME_NONNULL_END
