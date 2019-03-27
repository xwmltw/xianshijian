//
//  ExpectViewModel.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/27.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExpectModel.h"

typedef NS_ENUM(NSInteger ,ExpectTableViewType) {
    ExpectTableViewTypeTesk = 1,
    ExpectTableViewTypeShare,
    ExpectTableViewTypeConnection,
};
NS_ASSUME_NONNULL_BEGIN

@interface ExpectViewModel : NSObject
@property (nonatomic ,assign) ExpectTableViewType viewModelType;
@property (nonatomic, strong) PageQueryRedModel *pageQueryRedModel;
@property (nonatomic, strong) NSMutableArray *expectList;
@property (nonatomic, copy) XBlock expectListBlock;
@property (nonatomic, strong) ExpectModel *expectModel;
@property (nonatomic ,strong) MJRefreshAutoNormalFooter *footer;
- (MJRefreshAutoNormalFooter *)creatMjRefresh;
- (void)footerRefresh;
- (void)requestData;
@end

NS_ASSUME_NONNULL_END
