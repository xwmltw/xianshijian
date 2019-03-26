//
//  WalletTableView.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/26.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "WalletTableView.h"
#import "WalletTableViewCell.h"

@interface WalletTableView()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation WalletTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.backgroundColor = XColorWithRGB(248, 248, 248);
        self.delegate = self;
        self.dataSource = self;
        
        [self registerNib:[UINib nibWithNibName:@"WalletTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WalletTableViewCell"];
        
        self.mj_footer = [self.profitViewModel creatMjRefresh];
        BLOCKSELF
        [self.profitViewModel setProfitListBlock:^(ProfitModel *result) {
            [blockSelf.mj_footer endRefreshing];
            [blockSelf reloadData];
        }];
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *bgView = [[UIView alloc]init];
   
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = XColorWithRGB(255, 122, 122);
    [view setCornerValue:4];
    [bgView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgView).offset(AdaptationWidth(20));
        make.top.mas_equalTo(bgView).offset(AdaptationWidth(10));
        make.right.mas_equalTo(bgView).offset(AdaptationWidth(-20));
        make.height.mas_equalTo(AdaptationWidth(91));
    }];
   
    
    UILabel *loginLab2 = [[UILabel alloc]init];
    [loginLab2 setText:[NSString stringWithFormat:@"%.2f",[self.profitViewModel.profitModel.totalAmount doubleValue]]];
    [loginLab2 setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:AdaptationWidth(24)]];
    [loginLab2 setTextColor:[UIColor whiteColor]];
    [view addSubview:loginLab2];
    [loginLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view).offset(AdaptationWidth(20));
        make.top.mas_equalTo(view).offset(AdaptationWidth(19));
        
    }];
    
    UILabel *loginLab1 = [[UILabel alloc]init];
    [loginLab1 setText:@"余额（元）"];
    [loginLab1 setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
    [loginLab1 setTextColor:[UIColor whiteColor]];
    [view addSubview:loginLab1];
    [loginLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view).offset(AdaptationWidth(28));
        make.top.mas_equalTo(loginLab2.mas_bottom).offset(AdaptationWidth(2));
    }];

    
    UIButton *getMoneyBtn = [[UIButton alloc]init];
    [getMoneyBtn setCornerValue:2];
    [getMoneyBtn setTitle:@"提现" forState:UIControlStateNormal];
    [getMoneyBtn setBackgroundColor:XColorWithRGB(204, 0, 0)];
    [getMoneyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [getMoneyBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
    [getMoneyBtn addTarget:self action:@selector(btnOnClock:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:getMoneyBtn];
    [getMoneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(view).offset(AdaptationWidth(-20));
        make.centerY.mas_equalTo(view);
        make.width.mas_equalTo(AdaptationWidth(62));
        make.height.mas_equalTo(AdaptationWidth(30));
    }];
    
    UILabel *tips = [[UILabel alloc]init];
    [tips setText:@"提现明细"];
    [tips setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
    [tips setTextColor:LabelAssistantColor];
    [bgView addSubview:tips];
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgView).offset(AdaptationWidth(20));
        make.bottom.mas_equalTo(bgView).offset(-5);
    }];
    
    return bgView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AdaptationWidth(150);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptationWidth(113);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.profitViewModel.profitList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WalletTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WalletTableViewCell"];
    if (!cell) {
        cell = [[WalletTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WalletTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model =[ProtifDetailModel mj_objectWithKeyValues:self.profitViewModel.profitList[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (void)btnOnClock:(UIButton *)btn
{
    
}
- (ProfitViewModel *)profitViewModel{
    if (!_profitViewModel) {
        _profitViewModel = [[ProfitViewModel alloc]init];
    }
    return _profitViewModel;
}

@end
