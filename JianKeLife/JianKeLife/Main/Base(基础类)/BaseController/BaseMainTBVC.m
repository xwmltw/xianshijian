//
//  BaseMainTBVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/5.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "BaseMainTBVC.h"
#import "BaseMainNC.h"

@interface BaseMainTBVC ()

@end

@implementation BaseMainTBVC

- (void)viewDidLoad {
    [super viewDidLoad];
     [self addChildViewControllers];
}

#pragma mark - 自定义tabbar
- (void)addChildViewControllers
{
    
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
    Vc.title = title;
    [self addChildViewController:NA_VC];
}

@end
