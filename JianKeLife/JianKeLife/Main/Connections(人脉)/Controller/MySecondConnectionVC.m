//
//  MySecondConnectionVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/6/5.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "MySecondConnectionVC.h"
#import "MyPersonTableViewCell.h"
#import "ConnectionViewModel.h"
@interface MySecondConnectionVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic, strong) PageQueryRedModel *pageQueryRedModel;
@property (nonatomic, strong) NSMutableArray *myPersonSecondList;

@end

@implementation MySecondConnectionVC
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
    [self.tableView registerNib:[UINib nibWithNibName:@"MyPersonTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyPersonTableViewCell2"];
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    [self getData];
    
}
- (void)getData{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.model.id forKey:@"firstConnectionsId"];
    [dic setObject:[self.pageQueryRedModel mj_keyValues] forKey:@"pageQueryReq"];
    WEAKSELF
    [XNetWork requestNetWorkWithUrl:Xget_second_connections_info andModel:dic andSuccessBlock:^(ResponseModel *model) {
        [weakSelf.myPersonSecondList addObjectsFromArray: model.data[@"dataRows"]];
        [weakSelf.tableView reloadData];
    } andFailBlock:^(ResponseModel *model) {
        
    }];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
 
    UIView *headView = [[UIView alloc]init];
    headView.backgroundColor = XColorWithRGB(129, 147, 180);
    [view addSubview:headView];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(view);
        make.height.mas_equalTo(AdaptationWidth(88));
    }];
    
    UILabel *loginLab1 = [[UILabel alloc]init];
    [loginLab1 setText:[NSString stringWithFormat:@"普通人脉(%@人)",self.model.firstConnectionsCount.description]];
    [loginLab1 setFont:[UIFont systemFontOfSize:AdaptationWidth(17)]];
    [loginLab1 setTextColor:[UIColor whiteColor]];
    [headView addSubview:loginLab1];
    [loginLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(headView);
        make.bottom.mas_equalTo(headView).offset(AdaptationWidth(-15));
    }];
    
    UIButton *balckBtn = [[UIButton alloc]init];
    [balckBtn setImage:[UIImage imageNamed:@"icon_back-white"] forState:UIControlStateNormal];
    [balckBtn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:balckBtn];
    [balckBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(headView).offset(AdaptationWidth(-8));
        make.left.mas_equalTo(headView).offset(AdaptationWidth(20));
        make.height.width.mas_equalTo(AdaptationWidth(40));
    }];
    
    UIImageView *headerImage = [[UIImageView alloc]init];
    [headerImage setCornerValue:AdaptationWidth(22)];
    [headerImage sd_setImageWithURL:[NSURL URLWithString:self.model.headLogo] placeholderImage:[UIImage imageNamed:@"icon_profit_head"]];
    //    [headerImage setImage:[UIImage imageNamed:@"icon_profit_head"]];
    [view addSubview:headerImage];
    [headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(headView);
        make.top.mas_equalTo(headView.mas_bottom).offset(AdaptationWidth(12));
        make.height.width.mas_equalTo(AdaptationWidth(44));
    }];
    
    UILabel *nameLab = [[UILabel alloc]init];
    [nameLab setText:self.model.telephone];
    [nameLab setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
    [nameLab setTextColor:LabelMainColor];
    [headView addSubview:nameLab];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(headerImage);
        make.top.mas_equalTo(headerImage.mas_bottom).offset(AdaptationWidth(6));
    }];
    
    UILabel *detail = [[UILabel alloc]init];
    detail.textAlignment = NSTextAlignmentCenter;
    [detail setText:@"为您邀请的普通人脉"];
    detail.backgroundColor = XColorWithRGB(129, 147, 180);
    [detail setCornerValue:8];
    [detail setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
    [detail setTextColor:[UIColor whiteColor]];
    [headView addSubview:detail];
    [detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(headView);
        make.top.mas_equalTo(nameLab.mas_bottom).offset(AdaptationWidth(5));
        make.width.mas_equalTo(AdaptationWidth(143));
    }];
    
    
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AdaptationWidth(211);
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
    return self.myPersonSecondList.count ? nil :view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return self.myPersonSecondList.count ? 0 : ScreenHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.myPersonSecondList.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptationWidth(63);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyPersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyPersonTableViewCell2"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MyPersonTableViewCell2" owner:self options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.connectionFirstModel = [ConnectionFirstModel mj_objectWithKeyValues:self.myPersonSecondList[indexPath.row]];
    cell.labNum.hidden = YES;
    cell.rightImage.hidden = YES;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (void)btnOnClick:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSMutableArray *)myPersonSecondList{
    if (!_myPersonSecondList) {
        _myPersonSecondList = [NSMutableArray array];
    }
    return _myPersonSecondList;
}
- (PageQueryRedModel *)pageQueryRedModel{
    if (!_pageQueryRedModel) {
        _pageQueryRedModel = [[PageQueryRedModel alloc]init];
    }
    return _pageQueryRedModel;
}
@end
