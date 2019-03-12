//
//  BaseMainVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/5.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "BaseMainVC.h"
#import "XControllerViewHelper.h"
@interface BaseMainVC ()

@end

@implementation BaseMainVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    // 解决多级页面返回到第二页无法返回的问题
#ifdef DEBUG
    UIViewController *viewCtrl = [XControllerViewHelper getTopViewController];
    NSLog(@"栈顶控制器为%@\n当前显示控制器为%@", [viewCtrl class], [self class]);
#endif
    NSString *title = self.title.length ? self.title : NSStringFromClass([self class]);
//    [TalkingData trackPageBegin:title];
}
/**
 *  点击屏幕空白区域，放弃桌面编辑状态
 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //打开手势返回
    if (self.navigationController != nil && self.navigationController.viewControllers.count > 1) {
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
        //        self.navigationItem.rightBarButtonItem =self.rBarButtonItem;
//        self.navigationController.navigationBar.backgroundColor =ThemeColor;
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],
                                                                          NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:17]}];
    }
}
/**
 创建返回按钮
 */
-(void)setBackNavigationBarItem{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 64, 44)];
    view.userInteractionEnabled = YES;
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn_back"]];
    imageV.frame = CGRectMake(0, 8, 28, 28);
    imageV.userInteractionEnabled = YES;
    [view addSubview:imageV];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 64, 44);
    button.tag = 9999;
    [button addTarget:self action:@selector(BarbuttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:view];
    self.navigationItem.leftBarButtonItem = item;
    UIView *ringhtV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 64, 44)];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:ringhtV];
    self.navigationItem.rightBarButtonItem = rightItem;
}
/**
 导航栏按钮的点击事件
 
 @param button 被点击的导航栏按钮 tag：9999 表示返回按钮
 */
-(void)BarbuttonClick:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
    //    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)dealloc{
    [XNotificationCenter removeObserver:self];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
