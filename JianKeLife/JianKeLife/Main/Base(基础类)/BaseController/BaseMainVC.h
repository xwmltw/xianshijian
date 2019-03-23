//
//  BaseMainVC.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/5.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface BaseMainVC : UIViewController
@property (nonatomic ,strong) ClientGlobalInfo *clientGlobalInfo;
/**
 创建返回按钮
 */
-(void)setBackNavigationBarItem;
/**
 导航栏按钮的点击事件
 
 @param button 被点击的导航栏按钮 tag：9999 表示返回按钮
 */
-(void)BarbuttonClick:(UIButton *)button;
/**
 是否 登录
 */
- (void)getBlackLogin:(UIViewController *)controller;
- (void)dealloc;
@end

NS_ASSUME_NONNULL_END
