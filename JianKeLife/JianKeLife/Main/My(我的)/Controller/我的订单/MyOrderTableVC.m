//
//  MyOrderTableVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/4/18.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "MyOrderTableVC.h"
#import "MyOrderTableViewCell.h"
#import "MyOrderInfoVC.h"
@interface MyOrderTableVC ()

@end

@implementation MyOrderTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = XColorWithRGB(248, 248, 248);
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView registerNib:[UINib nibWithNibName:@"MyOrderTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyOrderTableViewCell"];
    self.tableView.estimatedRowHeight = 44;
    [self.myOrderViewModel requestData];
    self.tableView.mj_footer = [self.myOrderViewModel creatMjRefresh];
    WEAKSELF
    [self.myOrderViewModel setMyOrderListBlock:^(id result) {
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf.tableView reloadData];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = XColorWithRBBA(249, 237, 205, 1);
    
    UIImageView *headerImage2 = [[UIImageView alloc]init];
    [headerImage2 setImage:[UIImage imageNamed:@"icon_myOrder_noti"]];
    [view addSubview:headerImage2];
    [headerImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view).offset(AdaptationWidth(10));
        make.centerY.mas_equalTo(view);
        make.width.height.mas_equalTo(AdaptationWidth(20));
    }];
    
    
    
    UILabel *loginLab = [[UILabel alloc]init];
    [loginLab setText:@"有订单相关的问题，点我告诉你～"];
    [loginLab setFont:[UIFont systemFontOfSize:AdaptationWidth(12)]];
    [loginLab setTextColor:XColorWithRGB(255, 162, 0)];
    [view addSubview:loginLab];
    [loginLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view);
        make.left.mas_equalTo(headerImage2.mas_right).offset(AdaptationWidth(4));
    }];
    
    UIButton *loginBtn = [[UIButton alloc]init];
//    loginBtn.tag = 401;
    [loginBtn addTarget:self action:@selector(btnOnClock:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(view);
    }];
    
    
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"icon_noData"];
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view);
        make.top.mas_equalTo(view).offset(50);
        
    }];
    UILabel *lab = [[UILabel alloc]init];
    [lab setText:@"暂无订单,去嗨购看看~"];
    [lab setFont:[UIFont systemFontOfSize:16]];
    [lab setTextColor:LabelMainColor];
    [view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view);
        make.top.mas_equalTo(imageView.mas_bottom).offset(34);
    }];
    
    
    return self.myOrderViewModel.myOrderList.count ? nil : view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return  self.myOrderViewModel.myOrderList.count ? 0 : ScreenHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AdaptationWidth(30);
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
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = [MyOrderModel mj_objectWithKeyValues:self.myOrderViewModel.myOrderList[indexPath.row]];

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)btnOnClock:(UIButton *)btn{
    MyOrderInfoVC *vc = [[MyOrderInfoVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (MyOrderViewModel *)myOrderViewModel{
    if (!_myOrderViewModel) {
        _myOrderViewModel = [[MyOrderViewModel alloc]init];
    }
    return _myOrderViewModel;
}
@end
