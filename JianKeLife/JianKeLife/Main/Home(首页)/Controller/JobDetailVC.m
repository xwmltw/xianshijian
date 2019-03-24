//
//  JobDetailVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/20.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "JobDetailVC.h"
#import "JobDetailTableView.h"


@interface JobDetailVC ()
@property (nonatomic ,strong) JobDetailTableView *tableView;
@end

@implementation JobDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[JobDetailTableView alloc]initWithFrame:CGRectMake(0, -20, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.jobDetailViewModel.productModel.productNo = self.productNo;
     [self.tableView.jobDetailViewModel requestDetialData];
    [self.view addSubview: self.tableView];

    UIButton *balckBtn = [[UIButton alloc]init];
    balckBtn.tag = 1011;
    [balckBtn setCornerValue:AdaptationWidth(20)];
    [balckBtn setBackgroundImage:[UIImage createImageWithColor:XColorWithRBBA(255, 255, 255, 0.13)] forState:UIControlStateNormal];
    [balckBtn setImage:[UIImage imageNamed:@"icon_back-white"] forState:UIControlStateNormal];
    [balckBtn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:balckBtn];
    [balckBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(30);
        make.left.mas_equalTo(self.view).offset(16);
        make.height.width.mas_equalTo(AdaptationWidth(40));
    }];
    
    
    UIButton *shareBtn = [[UIButton alloc]init];
    shareBtn.tag = 1012;
    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [shareBtn setBackgroundColor:blueColor];
    [shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(AdaptationWidth(48));
        make.width.mas_equalTo(AdaptationWidth(188));
    }];
    
    UIButton *shareSalary = [[UIButton alloc]init];
    [shareSalary setBackgroundImage:[UIImage imageNamed:@"Detail_share_background"] forState:UIControlStateNormal];
    [shareSalary.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(12)]];
    [shareSalary setTitle:@"领￥1.20" forState:UIControlStateNormal];
    [shareSalary setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:shareSalary];
    [shareSalary mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(shareBtn).offset(AdaptationWidth(-7));
        make.top.mas_equalTo(shareBtn).offset(AdaptationWidth(-10));
        make.height.mas_equalTo(AdaptationWidth(21));
        make.width.mas_equalTo(AdaptationWidth(74));
    }];
    
    UIButton *recevieBtn = [[UIButton alloc]init];
    recevieBtn.tag = 1013;
    [recevieBtn setTitle:@"去领取" forState:UIControlStateNormal];
    [recevieBtn setBackgroundColor:RedColor];
    [recevieBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [recevieBtn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:recevieBtn];
    [recevieBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(AdaptationWidth(48));
        make.width.mas_equalTo(AdaptationWidth(188));
    }];
     
     [self.tableView.jobDetailViewModel setProductStateBlock:^(ProductModel *model) {
         model.hasApplyProd.integerValue ?
         [recevieBtn setTitle:@"已领取 去办理" forState:UIControlStateNormal] :
         [recevieBtn setTitle:@"去领取" forState:UIControlStateNormal];
         [shareSalary setTitle:[NSString stringWithFormat:@"领￥%.2f",[model.productShareSalary doubleValue]] forState:UIControlStateNormal];
         
     }];
}
-(void)btnOnClick:(UIButton *)btn{
    
    switch (btn.tag) {
        case 1011:
        {
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        case 1012:
        {
            
        }
            break;
        case 1013:
        {
            
        }
            break;
            
        default:
            break;
    }
}
@end
