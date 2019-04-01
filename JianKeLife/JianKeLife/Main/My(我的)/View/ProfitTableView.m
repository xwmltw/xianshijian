//
//  ProfitTableView.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/26.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "ProfitTableView.h"
#import "ProfitTableViewCell.h"


@interface ProfitTableView()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation ProfitTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.backgroundColor = XColorWithRGB(248, 248, 248);
        self.delegate = self;
        self.dataSource = self;
        
        [self registerNib:[UINib nibWithNibName:@"ProfitTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ProfitTableViewCell"];
        
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
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    UIImageView *headerImage = [[UIImageView alloc]init];
    [headerImage setImage:[UIImage imageNamed:@"icon_profit_head"]];
    [view addSubview:headerImage];
    [headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(view);
        make.height.mas_equalTo(AdaptationWidth(147));
    }];
    
    UILabel *loginLab1 = [[UILabel alloc]init];
    [loginLab1 setText:@"到账总收益(元)"];
    [loginLab1 setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
    [loginLab1 setTextColor:[UIColor whiteColor]];
    [view addSubview:loginLab1];
    [loginLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view);
        make.top.mas_equalTo(view).offset(AdaptationWidth(57));
    }];
    
    UILabel *loginLab2 = [[UILabel alloc]init];
    [loginLab2 setText:[NSString stringWithFormat:@"%.2f",[self.profitViewModel.profitModel.actualReceviceAmt doubleValue]/100]];
    [loginLab2 setFont:[UIFont fontWithName:@"PingFangSC-Bold" size:AdaptationWidth(24)]];
    [loginLab2 setTextColor:[UIColor whiteColor]];
    [view addSubview:loginLab2];
    [loginLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view);
        make.top.mas_equalTo(loginLab1.mas_bottom).offset(AdaptationWidth(2));
    }];
    
    UILabel *loginLab3 = [[UILabel alloc]init];
    [loginLab3 setText:@"收益已转入您的钱包"];
    [loginLab3 setFont:[UIFont systemFontOfSize:AdaptationWidth(12)]];
    [loginLab3 setTextColor:XColorWithRGB(0, 37, 113)];
    [view addSubview:loginLab3];
    [loginLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view);
        make.top.mas_equalTo(loginLab2.mas_bottom).offset(AdaptationWidth(8));
    }];
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AdaptationWidth(147);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGSize detailSize = [self.profitViewModel.profitList[indexPath.row][@"moneyFlowTitle"] boundingRectWithSize:CGSizeMake(AdaptationWidth(235), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:nil context:nil].size;
//    MyLog(@"%@",self.profitViewModel.profitList[indexPath.row][@"moneyFlowTitle"]);
//    MyLog(@"%f",detailSize.height);
    CGFloat cellH = 90 + detailSize.height;
    
    return AdaptationWidth(cellH);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.profitViewModel.profitList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProfitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfitTableViewCell"];
    if (!cell) {
        cell = [[ProfitTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProfitTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model =[ProtifDetailModel mj_objectWithKeyValues:self.profitViewModel.profitList[indexPath.row]] ;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
 
}

- (ProfitViewModel *)profitViewModel{
    if (!_profitViewModel) {
        _profitViewModel = [[ProfitViewModel alloc]init];
    }
    return _profitViewModel;
}

@end
