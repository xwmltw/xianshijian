//
//  TaskVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/18.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "TaskVC.h"
#import "TaskStayTableView.h"
#import "TaskIngTableView.h"
#import "TaskOverTableView.h"
#import "TaskDetailVC.h"
#import "TaskResultVC.h"
#import "TaskReturnVC.h"
#import "JobDetailVC.h"

@interface TaskVC ()
@property (nonatomic ,strong) UISegmentedControl *segmentedControl;
@property (nonatomic ,strong) TaskStayTableView *stayTableView;
@property (nonatomic ,strong) TaskIngTableView *ingTableView;
@property (nonatomic ,strong) TaskOverTableView *overTableView;

@end

@implementation TaskVC
- (void)setBackNavigationBarItem{};
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (![UserInfo sharedInstance].isSignIn){
 

    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = self.segmentedControl;
}

- (void)segmentedControlClick:(UISegmentedControl *)sender{
    switch (sender.selectedSegmentIndex) {
        case 0:
        {
            self.stayTableView.hidden = NO;
//            sel.stayTableView
            self.ingTableView.hidden = YES;
            self.overTableView.hidden = YES;
        }
            break;
        case 1:
        {
            self.stayTableView.hidden = YES;
            self.ingTableView.hidden = NO;
            self.overTableView.hidden = YES;
        }
            break;
        case 2:
        {
            self.stayTableView.hidden = YES;
            self.ingTableView.hidden = YES;
            self.overTableView.hidden = NO;
        }
            break;
        default:
            break;
    }
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
-(XDoubleBlock)taskResultBlcok{
    BLOCKSELF
    XDoubleBlock block = ^(UIButton * btn,id result){
        TaskResultVC*vc = [[TaskResultVC alloc]init];
        vc.resultModel = result;
        vc.hidesBottomBarWhenPushed = YES;
        [blockSelf.navigationController pushViewController:vc animated:YES];
    };
    return block;
}
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
#pragma mark -懒加载
- (TaskStayTableView *)stayTableView{
    if (!_stayTableView) {
        _stayTableView = [[TaskStayTableView alloc]init];
        _stayTableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-49);
        _stayTableView.taskStayBtnBlcok = [self taskBtnBlcok];
        _stayTableView.taskStayCellselect = [self taskOverCellBlock];
        [self.view addSubview:_stayTableView];

    }
    return _stayTableView;
}
- (TaskIngTableView *)ingTableView{
    if (!_ingTableView) {
        _ingTableView = [[TaskIngTableView alloc]init];
        _ingTableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-49);
        _ingTableView.taskIngBtnBlcok = [self taskBtnBlcok];
        _ingTableView.taskIngCellselect = [self taskOverCellBlock];
        [self.view addSubview:_ingTableView];
    }
    return _ingTableView;
}
- (TaskOverTableView *)overTableView{
    if (!_overTableView) {
        _overTableView = [[TaskOverTableView alloc]init];
        _overTableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-49);
        _overTableView.taskOverBtnBlcok = [self taskResultBlcok];
        _overTableView.taskOverCellselect = [self taskOverCellBlock];
        [self.view addSubview:_overTableView];
       
    }
    return _overTableView;
}
- (UISegmentedControl *)segmentedControl{
    if (!_segmentedControl) {
        _segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"待返佣",@"进行中",@"已完结"]];
        _segmentedControl.tintColor = [UIColor clearColor];
        [_segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:LabelMainColor,NSFontAttributeName:[UIFont boldSystemFontOfSize:AdaptationWidth(16)]}forState:UIControlStateNormal];
        [_segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:blueColor,NSFontAttributeName:[UIFont boldSystemFontOfSize:AdaptationWidth(16)]}forState:UIControlStateSelected];
        _segmentedControl.frame = CGRectMake(0, 0, AdaptationWidth(300), 30);
        _segmentedControl.selectedSegmentIndex = 0;
        [_segmentedControl addTarget:self action:@selector(segmentedControlClick:) forControlEvents:UIControlEventValueChanged];
        
        self.stayTableView.hidden = NO;
    }
    return _segmentedControl;
}



@end
