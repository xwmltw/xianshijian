//
//  MessageVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/5/10.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "MessageVC.h"
#import "MessageDetailVC.h"
#import "MySetVC.h"

@interface MessageVC ()
@property (nonatomic ,strong) NSDictionary *redDic;
@property (nonatomic ,strong)UIView *redNoti;
@property (nonatomic ,strong)UIView *redProfit;
@property (nonatomic ,strong)UIView *pushView;
@end

@implementation MessageVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = XColorWithRGB(248, 248, 248);
    self.redDic = [NSDictionary dictionary];
    WEAKSELF
    [XNetWork requestNetWorkWithUrl:Xred_point_info andModel:nil andSuccessBlock:^(ResponseModel *model) {
        weakSelf.redDic  = [NSDictionary dictionaryWithDictionary:model.data];
        [weakSelf creatUI];
    } andFailBlock:^(ResponseModel *model) {
        
    }];
    
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
        make.width.mas_equalTo(AdaptationWidth(81));
    }];
    
    self.redNoti = [[UIView alloc]init];
    [self.redNoti setCornerValue:5];
    self.redNoti.backgroundColor = RedColor;
    [notiBtn addSubview:self.redNoti];
    [self.redNoti mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(notiBtn).offset(AdaptationWidth(15));
        make.right.mas_equalTo(notiBtn).offset(AdaptationWidth(-15));
        make.width.height.mas_equalTo(10);
        
    }];
    
    NSNumber *notired = self.redDic[@"noticeMessageRedPoint"];
    self.redNoti.hidden = notired.integerValue ? NO:YES ;
    
    
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
        make.width.mas_equalTo(AdaptationWidth(81));
    }];
    
    self.redProfit = [[UIView alloc]init];
    [self.redProfit setCornerValue:2];
    self.redProfit.backgroundColor = RedColor;
    [profitBtn addSubview:self.redProfit];
    [self.redProfit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(profitBtn).offset(AdaptationWidth(15));
        make.right.mas_equalTo(profitBtn).offset(AdaptationWidth(-15));
        make.width.height.mas_equalTo(10);
        
    }];
    
    NSNumber *profitred = self.redDic[@"profitMessageRedPoint"];
    self.redProfit.hidden = profitred.integerValue ? NO:YES ;
    
    [self.view addSubview:self.pushView];
    [self.pushView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headView.mas_bottom).offset(10);
        make.left.mas_equalTo(self.view).offset(10);
        make.width.mas_equalTo(AdaptationWidth(355));
        make.height.mas_equalTo(AdaptationWidth(45));
    }];
//    UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
//    if (UIUserNotificationTypeNone == setting.types) {
//        self.pushView.hidden = NO;
//    }else{
//        self.pushView.hidden = YES;
//    }
    
    UIButton *cancelPush = [[UIButton alloc]init];
    cancelPush.tag = 1014;
    [cancelPush setImage:[UIImage imageNamed:@"icon_xx_black"] forState:UIControlStateNormal];
    [cancelPush addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.pushView addSubview:cancelPush];
    [cancelPush mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pushView).offset(1);
        make.left.mas_equalTo(self.pushView).offset(8);

    }];
    
    UILabel *titlePush = [[UILabel alloc]init];
    [titlePush setText:@"避免错过重要通知，请开启系统通知"];
    [titlePush setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
    [titlePush setTextColor:LabelMainColor];
    [self.pushView addSubview:titlePush];
    [titlePush mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.pushView).offset(-40);
        make.centerY.mas_equalTo(self.pushView);
    }];
    
    UIButton *goPush = [[UIButton alloc]init];
    goPush.tag = 1015;
    [goPush setBackgroundColor:RedColor];
    [goPush setCornerValue:AdaptationWidth(15)];
//    [goPush setBackgroundImage:[UIImage imageNamed:@"icon_message_push"] forState:UIControlStateNormal];
    [goPush setTitle:@"去开启" forState:UIControlStateNormal];
    [goPush addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.pushView addSubview:goPush];
    [goPush mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.pushView);
        make.right.mas_equalTo(self.pushView).offset(-8);
        make.width.mas_equalTo(AdaptationWidth(80));
        make.height.mas_equalTo(AdaptationWidth(30));
        
    }];
    
}
- (void)btnOnClick:(UIButton *)btn{
    switch (btn.tag) {
        case 1011:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 1012:
        {
            self.redNoti.hidden = YES;
            MessageDetailVC *vc = [[MessageDetailVC alloc]init];
            vc.title = @"通知";
            vc.messageType = @1;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1013:
        {
            self.redProfit.hidden = YES;
            MessageDetailVC *vc = [[MessageDetailVC alloc]init];
            vc.title = @"收益";
            vc.messageType = @2;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1014:{
            self.pushView.hidden = YES;
        }
            break;
        case 1015:{
            MySetVC*vc = [[MySetVC alloc]init];
          
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
    
}
- (UIView *)pushView{
    if (!_pushView) {
        _pushView = [[UIView alloc]init];
        _pushView.backgroundColor = XColorWithRGB(255, 236, 123);
    }
    return _pushView;
}

@end
