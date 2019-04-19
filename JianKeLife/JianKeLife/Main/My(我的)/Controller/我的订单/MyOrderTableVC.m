//
//  MyOrderTableVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/4/18.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "MyOrderTableVC.h"
#import "MyOrderTableViewCell.h"

@interface MyOrderTableVC ()

@end

@implementation MyOrderTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = XColorWithRGB(248, 248, 248);
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView registerNib:[UINib nibWithNibName:@"MyOrderTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyOrderTableViewCell"];
    
    [self.myOrderViewModel requestData];
    self.tableView.mj_footer = [self.myOrderViewModel creatMjRefresh];
    WEAKSELF
    [self.myOrderViewModel setMyOrderListBlock:^(id result) {
        [weakSelf.tableView reloadData];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.myOrderViewModel.myOrderList.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyOrderTableViewCell"];
    if (!cell) {
        cell = [[MyOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyOrderTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (MyOrderViewModel *)myOrderViewModel{
    if (!_myOrderViewModel) {
        _myOrderViewModel = [[MyOrderViewModel alloc]init];
    }
    return _myOrderViewModel;
}
@end
