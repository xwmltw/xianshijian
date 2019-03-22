//
//  BaseTableView.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/21.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableView : UITableView
/**
 tableView的上拉刷新事件
 */
-(void)headerRefres;

/**
 tableView的下拉加载事件
 */
-(void)footerRefres;
@end

NS_ASSUME_NONNULL_END
