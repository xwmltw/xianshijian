//
//  SearchVieModel.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/23.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchVieModel : NSObject
@property (nonatomic ,copy) NSString *keywords;
@property (nonatomic, strong) PageQueryRedModel *pageQueryRedModel;
@property (nonatomic, strong) NSMutableArray *productList;
@property (nonatomic ,copy) XBlock responseSearchBlock;
@property (nonatomic ,strong) MJRefreshAutoNormalFooter *footer;
- (MJRefreshAutoNormalFooter *)creatMjRefresh;
- (void)footerRefresh;
- (void)requestData;
@end

NS_ASSUME_NONNULL_END
