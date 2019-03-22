//
//  MyTableView.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/18.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyTableView : UITableView
@property (nonatomic ,strong) MyViewModel *viewModel;
@property (nonatomic ,copy) XIntegerBlock cellSelectBlock;
@property (nonatomic ,copy) XBlock btnBlock;
@end

NS_ASSUME_NONNULL_END
