//
//  HomeViewModel.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/20.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface HomeViewModel : NSObject

@property (nonatomic ,strong) ClientGlobalInfo *clientGlobalInfo;
@property (nonatomic, strong) PageQueryRedModel *pageQueryRedModel;
@property (nonatomic, strong) NSMutableArray *productList;
@property (nonatomic ,copy) XBlock responseBlock;
@property (nonatomic ,copy) XBlock responseHotBlock;
@property (nonatomic ,copy) XBlock responseHotWebBlock;
@property (nonatomic ,copy) XBlock responseBannerWebBlock;
@property (nonatomic ,strong) MJRefreshAutoNormalFooter *footer;
- (MJRefreshAutoNormalFooter *)creatMjRefresh;
- (void)footerRefresh;
- (void)requestSpecialData:(NSInteger)index;
- (void)requestBannerData:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
