//
//  ExtendTableView.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/19.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExtendTableView : UITableView
@property (nonatomic ,copy) XIntegerBlock extendCellSelectBlcok;
@property (nonatomic ,copy) XBlock extendBtnSelectBlcok;
@property (nonatomic ,copy) NSNumber *firstCut;
@end

NS_ASSUME_NONNULL_END
