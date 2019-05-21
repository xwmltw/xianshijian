//
//  SuperProductVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/5/21.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "SuperProductVC.h"
#import "HomeViewModel.h"
#import "JobDetailVC.h"
@interface SuperProductVC ()<UITableViewDelegate ,UITableViewDataSource>
@property (nonatomic ,strong) BaseTableView *tableView;
@property (nonatomic ,strong) HomeViewModel *homeViewModel;
@property (nonatomic ,strong) UIButton *superBtn;
@end

@implementation SuperProductVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, -20, ScreenWidth, ScreenHeight + 20) style:UITableViewStylePlain];
    self.tableView.backgroundColor = BackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = [self creatHeadView];
    [self.view addSubview:self.tableView];
    
    UIButton *blackBtn = [[UIButton alloc]init];
    [blackBtn setCornerValue:AdaptationWidth(20)];
    [blackBtn setBackgroundImage:[UIImage createImageWithColor:XColorWithRBBA(255, 255, 255, 0.13)] forState:UIControlStateNormal];
    [blackBtn setImage:[UIImage imageNamed:@"icon_back-white"] forState:UIControlStateNormal];
    [blackBtn addTarget:self action:@selector(btnBlackClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:blackBtn];
    [blackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(30);
        make.left.mas_equalTo(self.view).offset(16);
        make.height.width.mas_equalTo(AdaptationWidth(40));
    }];
    
    self.superBtn = [[UIButton alloc]init];
    [self.superBtn setImage: [UIImage imageNamed:self.superType.integerValue == 1 ? @"icon_super_new" :@"icon_super_quan"] forState:UIControlStateNormal];
    [self.superBtn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.superBtn];
    [self.superBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).offset(-10);
    }];
    self.tableView.mj_footer = [self.homeViewModel creatMjRefresh];
    self.homeViewModel.listType = self.superType;
    [self.homeViewModel requestData];
    WEAKSELF
    [self.homeViewModel setResponseBlock:^(id result) {
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf.tableView reloadData];
    }];
   
}
- (UIView *)creatHeadView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, AdaptationWidth(306))];
    UIImageView *image = [[UIImageView alloc]init];
    [image setImage: [UIImage imageNamed:@"icon_super_head"]];
    [view addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(view);
        make.height.mas_equalTo(AdaptationWidth(259));
    }];
    
    UILabel *lab = [[UILabel alloc]init];
    lab.text = self.superType.integerValue == 1 ? @"———— 新用户专场 ————" : @"———— 全员共享专场 ————";
    [lab setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(16)]];
    [lab setTextColor:LabelMainColor];
    [view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view);
        make.top.mas_equalTo(image.mas_bottom).offset(AdaptationWidth(11));
        
    }];
    return view;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.homeViewModel.productList.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptationWidth(110);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"SuperListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(cell).offset(AdaptationWidth(10));
            make.left.mas_equalTo(cell).offset(AdaptationWidth(10));
            make.right.mas_equalTo(cell).offset(AdaptationWidth(-10));
            make.bottom.mas_equalTo(cell);
        }];
        UIImageView *image = [[UIImageView alloc]init];
        [image sd_setImageWithURL:[NSURL URLWithString:self.homeViewModel.productList[indexPath.row][@"productFirstMainPicUrl"]]];
       
        [view addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(view);
            make.width.mas_equalTo(AdaptationWidth(150));
        }];
        
        UILabel *lab = [[UILabel alloc]init];
        lab.text = self.homeViewModel.productList[indexPath.row][@"productTitle"];
        [lab setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(16)]];
        [lab setTextColor:LabelMainColor];
        [view addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(image.mas_right).offset(AdaptationWidth(10));
            make.right.mas_equalTo(view).offset(AdaptationWidth(-10));
            make.top.mas_equalTo(view).offset(AdaptationWidth(10));
            
        }];
        
        UILabel *moneyLab = [[UILabel alloc]init];
        moneyLab.text = @"立领￥";
        [moneyLab setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(12)]];
        [moneyLab setTextColor:RedColor];
        [view addSubview:moneyLab];
        [moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(image.mas_right).offset(AdaptationWidth(10));
            make.bottom.mas_equalTo(view).offset(AdaptationWidth(-21));
            
        }];
        UILabel *money = [[UILabel alloc]init];
        money.text = [NSString stringWithFormat:@"%.2f",[self.homeViewModel.productList[indexPath.row][@"productSalary"] doubleValue]/100];
        [money setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(18)]];
        [money setTextColor:RedColor];
        [view addSubview:money];
        [money mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(moneyLab.mas_right).offset(AdaptationWidth(2));
            make.bottom.mas_equalTo(moneyLab);
            
        }];
        
        UIButton *goBtn = [[UIButton alloc]init];
        [goBtn setCornerValue:15];
        goBtn.backgroundColor = XColorWithRGB(255, 149, 149);
        [goBtn setTitle:@"立即参与" forState:UIControlStateNormal];
        [goBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [goBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
        [view addSubview:goBtn];
        [goBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(money);
            make.right.mas_equalTo(view).offset(AdaptationWidth(-10));
            make.width.mas_equalTo(AdaptationWidth(82));
            make.height.mas_equalTo(AdaptationWidth(28));
        }];
        
        UILabel *num = [[UILabel alloc]init];
        num.text = [NSString stringWithFormat:@"已领取%@",self.homeViewModel.productList[indexPath.row][@"prodApplyCount"]];
        [num setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(10)]];
        [num setTextColor:LabelAssistantColor];
        [view addSubview:num];
        [num mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(goBtn.mas_bottom).offset(AdaptationWidth(3));
            make.centerX.mas_equalTo(goBtn);
            
        }];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JobDetailVC *vc = [[JobDetailVC alloc]init];
    vc.productNo = self.homeViewModel.productList[indexPath.row][@"productNo"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)btnOnClick:(UIButton *)btn{
    if (self.superType.integerValue == 1) {
        self.superType = @2;
    }else{
        self.superType = @1;
    }
    
    self.tableView.tableHeaderView = [self creatHeadView];
    self.homeViewModel.listType = self.superType;
    [self.homeViewModel.productList removeAllObjects];
    [self.homeViewModel requestData];
    
    [self.superBtn setImage: [UIImage imageNamed:self.superType.integerValue == 1 ? @"icon_super_new" :@"icon_super_quan"] forState:UIControlStateNormal];
}
- (void)btnBlackClick:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}
- (HomeViewModel *)homeViewModel{
    if (!_homeViewModel) {
        _homeViewModel = [[HomeViewModel alloc]init];
        
    }
    return _homeViewModel;
}

@end
