//
//  ProfitVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/26.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "ProfitVC.h"
#import "ProfitTableView.h"
@interface ProfitVC ()
@property (nonatomic ,strong) ProfitTableView *profitTableView;
@end

@implementation ProfitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"到账总收益";
    self.profitTableView  = [[ProfitTableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    self.profitTableView.profitViewModel.tradeType = @1;
    [self.profitTableView.profitViewModel requestProfitData];
    self.view = self.profitTableView;
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
