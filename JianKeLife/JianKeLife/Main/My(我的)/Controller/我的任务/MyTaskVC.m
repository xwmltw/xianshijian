//
//  MyTaskVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/4/20.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "MyTaskVC.h"
#import "MytasktableViewVC.h"
#import "TaskReturnVC.h"
#import "TaskDetailVC.h"
#import "TaskResultVC.h"
#import "JobDetailVC.h"
@interface MyTaskVC ()<WMPageControllerDataSource>
@property (nonatomic, strong) NSArray *titleData;
@end

@implementation MyTaskVC
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
    self.viewControllerClasses = [NSArray arrayWithObjects:[MytasktableViewVC class], [MytasktableViewVC class],[MytasktableViewVC class],[MytasktableViewVC class], nil];
    self.titleSizeNormal = AdaptationWidth(16);
    self.titleSizeSelected = AdaptationWidth(16);
    self.menuViewStyle = WMMenuViewStyleLine;
    self.menuItemWidth = [UIScreen mainScreen].bounds.size.width / self.titleData.count;
    self.titleColorSelected = blueColor;
    self.titleColorNormal = LabelMainColor;
    self.progressColor = blueColor;
    self.progressWidth = AdaptationWidth(36); // 这里可以设置不同的宽度
    self.progressHeight = 4;//下划线的高度，需要WMMenuViewStyleLine样式
    
    self.selectIndex = self.wmPageSelect;
    
    
    //这里注意，需要写在最后面，要不然上面的效果不会出现
    [super viewDidLoad];
    self.title = @"我的任务";
    
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
            
            MytasktableViewVC   *vcClass = [[MytasktableViewVC alloc] init];
            vcClass.taskViewModel.taskType = MyTaskTableViewTypeAll;
            vcClass.taskStayBtnBlcok = [self taskResultBlcok];
            vcClass.taskStayCellselect = [self taskOverCellBlock];
            return vcClass;
        }
            
            break;
        case 1:{
            
            MytasktableViewVC *vcClass = [MytasktableViewVC new];
            vcClass.taskViewModel.taskType = MyTaskTableViewTypeStay;
            vcClass.taskStayBtnBlcok = [self taskBtnBlcok];
            vcClass.taskStayCellselect = [self taskOverCellBlock];
            return vcClass;
            
        }
            break;
        case 2:{
            
            MytasktableViewVC *vcClass = [MytasktableViewVC new];
            vcClass.taskViewModel.taskType = MyTaskTableViewTypeIng;
            vcClass.taskStayBtnBlcok = [self taskBtnBlcok];
            vcClass.taskStayCellselect = [self taskOverCellBlock];
            return vcClass;
            
        }
            break;
        case 3:{
            MytasktableViewVC *vcClass = [MytasktableViewVC new];
            vcClass.taskViewModel.taskType = MyTaskTableViewTypeOver;
            vcClass.taskStayBtnBlcok = [self taskResultBlcok];
            vcClass.taskStayCellselect = [self taskOverCellBlock];
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

#pragma mark -点击回调
-(XDoubleBlock)taskBtnBlcok{
    BLOCKSELF
    XDoubleBlock block = ^(UIButton * btn,NSDictionary *dic){
        switch (btn.tag) {
            case 202:
            {
                TaskReturnVC *vc = [[TaskReturnVC alloc]init];
                vc.productApplyId = dic[@"productApplyId"];
                vc.productSubmitType = dic[@"productSubmitType"];
                vc.hidesBottomBarWhenPushed = YES;
                [blockSelf.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 203:
            {
                TaskDetailVC *vc = [[TaskDetailVC alloc]init];
                vc.model = [TaskModel mj_objectWithKeyValues:dic];
                vc.hidesBottomBarWhenPushed = YES;
                [blockSelf.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            default:
                break;
        }
        
    };
    
    return block;
}
//结果
-(XDoubleBlock)taskResultBlcok{
    BLOCKSELF
    XDoubleBlock block = ^(UIButton * btn,id result){
        TaskResultVC*vc = [[TaskResultVC alloc]init];
        vc.resultModel = [TaskModel mj_objectWithKeyValues:result];
        vc.hidesBottomBarWhenPushed = YES;
        [blockSelf.navigationController pushViewController:vc animated:YES];
    };
    return block;
}
//任务详情
- (XBlock)taskOverCellBlock{
    WEAKSELF
    XBlock block = ^(NSString *proid){
        JobDetailVC *vc = [[JobDetailVC alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.productNo  = proid;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    return block;
}


#pragma mark 标题数组
- (NSArray *)titleData {
    if (!_titleData) {
        _titleData = @[@"全部", @"待返佣", @"进行中",@"已完成"];
    }
    return _titleData;
}
@end
