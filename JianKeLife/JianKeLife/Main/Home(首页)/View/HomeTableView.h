//
//  HomeTableView.h
//  JianKeLife
//
//  Created by yanqb on 2019/5/20.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "BaseTableView.h"
#import "HomeViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeTableView : BaseTableView

@property (nonatomic ,strong) HomeViewModel *homeViewModel;
@end

NS_ASSUME_NONNULL_END
