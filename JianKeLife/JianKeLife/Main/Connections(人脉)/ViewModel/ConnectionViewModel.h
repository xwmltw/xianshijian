//
//  ConnectionViewModel.h
//  JianKeLife
//
//  Created by 肖伟民 on 2019/3/28.
//  Copyright © 2019 xwm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConnectionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ConnectionViewModel : NSObject
@property (nonatomic ,strong) ConnectionModel *connectionModel;
@property (nonatomic ,copy) XBlock connectionRequestBlcok;
@property (nonatomic ,copy) XBlock firstRequestBlcok;
@property (nonatomic, strong) NSMutableArray *connectionList;
@property (nonatomic, strong) NSMutableArray *memberList;
@property (nonatomic ,copy) XBlock memberRequestBlcok;
@property (nonatomic, strong) PageQueryRedModel *pageQueryRedModel;
@property (nonatomic ,strong) MJRefreshAutoNormalFooter *footer;
- (MJRefreshAutoNormalFooter *)creatMjRefresh;
- (void)footerRefresh;
- (void)requestData;
- (void)requestVIPData;
- (void)requestFirstData;
@end

NS_ASSUME_NONNULL_END
