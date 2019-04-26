//
//  BaseMainTBVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/5.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "BaseMainTBVC.h"
#import "BaseMainNC.h"
#import "HomeVC.h"
#import "ConnectionsVC.h"
#import "TaskVC.h"
#import "MyVC.h"
#import "HiBuyVC.h"


@interface BaseMainTBVC ()

@end

@implementation BaseMainTBVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [UITabBar appearance].translucent = NO;
    
    [self addChildViewControllers];
}

#pragma mark - 自定义tabbar
- (void)addChildViewControllers
{
    HomeVC *homeVC = [[HomeVC alloc]init];
    [self setChildViewController:homeVC Image:@"icon_home_unselect" selectedImage:@"icon_home_select" title:@"首页"];
    
    
    HiBuyVC *taskVC = [[HiBuyVC alloc]init];
    [self setChildViewController:taskVC Image:@"icon_task_unselect" selectedImage:@"icon_task_select" title:@"嗨购"];
    
    ConnectionsVC *connectionsVC = [[ConnectionsVC alloc]init];
    [self setChildViewController:connectionsVC Image:@"icon_relationship_unselect" selectedImage:@"icon_relationship_select" title:@"收益"];

    MyVC *myVC = [[MyVC alloc]init];
    [self setChildViewController:myVC Image:@"icon_me_unselect" selectedImage:@"icon_me_select" title:@"我的"];
}
#pragma mark - 初始化设置ChildViewControllers
/**
 *
 *  设置单个tabBarButton
 *
 *  @param Vc            每一个按钮对应的控制器
 *  @param image         每一个按钮对应的普通状态下图片
 *  @param selectedImage 每一个按钮对应的选中状态下的图片
 *  @param title         每一个按钮对应的标题
 */
- (void)setChildViewController:(UIViewController *)Vc Image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    BaseMainNC *NA_VC = [[BaseMainNC alloc] initWithRootViewController:Vc];
    UIImage *myImage = [UIImage imageNamed:image];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    Vc.tabBarItem.image = myImage;
    UIImage *mySelectedImage = [UIImage imageNamed:selectedImage];
    mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    Vc.tabBarItem.selectedImage = mySelectedImage;
    [Vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:LabelMainColor,NSFontAttributeName:[UIFont systemFontOfSize:AdaptationWidth(10)]} forState:UIControlStateNormal];
    [Vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:blueColor,NSFontAttributeName:[UIFont systemFontOfSize:AdaptationWidth(10)]} forState:UIControlStateSelected];
    Vc.tabBarItem.title = title;
    [self addChildViewController:NA_VC];
}
+ (void)initialize
{
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = AppMainColor;
    dictNormal[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    dictSelected[NSForegroundColorAttributeName] = AppMainColor;
    dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    [tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
    
}
@end
