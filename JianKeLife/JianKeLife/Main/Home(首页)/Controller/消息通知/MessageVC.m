//
//  MessageVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/5/10.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "MessageVC.h"
#import "MessageDetailVC.h"

@interface MessageVC ()

@end

@implementation MessageVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = XColorWithRGB(248, 248, 248);
    [self creatUI];
}
-(void)creatUI{
    
    UIImageView *headerImage = [[UIImageView alloc]init];
    [headerImage setImage:[UIImage imageNamed:@"icon_profit_head"]];
    [self.view addSubview:headerImage];
    [headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.height.mas_equalTo(AdaptationWidth(147));
    }];
    
    UILabel *loginLab1 = [[UILabel alloc]init];
    [loginLab1 setText:@"消息中心"];
    [loginLab1 setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
    [loginLab1 setTextColor:[UIColor whiteColor]];
    [self.view addSubview:loginLab1];
    [loginLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(40);
    }];
    
    UIButton *balckBtn = [[UIButton alloc]init];
    balckBtn.tag = 1011;
    [balckBtn setImage:[UIImage imageNamed:@"icon_back-white"] forState:UIControlStateNormal];
    [balckBtn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:balckBtn];
    [balckBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(30);
        make.left.mas_equalTo(self.view).offset(20);
        make.height.width.mas_equalTo(AdaptationWidth(40));
    }];
    
    UIView *headView = [[UIView alloc]init];
    [headView setCornerValue:4];
    headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headView];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(loginLab1.mas_bottom).offset(20);
        make.left.mas_equalTo(self.view).offset(10);
        make.width.mas_equalTo(AdaptationWidth(355));
        make.height.mas_equalTo(AdaptationWidth(99));
    }];
    
    UIButton *notiBtn = [[UIButton alloc]init];
    notiBtn.tag = 1012;
    [notiBtn setTitle:@"通知" forState:UIControlStateNormal];
    [notiBtn setImage:[UIImage imageNamed:@"icon_message_noti"] forState:UIControlStateNormal];
    [notiBtn setTitleColor:LabelMainColor forState:UIControlStateNormal];
    [notiBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
    notiBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 20, 0);
    notiBtn.titleEdgeInsets = UIEdgeInsetsMake(AdaptationWidth(65), -notiBtn.currentImage.size.width, 0,  -5);
    [notiBtn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:notiBtn];
    [notiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headView);
        make.centerX.mas_equalTo(headView).multipliedBy(0.5);
        make.height.mas_equalTo(AdaptationWidth(99));
    }];
    
    UIButton *profitBtn = [[UIButton alloc]init];
    profitBtn.tag = 1013;
    [profitBtn setTitle:@"收益" forState:UIControlStateNormal];
    [profitBtn setImage:[UIImage imageNamed:@"icon_message_expect"] forState:UIControlStateNormal];
    [profitBtn setTitleColor:LabelMainColor forState:UIControlStateNormal];
    [profitBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
    profitBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 20, 0);
    profitBtn.titleEdgeInsets = UIEdgeInsetsMake(AdaptationWidth(65), -notiBtn.currentImage.size.width, 0,  -5);
    [profitBtn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:profitBtn];
    [profitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headView);
        make.centerX.mas_equalTo(headView).multipliedBy(1.5);
        make.height.mas_equalTo(AdaptationWidth(99));
    }];
    
}
- (void)btnOnClick:(UIButton *)btn{
    switch (btn.tag) {
        case 1011:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 1012:
        {
            MessageDetailVC *vc = [[MessageDetailVC alloc]init];
            vc.title = @"通知";
            vc.messageType = @1;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1013:
        {
            MessageDetailVC *vc = [[MessageDetailVC alloc]init];
            vc.title = @"收益";
            vc.messageType = @2;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
    
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
