//
//  MyorderVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/4/18.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "MyorderVC.h"
#import "WMPageController.h"
#import "MyOrderTableVC.h"

@interface MyorderVC ()<WMPageControllerDataSource>
@property (nonatomic, strong) NSArray *titleData;
//@property (nonatomic ,strong) MyOrderTableVC *myOrderTableVC1;

@end

@implementation MyorderVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
/**
 创建返回按钮
 */
-(void)setBackNavigationBarItem{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 64, 44)];
    view.userInteractionEnabled = YES;
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_back"]];
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
    
}
- (void)viewDidLoad {
    
    
    self.titles = self.titleData;
    self.viewControllerClasses = [NSArray arrayWithObjects:[MyOrderTableVC class], [MyOrderTableVC class],[MyOrderTableVC class],[MyOrderTableVC class], nil];
    self.titleSizeNormal = AdaptationWidth(16);
    self.titleSizeSelected = AdaptationWidth(16);
    self.menuViewStyle = WMMenuViewStyleLine;
    self.menuItemWidth = [UIScreen mainScreen].bounds.size.width / self.titleData.count;
    self.titleColorSelected = blueColor;
    self.titleColorNormal = LabelMainColor;
    self.progressColor = blueColor;
    self.progressWidth = AdaptationWidth(36); // 这里可以设置不同的宽度
    self.progressHeight = 4;//下划线的高度，需要WMMenuViewStyleLine样式
//这里注意，需要写在最后面，要不然上面的效果不会出现
    [super viewDidLoad];
    self.title = @"我的订单";
    
    [self setBackNavigationBarItem];
    
}

#pragma mark - Datasource & Delegate

#pragma mark 返回子页面的个数
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titleData.count;
}

#pragma mark 返回某个index对应的页面
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    
    switch (index) {
        case 0:{
            
            MyOrderTableVC   *vcClass = [[MyOrderTableVC alloc] init];
            vcClass.myOrderViewModel.viewModelType = MyOrderTableViewTypeAll;
            
            return vcClass;
        }
            
            break;
        case 1:{
            
            MyOrderTableVC *vcClass = [MyOrderTableVC new];
            vcClass.myOrderViewModel.viewModelType = MyOrderTableViewTypePay;
            return vcClass;
            
        }
            break;
        case 2:{
            
            MyOrderTableVC *vcClass = [MyOrderTableVC new];
            vcClass.myOrderViewModel.viewModelType = MyOrderTableViewTypeOver;
            return vcClass;
            
        }
            break;
        case 3:{
            MyOrderTableVC *vcClass = [MyOrderTableVC new];
            vcClass.myOrderViewModel.viewModelType = MyOrderTableViewTypefail;
            return vcClass;
        }
            break;
        default:
            
            break;
    }
    return nil;
    
}

#pragma mark 返回index对应的标题
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    return self.titleData[index];
}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView{
    return CGRectMake(0, AdaptationWidth(42), ScreenWidth, ScreenHeight-AdaptationWidth(42));
}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView{
    return CGRectMake(0, 0, ScreenWidth, AdaptationWidth(42));
}
#pragma mark 标题数组
- (NSArray *)titleData {
    if (!_titleData) {
        _titleData = @[@"全部", @"已付款", @"已结算",@"已失效"];
    }
    return _titleData;
}
@end
