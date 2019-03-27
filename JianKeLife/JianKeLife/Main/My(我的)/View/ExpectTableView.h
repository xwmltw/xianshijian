//
//  ExpectTableView.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/27.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpectViewModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface ExpectTableView : UITableView
@property (nonatomic ,strong) ExpectViewModel *expectViewModel;
@end

NS_ASSUME_NONNULL_END
