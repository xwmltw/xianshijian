//
//  HighShareView.h
//  JianKeLife
//
//  Created by yanqb on 2019/5/22.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "BaseTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HighShareView : BaseTableView
@property (nonatomic ,strong) NSMutableArray *highListAry;
@property (nonatomic ,strong) NSString *highListTitle;
- (void)creatInitTableView;
@end

NS_ASSUME_NONNULL_END
