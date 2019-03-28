//
//  MyPersonTableView.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/19.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectionViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyPersonTableView : UITableView
@property (nonatomic ,strong) ConnectionViewModel *connectionViewModel;
@property (nonatomic ,copy) XBlock connectionCellSelectBlock;
@end

NS_ASSUME_NONNULL_END
