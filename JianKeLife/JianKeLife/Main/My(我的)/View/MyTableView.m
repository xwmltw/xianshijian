//
//  MyTableView.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/18.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "MyTableView.h"
#import "LoginVC.h"
#import "BaseParamModel.h"

@interface  MyTableView ()<UITableViewDelegate,UITableViewDataSource>
{
    UIImageView *cellImage;
    UIImageView *cellRightImage;
    UILabel *cellDetail;
    UILabel *cellTell;
}
@end

@implementation MyTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.backgroundColor = XColorWithRGB(248, 248, 248);
        self.delegate = self;
        self.dataSource = self;
        
        
        BLOCKSELF
        [self.viewModel setRequestMyInfoBlock:^(MyModel *model) {
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
    
     UIButton *headerBtn = [[UIButton alloc]init];
    
    UIImageView *headerImage = [[UIImageView alloc]init];
    [headerImage setImage:[UIImage imageNamed:@"icon_my_header"]];
    [view addSubview:headerImage];
    [headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(view);
        make.height.mas_equalTo(AdaptationWidth(162));
    }];
    
    if (![[UserInfo sharedInstance]isSignIn]) {
        
        [headerBtn setImage:[UIImage imageNamed:@"默认头像"] forState:UIControlStateNormal];
        
        UIImageView *headerImage2 = [[UIImageView alloc]init];
        [headerImage2 setImage:[UIImage imageNamed:@"icon_my_header2"]];
        [view addSubview:headerImage2];
        [headerImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(view).offset(AdaptationWidth(16));
            make.right.mas_equalTo(view).offset(AdaptationWidth(-16));
            make.top.mas_equalTo(view).offset(AdaptationWidth(49));
            make.height.mas_equalTo(AdaptationWidth(247));
        }];
        
        UIButton *loginBtn = [[UIButton alloc]init];
        loginBtn.tag = 401;
        [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [loginBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(17)]];
        [loginBtn setBackgroundColor:blueColor];
        [loginBtn setCornerValue:4];
        [loginBtn addTarget:self action:@selector(btnOnClock:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:loginBtn];
        [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(view);
            make.centerY.mas_equalTo(20);
            make.width.mas_equalTo(AdaptationWidth(94));
            make.height.mas_equalTo(AdaptationWidth(31));
        }];
        
        UILabel *loginLab = [[UILabel alloc]init];
        [loginLab setText:@"您还未登录，快去登录吧~"];
        [loginLab setFont:[UIFont systemFontOfSize:AdaptationWidth(20)]];
        [loginLab setTextColor:LabelMainColor];
        [view addSubview:loginLab];
        [loginLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(view);
            make.bottom.mas_equalTo(loginBtn.mas_top).offset(AdaptationWidth(-12));
        }];
    }else{

        if (self.viewModel.myModel.headLogo.length) {
            [headerBtn sd_setImageWithURL:[NSURL URLWithString:self.viewModel.myModel.headLogo] forState:UIControlStateNormal];
        }else{
             [headerBtn setImage:[UIImage imageNamed:@"默认头像"] forState:UIControlStateNormal];
        }
        
        
        UIView *heardView = [[UIView alloc]init];
        [heardView setCornerValue:4];
        heardView.backgroundColor = [UIColor whiteColor];
        [view addSubview:heardView];
        [heardView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(view).offset(AdaptationWidth(16));
            make.right.mas_equalTo(view).offset(AdaptationWidth(-16));
            make.top.mas_equalTo(view).offset(AdaptationWidth(49));
            make.height.mas_equalTo(AdaptationWidth(169));
        }];
        
        UILabel *nameLab = [[UILabel alloc]init];
        [nameLab setText:self.viewModel.myModel.trueName];
        [nameLab setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
        [nameLab setTextColor:LabelMainColor];
        [heardView addSubview:nameLab];
        [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(view);
            make.top.mas_equalTo(heardView).offset(AdaptationWidth(35));
        }];
        
        UILabel *telLab = [[UILabel alloc]init];
        [telLab setText:self.viewModel.myModel.telephone];
        [telLab setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
        [telLab setTextColor:LabelMainColor];
        [heardView addSubview:telLab];
        [telLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(view);
            make.top.mas_equalTo(nameLab.mas_bottom).offset(AdaptationWidth(2));
        }];
        
        UIButton *setBtn = [[UIButton alloc]init];
        [setBtn setImage:[UIImage imageNamed:@"icon_edit"] forState:UIControlStateNormal];
        setBtn.tag = 402;
        [setBtn addTarget:self action:@selector(btnOnClock:) forControlEvents:UIControlEventTouchUpInside];
        [heardView addSubview:setBtn];
        [setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(telLab.mas_right).offset(AdaptationWidth(8));
            make.centerY.mas_equalTo(telLab);
        }];
        
        UIView *line = [[UIView alloc]init];
        [line setBackgroundColor:LineColor];
        [heardView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(heardView);
            make.top.mas_equalTo(telLab.mas_bottom).offset(AdaptationWidth(14));
            make.width.mas_equalTo(AdaptationWidth(1));
            make.height.mas_equalTo(AdaptationWidth(65));
        }];
        
        UILabel *upDetailLab = [[UILabel alloc]init];
        [upDetailLab setText:@"到账总收益（元）"];
        [upDetailLab setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
        [upDetailLab setTextColor:LabelMainColor];
        [heardView addSubview:upDetailLab];
        [upDetailLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(heardView).offset(AdaptationWidth(14));
            make.top.mas_equalTo(telLab.mas_bottom).offset(AdaptationWidth(14));
        }];
        
        UILabel *upMoneyLab = [[UILabel alloc]init];
        [upMoneyLab setText:[NSString stringWithFormat:@"%.2f",[self.viewModel.myModel.actualReceviceAmt doubleValue]/100]];
        [upMoneyLab setFont:[UIFont systemFontOfSize:AdaptationWidth(20)]];
        [upMoneyLab setTextColor:RedColor];
        [heardView addSubview:upMoneyLab];
        [upMoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(upDetailLab);
            make.top.mas_equalTo(upDetailLab.mas_bottom).offset(AdaptationWidth(2));
        }];
        
        UIButton *goDetailBtn = [[UIButton alloc]init];
        goDetailBtn.tag = 403;
        [goDetailBtn setTitle:@"明细 ->" forState:UIControlStateNormal];
        [goDetailBtn setTitleColor:blueColor forState:UIControlStateNormal];
        [goDetailBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
        [goDetailBtn addTarget:self action:@selector(btnOnClock:) forControlEvents:UIControlEventTouchUpInside];
        [heardView addSubview:goDetailBtn];
        [goDetailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(line).offset(AdaptationWidth(-15));
            make.bottom.mas_equalTo(heardView).offset(AdaptationWidth(-15));
        }];
        
        UILabel *walletLab = [[UILabel alloc]init];
        [walletLab setText:@"钱包余额（元）"];
        [walletLab setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
        [walletLab setTextColor:LabelMainColor];
        [heardView addSubview:walletLab];
        [walletLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(line).offset(AdaptationWidth(14));
            make.top.mas_equalTo(telLab.mas_bottom).offset(AdaptationWidth(14));
        }];
        
        UILabel *moneyLab = [[UILabel alloc]init];
        [moneyLab setText:[NSString stringWithFormat:@"%.2f",[self.viewModel.myModel.totalAmount doubleValue]/100]];
        [moneyLab setFont:[UIFont systemFontOfSize:AdaptationWidth(20)]];
        [moneyLab setTextColor:RedColor];
        [heardView addSubview:moneyLab];
        [moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(walletLab);
            make.top.mas_equalTo(walletLab.mas_bottom).offset(AdaptationWidth(2));
        }];
        
        UIButton *getMoneyBtn = [[UIButton alloc]init];
        getMoneyBtn.tag = 404;
        [getMoneyBtn setTitle:@"提现 ->" forState:UIControlStateNormal];
        [getMoneyBtn setTitleColor:blueColor forState:UIControlStateNormal];
        [getMoneyBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
        [getMoneyBtn addTarget:self action:@selector(btnOnClock:) forControlEvents:UIControlEventTouchUpInside];
        [heardView addSubview:getMoneyBtn];
        [getMoneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(heardView).offset(AdaptationWidth(-15));
            make.bottom.mas_equalTo(heardView).offset(AdaptationWidth(-15));
        }];
        
        UIView *heardView2 = [[UIView alloc]init];
        [heardView2 setCornerValue:4];
        heardView2.backgroundColor = [UIColor whiteColor];
        [view addSubview:heardView2];
        [heardView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(view).offset(AdaptationWidth(16));
            make.right.mas_equalTo(view).offset(AdaptationWidth(-16));
            make.top.mas_equalTo(heardView.mas_bottom).offset(AdaptationWidth(10));
            make.height.mas_equalTo(AdaptationWidth(67));
        }];
        
        UIImageView *hongbao = [[UIImageView alloc]init];
        [hongbao setImage:[UIImage imageNamed:@"icon_my_红包"]];
        [heardView2 addSubview:hongbao];
        [hongbao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(heardView2);
            make.left.mas_equalTo(heardView2).offset(AdaptationWidth(20));
            make.width.mas_equalTo(AdaptationWidth(51));
            make.height.mas_equalTo(AdaptationWidth(44));
        }];
        
        UILabel *willLab = [[UILabel alloc]init];
        [willLab setText:@"即将到账（元）"];
        [willLab setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
        [willLab setTextColor:LabelMainColor];
        [heardView2 addSubview:willLab];
        [willLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(hongbao.mas_right).offset(AdaptationWidth(25));
            make.top.mas_equalTo(hongbao);
        }];
        
        UILabel *willMoneyLab = [[UILabel alloc]init];
        [willMoneyLab setText:[NSString stringWithFormat:@"%.2f",[self.viewModel.myModel.forecastReceviceAmt doubleValue]/100]];
        [willMoneyLab setFont:[UIFont systemFontOfSize:AdaptationWidth(20)]];
        [willMoneyLab setTextColor:RedColor];
        [heardView2 addSubview:willMoneyLab];
        [willMoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(hongbao.mas_right).offset(AdaptationWidth(25));
            make.top.mas_equalTo(willLab.mas_bottom).offset(AdaptationWidth(2));
        }];
        
        UIButton *getDetailBtn = [[UIButton alloc]init];
        getDetailBtn.tag = 405;
        [getDetailBtn setTitle:@"明细 ->" forState:UIControlStateNormal];
        [getDetailBtn setTitleColor:blueColor forState:UIControlStateNormal];
        [getDetailBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
        [getDetailBtn addTarget:self action:@selector(btnOnClock:) forControlEvents:UIControlEventTouchUpInside];
        [heardView2 addSubview:getDetailBtn];
        [getDetailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(heardView2).offset(AdaptationWidth(-15));
            make.bottom.mas_equalTo(heardView2).offset(AdaptationWidth(-11));
        }];
    }
    
    
   
    headerBtn.tag = 406;
    
    [headerBtn addTarget:self action:@selector(btnOnClock:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:headerBtn];
    [headerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view);
        make.width.height.mas_equalTo(AdaptationWidth(60));
        make.top.mas_equalTo(view).offset(AdaptationWidth(20));
    }];
    
    
    
    
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AdaptationWidth(323);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cellImage = [[UIImageView alloc]init];
        [cell.contentView addSubview:cellImage];
        [cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell).offset(AdaptationWidth(16));
            make.centerY.mas_equalTo(cell);
        }];
        
        cellDetail = [[UILabel alloc]init];
        [cellDetail setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
        [cellDetail setTextColor:LabelMainColor];
        [cell.contentView addSubview:cellDetail];
        [cellDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self->cellImage.mas_right).offset(AdaptationWidth(10));
            make.centerY.mas_equalTo(cell);
        }];
        
        cellRightImage = [[UIImageView alloc]init];
        cellRightImage.hidden = NO;
        [cellRightImage setImage:[UIImage imageNamed:@"icon_right"]];
        [cell.contentView addSubview:cellRightImage];
        [cellRightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(cell).offset(AdaptationWidth(-16));
            make.centerY.mas_equalTo(cell);
        }];
        
        UIView *line = [[UIView alloc]init];
        [line setBackgroundColor:LineColor];
        [cell.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell).offset(AdaptationWidth(42));
            make.right.mas_equalTo(cell);
            make.height.mas_equalTo(AdaptationWidth(1));
        }];
        
    }
    switch (indexPath.row) {
        case 0:
            [cellImage setImage:[UIImage imageNamed:@"icon_feedback"]];
            [cellDetail setText:@"意见反馈"];
            break;
        case 1:
        {
            [cellImage setImage:[UIImage imageNamed:@"icon_contact"]];
            [cellDetail setText:@"联系客服"];
            cellRightImage.hidden = YES;
            UILabel *telLab = [[UILabel alloc]init];
            telLab.text  = [ClientGlobalInfo getClientGlobalInfoModel].customerContact;
            [telLab setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
            [telLab setTextColor:LabelAssistantColor];
            [cell.contentView addSubview:telLab];
            [telLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(cell).offset(AdaptationWidth(-16));
                make.centerY.mas_equalTo(cell);
            }];
        }
            break;
        case 2:
            [cellImage setImage:[UIImage imageNamed:@"icon_about"]];
            [cellDetail setText:@"关于我们"];
            break;
        case 3:
            [cellImage setImage:[UIImage imageNamed:@"icon_setting"]];
            [cellDetail setText:@"设置"];
            break;
            
        default:
            break;
    }
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    XBlockExec(self.cellSelectBlock, indexPath.row);
}

#pragma mark - btn
-(void)btnOnClock:(UIButton *)btn{
    XBlockExec(self.btnBlock ,btn);
}
- (MyViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[MyViewModel alloc]init];
    }
    return _viewModel;
}
@end
