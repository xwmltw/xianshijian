//
//  MyConnectionVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/6/5.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "MyConnectionVC.h"
#import "ConnectionViewModel.h"
#import "MyPersonTableViewCell.h"
#import "MySecondConnectionVC.h"
@interface MyConnectionVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) ConnectionViewModel *connectionViewModel;

@end
@implementation MyConnectionVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
     [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, ScreenWidth, ScreenHeight+20) style:UITableViewStyleGrouped];
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedRowHeight = AdaptationWidth(68);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.tableView.mj_footer = [self.connectionViewModel creatMjRefresh];

    [self.connectionViewModel requestData];
    WEAKSELF
    [self.connectionViewModel setConnectionRequestBlcok:^(id result) {
        [weakSelf.connectionViewModel requestFirstData];
        
    }];
    [self.connectionViewModel setFirstRequestBlcok:^(id result) {
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf.tableView reloadData];
    }];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = XColorWithRGB(129, 147, 180);
    
    UILabel *loginLab1 = [[UILabel alloc]init];
    [loginLab1 setText:@"我的创业团"];
    [loginLab1 setFont:[UIFont systemFontOfSize:AdaptationWidth(17)]];
    [loginLab1 setTextColor:[UIColor whiteColor]];
    [view addSubview:loginLab1];
    [loginLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view);
        make.top.mas_equalTo(view).offset(AdaptationWidth(40));
    }];
    
    UIButton *balckBtn = [[UIButton alloc]init];
    [balckBtn setImage:[UIImage imageNamed:@"icon_back-white"] forState:UIControlStateNormal];
    [balckBtn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:balckBtn];
    [balckBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view).offset(30);
        make.left.mas_equalTo(view).offset(AdaptationWidth(14));
        make.height.width.mas_equalTo(AdaptationWidth(40));
    }];
    
    
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    [bgView setCornerValue:AdaptationWidth(8)];
    [view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(loginLab1.mas_bottom).offset(AdaptationWidth(18));
        make.centerX.mas_equalTo(view);
        make.width.mas_equalTo(AdaptationWidth(347));
        make.height.mas_equalTo(AdaptationWidth(80));
    }];
    
    UILabel *newNum = [[UILabel alloc]init];
    [newNum setText:[NSString stringWithFormat:@"团队总数（%@人）",self.connectionViewModel.connectionModel.totalCount ? self.connectionViewModel.connectionModel.totalCount.description :@"0"]];
    [newNum setFont:[UIFont systemFontOfSize:AdaptationWidth(18)]];
    [newNum setTextColor:XColorWithRGB(95, 118, 159)];
    [bgView addSubview:newNum];
    [newNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgView).offset(AdaptationWidth(10));
        make.left.mas_equalTo(bgView).offset(AdaptationWidth(15));
        
    }];
    
    UILabel *straightNum = [[UILabel alloc]init];
    straightNum.textAlignment = NSTextAlignmentCenter;
    [straightNum setBorderWidth:1 andColor:XColorWithRGB(95, 118, 159)];
    [straightNum setCornerValue:4];
    [straightNum setText:[NSString stringWithFormat:@"直推人脉%@人",self.connectionViewModel.connectionModel.firstConnectionsCount ?self.connectionViewModel.connectionModel.firstConnectionsCount.description :@"0"]];
    [straightNum setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
    [straightNum setTextColor:XColorWithRGB(95, 118, 159)];
    [bgView addSubview:straightNum];
    [straightNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(bgView).offset(AdaptationWidth(-10));
        make.left.mas_equalTo(bgView).offset(AdaptationWidth(15));
        make.width.mas_equalTo(AdaptationWidth(100));
        make.height.mas_equalTo(AdaptationWidth(22));
    }];
    
    UILabel *commonNum = [[UILabel alloc]init];
    commonNum.textAlignment = NSTextAlignmentCenter;
    [commonNum setBorderWidth:1 andColor:XColorWithRGB(150, 150, 150)];
    [commonNum setCornerValue:4];
    [commonNum setText:[NSString stringWithFormat:@"普通人脉%@人",self.connectionViewModel.connectionModel.secondConnectionsCount?self.connectionViewModel.connectionModel.secondConnectionsCount.description:@"0"]];
    [commonNum setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
    [commonNum setTextColor:XColorWithRGB(150, 150, 150)];
    [bgView addSubview:commonNum];
    [commonNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(straightNum);
        make.left.mas_equalTo(straightNum.mas_right).offset(AdaptationWidth(10));
        make.width.mas_equalTo(AdaptationWidth(100));
        make.height.mas_equalTo(AdaptationWidth(22));
    }];
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, AdaptationWidth(195), ScreenWidth, AdaptationWidth(55))];
    footView.backgroundColor = [UIColor whiteColor];
    [footView viewCutRoundedOfRectCorner:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:AdaptationWidth(20)];
    [view addSubview:footView];
    
    UILabel *title = [[UILabel alloc]init];
    title.text = [NSString stringWithFormat:@"直推人脉（%@人）",self.connectionViewModel.connectionModel.firstConnectionsCount?self.connectionViewModel.connectionModel.firstConnectionsCount.description : @"0"];
    [title setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
    [title setTextColor:LabelAssistantColor];
    [view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view).offset(AdaptationWidth(14));
        make.bottom.mas_equalTo(view).offset(AdaptationWidth(-10));
        
    }];
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AdaptationWidth(250);
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"icon_noData"];
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view);
        make.top.mas_equalTo(view).offset(120);
        
    }];
    UILabel *lab = [[UILabel alloc]init];
    [lab setText:@"暂无人脉信息"];
    [lab setFont:[UIFont systemFontOfSize:16]];
    [lab setTextColor:LabelMainColor];
    [view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view);
        make.top.mas_equalTo(imageView.mas_bottom).offset(34);
    }];
    return self.connectionViewModel.connectionList.count ?  nil :view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return self.connectionViewModel.connectionList.count ? 0 : ScreenHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.connectionViewModel.connectionList.count;
//    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptationWidth(63);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyPersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyPersonTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MyPersonTableViewCell" owner:self options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.connectionFirstModel = [ConnectionFirstModel mj_objectWithKeyValues:self.connectionViewModel.connectionList[indexPath.row]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MySecondConnectionVC *vc = [[MySecondConnectionVC alloc]init];
    vc.model = [ConnectionFirstModel mj_objectWithKeyValues:self.connectionViewModel.connectionList[indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];

}
- (void)btnOnClick:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}
- (ConnectionViewModel *)connectionViewModel{
    if (!_connectionViewModel) {
        _connectionViewModel = [[ConnectionViewModel alloc]init];
    }
    return _connectionViewModel;
}
@end
