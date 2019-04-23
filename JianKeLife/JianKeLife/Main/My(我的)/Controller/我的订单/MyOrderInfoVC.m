//
//  MyOrderInfoVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/4/23.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "MyOrderInfoVC.h"

@interface MyOrderInfoVC ()

@end

@implementation MyOrderInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于订单";
    self.view.backgroundColor = BackgroundColor;
    
    UIView *view1 = [[UIView alloc]init];
    view1.backgroundColor = blueColor;
    [view1 setCornerValue:4];
    [self.view addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(AdaptationWidth(16));
        make.left.mas_equalTo(self.view).offset(AdaptationWidth(16));
        make.right.mas_equalTo(self.view).offset(AdaptationWidth(-16));
        make.height.mas_equalTo(AdaptationWidth(116));
    }];
    
    UILabel *viewLab1 = [[UILabel alloc]init];
    [viewLab1 setText:@"1）佣金是怎么结算的？"];
    [viewLab1 setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
    [viewLab1 setTextColor:[UIColor whiteColor]];
    [view1 addSubview:viewLab1];
    [viewLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view1).offset(AdaptationWidth(20));
        make.left.mas_equalTo(view1).offset(AdaptationWidth(13));
    }];
    
    UILabel *viewDetailLab1 = [[UILabel alloc]init];
    viewDetailLab1.numberOfLines = 0;
    [viewDetailLab1 setText:@"每月25日结算上个月您确认收货的订单，如：4月10日确认收货的订单，佣金则在5月25日可提现。"];
    [viewDetailLab1 setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
    [viewDetailLab1 setTextColor:[UIColor whiteColor]];
    [view1 addSubview:viewDetailLab1];
    [viewDetailLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(viewLab1.mas_bottom).offset(AdaptationWidth(10));
        make.left.mas_equalTo(view1).offset(AdaptationWidth(13));
        make.right.mas_equalTo(view1).offset(AdaptationWidth(-13));
        make.bottom.mas_equalTo(view1).offset(AdaptationWidth(-10));
    }];
    
    
    
    UIView *view2 = [[UIView alloc]init];
    view2.backgroundColor = blueColor;
    [view2 setCornerValue:4];
    [self.view addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view1.mas_bottom).offset(AdaptationWidth(16));
        make.left.mas_equalTo(self.view).offset(AdaptationWidth(16));
        make.right.mas_equalTo(self.view).offset(AdaptationWidth(-16));
        make.height.mas_equalTo(AdaptationWidth(116));
    }];
    
    UILabel *viewLab2 = [[UILabel alloc]init];
    [viewLab2 setText:@"2）为什么确认收货了但是订单又失效了？"];
    [viewLab2 setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
    [viewLab2 setTextColor:[UIColor whiteColor]];
    [view2 addSubview:viewLab2];
    [viewLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view2).offset(AdaptationWidth(20));
        make.left.mas_equalTo(view2).offset(AdaptationWidth(13));
    }];
    
    UILabel *viewDetailLab2 = [[UILabel alloc]init];
    viewDetailLab2.numberOfLines = 0;
    [viewDetailLab2 setText:@"在确认收货后申请订单维权（退换货），这种订单为失效订单，次月25日不予结算。"];
    [viewDetailLab2 setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
    [viewDetailLab2 setTextColor:[UIColor whiteColor]];
    [view2 addSubview:viewDetailLab2];
    [viewDetailLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(viewLab2.mas_bottom).offset(AdaptationWidth(10));
        make.left.mas_equalTo(view2).offset(AdaptationWidth(13));
        make.right.mas_equalTo(view2).offset(AdaptationWidth(-13));
        make.bottom.mas_equalTo(view2).offset(AdaptationWidth(-10));
    }];
    
    
    UIView *view3 = [[UIView alloc]init];
    view3.backgroundColor = blueColor;
    [view3 setCornerValue:4];
    [self.view addSubview:view3];
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view2.mas_bottom).offset(AdaptationWidth(16));
        make.left.mas_equalTo(self.view).offset(AdaptationWidth(16));
        make.right.mas_equalTo(self.view).offset(AdaptationWidth(-16));
        make.height.mas_equalTo(AdaptationWidth(125));
    }];
    
    UILabel *viewLab3 = [[UILabel alloc]init];
    [viewLab3 setText:@"3）为什么下单了，却没显示？"];
    [viewLab3 setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
    [viewLab3 setTextColor:[UIColor whiteColor]];
    [view3 addSubview:viewLab3];
    [viewLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view3).offset(AdaptationWidth(20));
        make.left.mas_equalTo(view3).offset(AdaptationWidth(13));
    }];
    
    UILabel *viewDetailLab3 = [[UILabel alloc]init];
    viewDetailLab3.numberOfLines = 0;
    [viewDetailLab3 setText:@"一般情况下订单在10分钟内就会同步，但是如果您下单时没有使用今日值享的优惠券那么订单就不会同步到今日值享哦。"];
    [viewDetailLab3 setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
    [viewDetailLab3 setTextColor:[UIColor whiteColor]];
    [view3 addSubview:viewDetailLab3];
    [viewDetailLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(viewLab3.mas_bottom).offset(AdaptationWidth(10));
        make.left.mas_equalTo(view3).offset(AdaptationWidth(13));
        make.right.mas_equalTo(view3).offset(AdaptationWidth(-13));
        make.bottom.mas_equalTo(view3).offset(AdaptationWidth(-10));
    }];
    
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
