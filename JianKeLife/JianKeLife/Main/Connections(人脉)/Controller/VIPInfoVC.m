//
//  VIPInfoVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/6/3.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "VIPInfoVC.h"
#import "MyViewModel.h"
#import "ConnectionViewModel.h"
#import "WXApi.h"
#import <ShareSDK/ShareSDK.h>
#import "UnLoginView.h"
#import "MyConnectionVC.h"
@interface VIPInfoVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) MyViewModel *myViewModel;
@property (nonatomic ,strong) ConnectionViewModel *connectionViewModel;
@property (nonatomic ,strong) NSNumber *singleConsume;
@property (nonatomic ,strong) NSDictionary *paramsExt;
@property (nonatomic ,strong) UnLoginView *unLoginView;
@end

@implementation VIPInfoVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    if (![UserInfo sharedInstance].isSignIn){
        WEAKSELF
        self.unLoginView.hidden = NO;
        [self.unLoginView setBtnBlock:^(id result) {
            [weakSelf goToLogin];
        }];
        
    }else{
        self.unLoginView.hidden = YES;
        [self getData];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedRowHeight = AdaptationWidth(68);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    
}

- (void)getData{
    
    //创建列队组
    dispatch_group_t group = dispatch_group_create();
    //获取全局并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_async(group, queue, ^{
        
    });
    dispatch_group_async(group, queue, ^{
        
    });
    dispatch_group_async(group, queue, ^{
        
    });
    // 当并发队列组中的任务执行完毕后才会执行这里的代码
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 合并图片
    });
    
    [self.connectionViewModel requestData];
    WEAKSELF
    [self.connectionViewModel setConnectionRequestBlcok:^(id result) {
        [weakSelf.myViewModel requestUserInfo];
    }];
    [self.myViewModel setRequestMyInfoBlock:^(id result) {
        if (weakSelf.myViewModel.myModel.memberType.integerValue == 2) {
            [weakSelf.tableView  reloadData];
        }else{
            [weakSelf.connectionViewModel requestVIPData];
        }
    }];
    [self.connectionViewModel setMemberRequestBlcok:^(NSNumber *result) {
        weakSelf.singleConsume = result;
        [weakSelf.tableView  reloadData];
    }];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor  = [UIColor whiteColor];
    UIView *headView = [[UIView alloc]init];
    headView.backgroundColor = XColorWithRGB(236, 203, 149);
    [view addSubview:headView];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(view);
        make.height.mas_equalTo(AdaptationWidth(160));
    }];
    
    
    
    UIImageView *headerImage = [[UIImageView alloc]init];
    [headerImage setCornerValue:AdaptationWidth(24)];
    [headerImage sd_setImageWithURL:[NSURL URLWithString:self.myViewModel.myModel.headLogo] placeholderImage:[UIImage imageNamed:@"默认头像"]];
//    [headerImage setImage:[UIImage imageNamed:@"icon_profit_head"]];
    [headView addSubview:headerImage];
    [headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(headView);
        make.left.mas_equalTo(headView).offset(AdaptationWidth(20));
        make.height.width.mas_equalTo(AdaptationWidth(48));
    }];
    
    UILabel *nameLab = [[UILabel alloc]init];
    [nameLab setText:self.myViewModel.myModel.trueName];
    [nameLab setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
    [nameLab setTextColor:[UIColor whiteColor]];
    [headView addSubview:nameLab];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(headView);
        make.left.mas_equalTo(headerImage.mas_right).offset(AdaptationWidth(12));
    }];
    
    UIImageView *VIPImage = [[UIImageView alloc]init];
    [VIPImage setCornerValue:AdaptationWidth(24)];
    [VIPImage setImage:self.myViewModel.myModel.memberType.integerValue == 1 ? [UIImage imageNamed:@"icon_vip_no"] : [UIImage imageNamed:@"icon_vip"]];
    [headView addSubview:VIPImage];
    [VIPImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(headView);
        make.right.mas_equalTo(headView).offset(AdaptationWidth(-22));
        make.width.mas_equalTo(AdaptationWidth(62));
        make.height.mas_equalTo(AdaptationWidth(38));
    }];
    
    UIView *connecttionView = [[UIView alloc]init];
    [connecttionView setCornerValue:AdaptationWidth(8)];
    connecttionView.backgroundColor = [UIColor whiteColor];
    [view addSubview:connecttionView];
    [connecttionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view);
        make.height.mas_equalTo(AdaptationWidth(80));
        make.width.mas_equalTo(AdaptationWidth(347));
        make.top.mas_equalTo(headView.mas_bottom).offset(-AdaptationWidth(40));
    }];
    UIImageView *connecttionViewBG = [[UIImageView alloc]init];
    [connecttionViewBG setImage:[UIImage imageNamed:@"icon_vip_bgView"]];
    [connecttionView addSubview:connecttionViewBG];
    [connecttionViewBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(connecttionView).offset(AdaptationWidth(-15));
        make.right.mas_equalTo(connecttionView).offset(AdaptationWidth(15));
        make.top.mas_equalTo(connecttionView).offset(AdaptationWidth(-10));
        make.bottom.mas_equalTo(connecttionView).offset(AdaptationWidth(10));
    }];
    
    
    
    UIImageView *mygroupImage = [[UIImageView alloc]init];
    [mygroupImage setImage:[UIImage imageNamed:@"我的创业团"]];
    [connecttionView addSubview:mygroupImage];
    [mygroupImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(connecttionView).offset(AdaptationWidth(18));
        make.top.mas_equalTo(connecttionView).offset(AdaptationWidth(13));
        
    }];
    
    UILabel *groupNum = [[UILabel alloc]init];
    [groupNum setText:[NSString stringWithFormat:@"(%@人)",self.connectionViewModel.connectionModel.totalCount.description]];
    [groupNum setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
    [groupNum setTextColor:XColorWithRGB(124, 124, 124)];
    [connecttionView addSubview:groupNum];
    [groupNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(mygroupImage);
        make.left.mas_equalTo(mygroupImage.mas_right).offset(AdaptationWidth(8));
    }];
    
    UIButton *allBtn = [[UIButton alloc]init];
    [allBtn setTitle:@"查看团员" forState:UIControlStateNormal];
    [allBtn setImage:[UIImage imageNamed:@"icon_vip_right"] forState:UIControlStateNormal];
    [allBtn setTitleColor:LabelAssistantColor forState:UIControlStateNormal];
    [allBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
    allBtn.imageEdgeInsets = UIEdgeInsetsMake(0, AdaptationWidth(58), 0, 0);
    allBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -AdaptationWidth(37), 0, 0);
    [allBtn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [connecttionView addSubview:allBtn];
    [allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(mygroupImage);
        make.right.mas_equalTo(connecttionView).offset(AdaptationWidth(-18));
    }];
    
    UILabel *straightNum = [[UILabel alloc]init];
    straightNum.textAlignment = NSTextAlignmentCenter;
    [straightNum setBorderWidth:1 andColor:XColorWithRGB(95, 118, 159)];
    [straightNum setCornerValue:4];
    [straightNum setText:[NSString stringWithFormat:@"直推人脉%@人",self.connectionViewModel.connectionModel.firstConnectionsCount.description]];
    [straightNum setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
    [straightNum setTextColor:XColorWithRGB(95, 118, 159)];
    [connecttionView addSubview:straightNum];
    [straightNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(connecttionView).offset(AdaptationWidth(-10));
        make.left.mas_equalTo(connecttionView).offset(AdaptationWidth(18));
        make.width.mas_equalTo(AdaptationWidth(100));
        make.height.mas_equalTo(AdaptationWidth(22));
    }];
    
    UILabel *commonNum = [[UILabel alloc]init];
    commonNum.textAlignment = NSTextAlignmentCenter;
    [commonNum setBorderWidth:1 andColor:XColorWithRGB(150, 150, 150)];
    [commonNum setCornerValue:4];
    [commonNum setText:[NSString stringWithFormat:@"普通人脉%@人",self.connectionViewModel.connectionModel.secondConnectionsCount.description]];
    [commonNum setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
    [commonNum setTextColor:XColorWithRGB(150, 150, 150)];
    [connecttionView addSubview:commonNum];
    [commonNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(straightNum);
        make.left.mas_equalTo(straightNum.mas_right).offset(AdaptationWidth(8));
        make.width.mas_equalTo(AdaptationWidth(100));
        make.height.mas_equalTo(AdaptationWidth(22));
    }];

    if (self.myViewModel.myModel.memberType.integerValue == 1) {
        UIImageView *vipNoImage = [[UIImageView alloc]init];
        [vipNoImage setImage:[UIImage imageNamed:@"icon_vip_notext"]];
        [view addSubview:vipNoImage];
        [vipNoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(view).offset(AdaptationWidth(119));
            make.top.mas_equalTo(connecttionView.mas_bottom).offset(AdaptationWidth(25));
            make.width.mas_equalTo(AdaptationWidth(35));
            make.height.mas_equalTo(AdaptationWidth(21));
            
        }];
        UILabel *vipNoLab = [[UILabel alloc]init];
        [vipNoLab setText:[NSString stringWithFormat:@"普通会员权益"]];
        [vipNoLab setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
        [vipNoLab setTextColor:XColorWithRGB(124, 124, 124)];
        [view addSubview:vipNoLab];
        [vipNoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(vipNoImage);
            make.left.mas_equalTo(vipNoImage.mas_right).offset(AdaptationWidth(2));
        }];
        //1
        UIView *vipNoView1 = [[UIView alloc]init];
        vipNoView1.backgroundColor = [UIColor whiteColor];
        [vipNoView1 setBorderWidth:1 andColor:XColorWithRGB(200, 200, 200)];
        [vipNoView1 setCornerValue:AdaptationWidth(6)];
        [view addSubview:vipNoView1];
        [vipNoView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(vipNoImage.mas_bottom).offset(AdaptationWidth(15));
            make.width.mas_equalTo(AdaptationWidth(110));
            make.height.mas_equalTo(AdaptationWidth(136));
            make.left.mas_equalTo(view).offset(AdaptationWidth(14));
        }];
        
        UIImageView *youhuiImage = [[UIImageView alloc]init];
        [youhuiImage setImage:[UIImage imageNamed:@"icon_vip_youhui"]];
        [vipNoView1 addSubview:youhuiImage];
        [youhuiImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(vipNoView1);
            make.top.mas_equalTo(vipNoView1).offset(AdaptationWidth(7));
            
        }];
        
        UILabel *youhuiLab = [[UILabel alloc]init];
        [youhuiLab setText:[NSString stringWithFormat:@"优惠券"]];
        [youhuiLab setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
        [youhuiLab setTextColor:LabelMainColor];
        [vipNoView1 addSubview:youhuiLab];
        [youhuiLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(vipNoView1);
            make.top.mas_equalTo(youhuiImage.mas_bottom).offset(AdaptationWidth(2));
        }];
        
        UILabel *youhuiDetail = [[UILabel alloc]init];
        youhuiDetail.numberOfLines = 0;
        [youhuiDetail setText:[NSString stringWithFormat:@"领取海量优惠券，自购省钱"]];
        [youhuiDetail setFont:[UIFont systemFontOfSize:AdaptationWidth(12)]];
        [youhuiDetail setTextColor:XColorWithRGB(124, 124, 124)];
        [vipNoView1 addSubview:youhuiDetail];
        [youhuiDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(vipNoView1).offset(AdaptationWidth(10));
            make.right.mas_equalTo(vipNoView1).offset(AdaptationWidth(-10));
            make.bottom.mas_equalTo(vipNoView1).offset(AdaptationWidth(-10));
            make.top.mas_equalTo(youhuiLab.mas_bottom).offset(AdaptationWidth(4));
        }];
        
        //2
        UIView *vipNoView2 = [[UIView alloc]init];
        vipNoView2.backgroundColor = [UIColor whiteColor];
        [vipNoView2 setBorderWidth:1 andColor:XColorWithRGB(200, 200, 200)];
        [vipNoView2 setCornerValue:AdaptationWidth(6)];
        [view addSubview:vipNoView2];
        [vipNoView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(vipNoImage.mas_bottom).offset(AdaptationWidth(15));
            make.width.mas_equalTo(AdaptationWidth(110));
            make.height.mas_equalTo(AdaptationWidth(136));
            make.centerX.mas_equalTo(view);
        }];
        
        UIImageView *fanyongImage = [[UIImageView alloc]init];
        [fanyongImage setImage:[UIImage imageNamed:@"icon_vip_fanyong"]];
        [vipNoView2 addSubview:fanyongImage];
        [fanyongImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(vipNoView2);
            make.top.mas_equalTo(vipNoView2).offset(AdaptationWidth(7));
            
        }];
        
        UILabel *fanyongLab = [[UILabel alloc]init];
        [fanyongLab setText:[NSString stringWithFormat:@"购买返佣"]];
        [fanyongLab setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
        [fanyongLab setTextColor:LabelMainColor];
        [vipNoView2 addSubview:fanyongLab];
        [fanyongLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(vipNoView2);
            make.top.mas_equalTo(fanyongImage.mas_bottom).offset(AdaptationWidth(2));
        }];
        
        UILabel *fanyongDetail = [[UILabel alloc]init];
        fanyongDetail.numberOfLines = 0;
        [fanyongDetail setText:[NSString stringWithFormat:@"领券购买后，还可以额外获得一笔返佣"]];
        [fanyongDetail setFont:[UIFont systemFontOfSize:AdaptationWidth(12)]];
        [fanyongDetail setTextColor:XColorWithRGB(124, 124, 124)];
        [vipNoView2 addSubview:fanyongDetail];
        [fanyongDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(vipNoView2).offset(AdaptationWidth(10));
            make.right.mas_equalTo(vipNoView2).offset(AdaptationWidth(-10));
            make.bottom.mas_equalTo(vipNoView2).offset(AdaptationWidth(-10));
            make.top.mas_equalTo(fanyongLab.mas_bottom).offset(AdaptationWidth(4));
        }];
        
        //3
        UIView *vipNoView3 = [[UIView alloc]init];
        vipNoView3.backgroundColor = [UIColor whiteColor];
        [vipNoView3 setBorderWidth:1 andColor:XColorWithRGB(200, 200, 200)];
        [vipNoView3 setCornerValue:AdaptationWidth(6)];
        [view addSubview:vipNoView3];
        [vipNoView3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(vipNoImage.mas_bottom).offset(AdaptationWidth(15));
            make.width.mas_equalTo(AdaptationWidth(110));
            make.height.mas_equalTo(AdaptationWidth(136));
            make.right.mas_equalTo(view).offset(AdaptationWidth(-14));
        }];
        
        UIImageView *shouyiImage = [[UIImageView alloc]init];
        [shouyiImage setImage:[UIImage imageNamed:@"icon_vip_shouyi"]];
        [vipNoView3 addSubview:shouyiImage];
        [shouyiImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(vipNoView3);
            make.top.mas_equalTo(vipNoView3).offset(AdaptationWidth(7));
            
        }];
        
        UILabel *shouyiLab = [[UILabel alloc]init];
        [shouyiLab setText:[NSString stringWithFormat:@"品牌活动收益"]];
        [shouyiLab setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
        [shouyiLab setTextColor:LabelMainColor];
        [vipNoView3 addSubview:shouyiLab];
        [shouyiLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(vipNoView3);
            make.top.mas_equalTo(shouyiImage.mas_bottom).offset(AdaptationWidth(2));
        }];
        
        UILabel *shouyiDetail = [[UILabel alloc]init];
        shouyiDetail.numberOfLines = 0;
        [shouyiDetail setText:[NSString stringWithFormat:@"参加品牌超值活动，高额收益轻松赚"]];
        [shouyiDetail setFont:[UIFont systemFontOfSize:AdaptationWidth(12)]];
        [shouyiDetail setTextColor:XColorWithRGB(124, 124, 124)];
        [vipNoView3 addSubview:shouyiDetail];
        [shouyiDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(vipNoView3).offset(AdaptationWidth(10));
            make.right.mas_equalTo(vipNoView3).offset(AdaptationWidth(-10));
            make.bottom.mas_equalTo(vipNoView3).offset(AdaptationWidth(-10));
            make.top.mas_equalTo(shouyiLab.mas_bottom).offset(AdaptationWidth(4));
        }];
    //vip
        UIImageView *vipNImage = [[UIImageView alloc]init];
        [vipNImage setImage:[UIImage imageNamed:@"icon_vip_text"]];
        [view addSubview:vipNImage];
        [vipNImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(view).offset(AdaptationWidth(119));
            make.top.mas_equalTo(connecttionView.mas_bottom).offset(AdaptationWidth(215));
            make.width.mas_equalTo(AdaptationWidth(35));
            make.height.mas_equalTo(AdaptationWidth(21));
            
        }];
        UILabel *vipLab = [[UILabel alloc]init];
        [vipLab setText:[NSString stringWithFormat:@"值享VIP权益"]];
        [vipLab setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
        [vipLab setTextColor:XColorWithRGB(216, 140, 16)];
        [view addSubview:vipLab];
        [vipLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(vipNImage);
            make.left.mas_equalTo(vipNImage.mas_right).offset(AdaptationWidth(2));
        }];
        //1
        UIView *vipView1 = [[UIView alloc]init];
        vipView1.backgroundColor = [UIColor whiteColor];
        [vipView1 setBorderWidth:1 andColor:XColorWithRGB(255 , 199, 108)];
        [vipView1 setCornerValue:AdaptationWidth(6)];
        [view addSubview:vipView1];
        [vipView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(vipNImage.mas_bottom).offset(AdaptationWidth(15));
            make.width.mas_equalTo(AdaptationWidth(168));
            make.height.mas_equalTo(AdaptationWidth(184));
            make.left.mas_equalTo(view).offset(AdaptationWidth(14));
        }];
        UIImageView *v1biaoImage = [[UIImageView alloc]init];
        [v1biaoImage setImage:[UIImage imageNamed:@"icon_vip_biao"]];
        [vipView1 addSubview:v1biaoImage];
        [v1biaoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(AdaptationWidth(55));
            make.top.left.mas_equalTo(vipView1);
            
        }];
        UIImageView *renmaiImage = [[UIImageView alloc]init];
        [renmaiImage setImage:[UIImage imageNamed:@"icon_vip_connect"]];
        [vipView1 addSubview:renmaiImage];
        [renmaiImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(vipView1);
            make.top.mas_equalTo(vipView1).offset(AdaptationWidth(7));
            
        }];
        
        UILabel *renmaiLab = [[UILabel alloc]init];
        [renmaiLab setText:[NSString stringWithFormat:@"人脉收益"]];
        [renmaiLab setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
        [renmaiLab setTextColor:XColorWithRGB(216, 140, 16)];
        [vipView1 addSubview:renmaiLab];
        [renmaiLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(vipView1);
            make.top.mas_equalTo(renmaiImage.mas_bottom).offset(AdaptationWidth(2));
        }];
        
        UILabel *renmaiDetail = [[UILabel alloc]init];
        renmaiDetail.numberOfLines = 0;
        [renmaiDetail setText:[NSString stringWithFormat:@"您的团员每一次购买商品/参与品牌活动，您都可以获得收益，团员越多，收益越多"]];
        [renmaiDetail setFont:[UIFont systemFontOfSize:AdaptationWidth(12)]];
        [renmaiDetail setTextColor:XColorWithRGB(124, 124, 124)];
        [vipView1 addSubview:renmaiDetail];
        [renmaiDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(vipView1).offset(AdaptationWidth(10));
            make.right.mas_equalTo(vipView1).offset(AdaptationWidth(-10));
            make.bottom.mas_equalTo(vipView1).offset(AdaptationWidth(-10));
            make.top.mas_equalTo(renmaiLab.mas_bottom).offset(AdaptationWidth(4));
        }];
        
        //2
        UIView *vipView2 = [[UIView alloc]init];
        vipView2.backgroundColor = [UIColor whiteColor];
        [vipView2 setBorderWidth:1 andColor:XColorWithRGB(255 , 199, 108)];
        [vipView2 setCornerValue:AdaptationWidth(6)];
        [view addSubview:vipView2];
        [vipView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(vipNImage.mas_bottom).offset(AdaptationWidth(15));
            make.width.mas_equalTo(AdaptationWidth(168));
            make.height.mas_equalTo(AdaptationWidth(184));
            make.right.mas_equalTo(view).offset(AdaptationWidth(-14));
        }];
        UIImageView *v2biaoImage = [[UIImageView alloc]init];
        [v2biaoImage setImage:[UIImage imageNamed:@"icon_vip_biao"]];
        [vipView2 addSubview:v2biaoImage];
        [v2biaoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(AdaptationWidth(55));
            make.top.left.mas_equalTo(vipView2);
            
        }];
        UIImageView *shareImage = [[UIImageView alloc]init];
        [shareImage setImage:[UIImage imageNamed:@"icon_vip_profit"]];
        [vipView2 addSubview:shareImage];
        [shareImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(vipView2);
            make.top.mas_equalTo(vipView2).offset(AdaptationWidth(7));
            
        }];
        
        UILabel *shareLab = [[UILabel alloc]init];
        [shareLab setText:[NSString stringWithFormat:@"分享收益"]];
        [shareLab setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
        [shareLab setTextColor:XColorWithRGB(216, 140, 16)];
        [vipView2 addSubview:shareLab];
        [shareLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(vipView2);
            make.top.mas_equalTo(shareImage.mas_bottom).offset(AdaptationWidth(2));
        }];
        
        UILabel *shareDetail = [[UILabel alloc]init];
        shareDetail.numberOfLines = 0;
        [shareDetail setText:[NSString stringWithFormat:@"您可分享商品/品牌活动给任何人，无论对方是否为你的团队成员，您都可以获得分享收益"]];
        [shareDetail setFont:[UIFont systemFontOfSize:AdaptationWidth(12)]];
        [shareDetail setTextColor:XColorWithRGB(124, 124, 124)];
        [vipView2 addSubview:shareDetail];
        [shareDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(vipView2).offset(AdaptationWidth(10));
            make.right.mas_equalTo(vipView2).offset(AdaptationWidth(-10));
            make.bottom.mas_equalTo(vipView2).offset(AdaptationWidth(-10));
            make.top.mas_equalTo(shareLab.mas_bottom).offset(AdaptationWidth(4));
        }];
        
        UIImageView *firstImage = [[UIImageView alloc]init];
        [firstImage setImage:[UIImage imageNamed:@"icon_vip_first"]];
        [view addSubview:firstImage];
        [firstImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(view).offset(AdaptationWidth(14));
            make.top.mas_equalTo(vipView1.mas_bottom).offset(AdaptationWidth(30));
            
        }];
        
        UILabel *payDetail = [[UILabel alloc]init];
        [payDetail setText:[NSString stringWithFormat:@"单次消费>%.2f元，即可获取值享VIP",[self.singleConsume doubleValue]/100]];
        [payDetail setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
        [payDetail setTextColor:LabelMainColor];
        [view addSubview:payDetail];
        [payDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(view).offset(AdaptationWidth(14));
            make.top.mas_equalTo(firstImage.mas_bottom).offset(AdaptationWidth(14));
        }];
        
        UIImageView *secondImage = [[UIImageView alloc]init];
        [secondImage setImage:[UIImage imageNamed:@"icon_vip_second"]];
        [view addSubview:secondImage];
        [secondImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(view).offset(AdaptationWidth(14));
            make.top.mas_equalTo(payDetail.mas_bottom).offset(AdaptationWidth(20));
            
        }];
        
    }else{
        //1
        UIView *vipView1 = [[UIView alloc]init];
        vipView1.backgroundColor = [UIColor whiteColor];
//        [vipView1 setBorderWidth:1 andColor:XColorWithRGB(255 , 199, 108)];
        [vipView1 setCornerValue:AdaptationWidth(8)];
        [view addSubview:vipView1];
        [vipView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(connecttionView.mas_bottom).offset(AdaptationWidth(15));
            make.width.mas_equalTo(AdaptationWidth(347));
            make.height.mas_equalTo(AdaptationWidth(100));
            make.centerX.mas_equalTo(view);
        }];
        
        UIImageView *mysyImage = [[UIImageView alloc]init];
        [mysyImage setImage:[UIImage imageNamed:@"icon_vip_mysy"]];
        [vipView1 addSubview:mysyImage];
        [mysyImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(vipView1);
            make.width.mas_equalTo(AdaptationWidth(100));
            make.height.mas_equalTo(AdaptationWidth(25));
            
        }];
        
        UILabel *totalSY = [[UILabel alloc]init];
        [totalSY setText:[NSString stringWithFormat:@"%.2f元",[self.connectionViewModel.connectionModel.profitAmt doubleValue]/100]];
        [totalSY setFont:[UIFont systemFontOfSize:AdaptationWidth(18)]];
        [totalSY setTextColor:RedColor];
        [vipView1 addSubview:totalSY];
        [totalSY mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(vipView1).multipliedBy(0.5);
            make.top.mas_equalTo(vipView1).offset(AdaptationWidth(39));
        }];
        UILabel *totalSYLab = [[UILabel alloc]init];
        [totalSYLab setText:[NSString stringWithFormat:@"累计人脉收益"]];
        [totalSYLab setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
        [totalSYLab setTextColor:XColorWithRGB(181, 181, 181)];
        [vipView1 addSubview:totalSYLab];
        [totalSYLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(totalSY);
            make.top.mas_equalTo(totalSY.mas_bottom).offset(AdaptationWidth(5));
        }];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = XColorWithRGB(229, 229, 229);
        [vipView1 addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(AdaptationWidth(1));
            make.height.mas_equalTo(AdaptationWidth(40));
            make.center.mas_equalTo(vipView1);
        }];
        
        
        UILabel *weekSY = [[UILabel alloc]init];
        [weekSY setText:[NSString stringWithFormat:@"%.2f元",[self.connectionViewModel.connectionModel.connectionProfitAmtOfThisWeek doubleValue]/100]];
        [weekSY setFont:[UIFont systemFontOfSize:AdaptationWidth(18)]];
        [weekSY setTextColor:RedColor];
        [vipView1 addSubview:weekSY];
        [weekSY mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(vipView1).multipliedBy(1.5);
            make.top.mas_equalTo(vipView1).offset(AdaptationWidth(39));
        }];
        UILabel *weekSYLab = [[UILabel alloc]init];
        [weekSYLab setText:[NSString stringWithFormat:@"本周人脉收益"]];
        [weekSYLab setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
        [weekSYLab setTextColor:XColorWithRGB(181, 181, 181)];
        [vipView1 addSubview:weekSYLab];
        [weekSYLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weekSY);
            make.top.mas_equalTo(weekSY.mas_bottom).offset(AdaptationWidth(5));
        }];
        
        //2
        UIView *vipView2 = [[UIView alloc]init];
        vipView2.backgroundColor = [UIColor whiteColor];
        //        [vipView1 setBorderWidth:1 andColor:XColorWithRGB(255 , 199, 108)];
        [vipView2 setCornerValue:AdaptationWidth(8)];
        [view addSubview:vipView2];
        [vipView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(vipView1.mas_bottom).offset(AdaptationWidth(15));
            make.width.mas_equalTo(AdaptationWidth(347));
            make.height.mas_equalTo(AdaptationWidth(100));
            make.centerX.mas_equalTo(view);
        }];
        
        UIImageView *weekImage = [[UIImageView alloc]init];
        [weekImage setImage:[UIImage imageNamed:@"icon_vip_week"]];
        [vipView2 addSubview:weekImage];
        [weekImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(vipView2);
            make.width.mas_equalTo(AdaptationWidth(100));
            make.height.mas_equalTo(AdaptationWidth(25));
            
        }];
        
        UILabel *firstNum = [[UILabel alloc]init];
        firstNum.textAlignment = NSTextAlignmentCenter;
        [firstNum setBorderWidth:1 andColor:XColorWithRGB(95, 118, 159)];
        [firstNum setCornerValue:4];
        [firstNum setText:[NSString stringWithFormat:@"直推人脉"]];
        [firstNum setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
        [firstNum setTextColor:XColorWithRGB(95, 118, 159)];
        [vipView2 addSubview:firstNum];
        [firstNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(vipView2).multipliedBy(0.5);
            make.top.mas_equalTo(vipView2).offset(AdaptationWidth(59));
            make.width.mas_equalTo(AdaptationWidth(91));
            make.height.mas_equalTo(AdaptationWidth(22));
        }];
        
        UIButton *fitstBtn = [[UIButton alloc]init];
        [fitstBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
        [fitstBtn setTitleColor:XColorWithRGB(133, 97, 24) forState:UIControlStateNormal];
        [fitstBtn setTitle:[NSString stringWithFormat:@"+%@人",self.connectionViewModel.connectionModel.firstConnectionsCountOfThisWeek.description] forState:UIControlStateNormal];
        [fitstBtn setBackgroundImage:[UIImage imageNamed:@"icon_vip_firstBtn"] forState:UIControlStateNormal];
        [vipView2 addSubview:fitstBtn];
        [fitstBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(vipView2).offset(AdaptationWidth(115));
            make.top.mas_equalTo(vipView2).offset(AdaptationWidth(44));
        }];
        
        UILabel *secondNum = [[UILabel alloc]init];
        secondNum.textAlignment = NSTextAlignmentCenter;
        [secondNum setBorderWidth:1 andColor:XColorWithRGB(95, 118, 159)];
        [secondNum setCornerValue:4];
        [secondNum setText:[NSString stringWithFormat:@"普通人脉"]];
        [secondNum setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
        [secondNum setTextColor:XColorWithRGB(95, 118, 159)];
        [vipView2 addSubview:secondNum];
        [secondNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(vipView2).multipliedBy(1.5);
            make.top.mas_equalTo(vipView2).offset(AdaptationWidth(59));
            make.width.mas_equalTo(AdaptationWidth(91));
            make.height.mas_equalTo(AdaptationWidth(22));
        }];
        
        UIButton *secondBtn = [[UIButton alloc]init];
        [secondBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
//        [secondBtn setTitleColor:XColorWithRGB(133, 97, 24) forState:UIControlStateNormal];
        [secondBtn setTitle:[NSString stringWithFormat:@"+%@人",self.connectionViewModel.connectionModel.secondConnectionsCountOfThisWeek.description] forState:UIControlStateNormal];
        [secondBtn setBackgroundImage:[UIImage imageNamed:@"icon_vip_secondBtn"] forState:UIControlStateNormal];
        [vipView2 addSubview:secondBtn];
        [secondBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(vipView2).offset(AdaptationWidth(-15));
            make.top.mas_equalTo(vipView2).offset(AdaptationWidth(44));
        }];
        
        //3
        UIView *vipView3 = [[UIView alloc]init];
        vipView3.backgroundColor = XColorWithRGB(255, 237, 204);
        //        [vipView1 setBorderWidth:1 andColor:XColorWithRGB(255 , 199, 108)];
        [vipView3 setCornerValue:AdaptationWidth(8)];
        [view addSubview:vipView3];
        [vipView3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(vipView2.mas_bottom).offset(AdaptationWidth(15));
            make.width.mas_equalTo(AdaptationWidth(347));
            make.height.mas_equalTo(AdaptationWidth(80));
            make.centerX.mas_equalTo(view);
        }];
        
        UILabel *v3lab1 = [[UILabel alloc]init];
        [v3lab1 setText:[NSString stringWithFormat:@"团员越多"]];
        [v3lab1 setFont:[UIFont systemFontOfSize:AdaptationWidth(18)]];
        [v3lab1 setTextColor:XColorWithRGB(79, 79, 79)];
        [vipView3 addSubview:v3lab1];
        [v3lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(vipView3).offset(AdaptationWidth(16));
            make.top.mas_equalTo(vipView3).offset(AdaptationWidth(15));
        }];
        
        UILabel *v3lab2 = [[UILabel alloc]init];
        [v3lab2 setText:[NSString stringWithFormat:@"收益越多"]];
        [v3lab2 setFont:[UIFont systemFontOfSize:AdaptationWidth(18)]];
        [v3lab2 setTextColor:XColorWithRGB(255, 157, 0)];
        [vipView3 addSubview:v3lab2];
        [v3lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(v3lab1.mas_right).offset(AdaptationWidth(5));
            make.top.mas_equalTo(vipView3).offset(AdaptationWidth(15));
        }];
        
        UILabel *v3lab3 = [[UILabel alloc]init];
        [v3lab3 setText:[NSString stringWithFormat:@"快去分享活动/商品吧～"]];
        [v3lab3 setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
        [v3lab3 setTextColor:XColorWithRGB(156, 156, 156)];
        [vipView3 addSubview:v3lab3];
        [v3lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(vipView3).offset(AdaptationWidth(16));
            make.top.mas_equalTo(v3lab1.mas_bottom).offset(AdaptationWidth(5));
        }];
        
        UIImageView *v3Image = [[UIImageView alloc]init];
        [v3Image setImage:[UIImage imageNamed:@"icon_vip_v3"]];
        [vipView3 addSubview:v3Image];
        [v3Image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(vipView3).offset(AdaptationWidth(10));
            make.width.mas_equalTo(AdaptationWidth(91));
            make.height.mas_equalTo(AdaptationWidth(72));
            make.bottom.mas_equalTo(vipView3);
            
        }];
        
        //4
        UIImageView *vipNoImage = [[UIImageView alloc]init];
        [vipNoImage setImage:[UIImage imageNamed:@"icon_vip_text"]];
        [view addSubview:vipNoImage];
        [vipNoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(view).offset(AdaptationWidth(134));
            make.top.mas_equalTo(vipView3.mas_bottom).offset(AdaptationWidth(25));
            make.width.mas_equalTo(AdaptationWidth(35));
            make.height.mas_equalTo(AdaptationWidth(21));

        }];
        UILabel *vipNoLab = [[UILabel alloc]init];
        [vipNoLab setText:[NSString stringWithFormat:@"当前权益"]];
        [vipNoLab setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
        [vipNoLab setTextColor:XColorWithRGB(216, 140, 16)];
        [view addSubview:vipNoLab];
        [vipNoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(vipNoImage);
            make.left.mas_equalTo(vipNoImage.mas_right).offset(AdaptationWidth(2));
        }];

        //1
        UIView *vipNoView1 = [[UIView alloc]init];
        vipNoView1.backgroundColor = [UIColor whiteColor];
        [vipNoView1 setBorderWidth:1 andColor:XColorWithRGB(200, 200, 200)];
        [vipNoView1 setCornerValue:AdaptationWidth(6)];
        [view addSubview:vipNoView1];
        [vipNoView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(vipNoImage.mas_bottom).offset(AdaptationWidth(15));
            make.width.mas_equalTo(AdaptationWidth(110));
            make.height.mas_equalTo(AdaptationWidth(136));
            make.left.mas_equalTo(view).offset(AdaptationWidth(14));
        }];

        UIImageView *youhuiImage = [[UIImageView alloc]init];
        [youhuiImage setImage:[UIImage imageNamed:@"icon_vip_youhui"]];
        [vipNoView1 addSubview:youhuiImage];
        [youhuiImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(vipNoView1);
            make.top.mas_equalTo(vipNoView1).offset(AdaptationWidth(7));

        }];

        UILabel *youhuiLab = [[UILabel alloc]init];
        [youhuiLab setText:[NSString stringWithFormat:@"优惠券"]];
        [youhuiLab setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
        [youhuiLab setTextColor:LabelMainColor];
        [vipNoView1 addSubview:youhuiLab];
        [youhuiLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(vipNoView1);
            make.top.mas_equalTo(youhuiImage.mas_bottom).offset(AdaptationWidth(2));
        }];

        UILabel *youhuiDetail = [[UILabel alloc]init];
        youhuiDetail.numberOfLines = 0;
        [youhuiDetail setText:[NSString stringWithFormat:@"领取海量优惠券，自购省钱"]];
        [youhuiDetail setFont:[UIFont systemFontOfSize:AdaptationWidth(12)]];
        [youhuiDetail setTextColor:XColorWithRGB(124, 124, 124)];
        [vipNoView1 addSubview:youhuiDetail];
        [youhuiDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(vipNoView1).offset(AdaptationWidth(10));
            make.right.mas_equalTo(vipNoView1).offset(AdaptationWidth(-10));
            make.bottom.mas_equalTo(vipNoView1).offset(AdaptationWidth(-10));
            make.top.mas_equalTo(youhuiLab.mas_bottom).offset(AdaptationWidth(4));
        }];

        //2
        UIView *vipNoView2 = [[UIView alloc]init];
        vipNoView2.backgroundColor = [UIColor whiteColor];
        [vipNoView2 setBorderWidth:1 andColor:XColorWithRGB(200, 200, 200)];
        [vipNoView2 setCornerValue:AdaptationWidth(6)];
        [view addSubview:vipNoView2];
        [vipNoView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(vipNoImage.mas_bottom).offset(AdaptationWidth(15));
            make.width.mas_equalTo(AdaptationWidth(110));
            make.height.mas_equalTo(AdaptationWidth(136));
            make.centerX.mas_equalTo(view);
        }];

        UIImageView *fanyongImage = [[UIImageView alloc]init];
        [fanyongImage setImage:[UIImage imageNamed:@"icon_vip_fanyong"]];
        [vipNoView2 addSubview:fanyongImage];
        [fanyongImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(vipNoView2);
            make.top.mas_equalTo(vipNoView2).offset(AdaptationWidth(7));

        }];

        UILabel *fanyongLab = [[UILabel alloc]init];
        [fanyongLab setText:[NSString stringWithFormat:@"购买返佣"]];
        [fanyongLab setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
        [fanyongLab setTextColor:LabelMainColor];
        [vipNoView2 addSubview:fanyongLab];
        [fanyongLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(vipNoView2);
            make.top.mas_equalTo(fanyongImage.mas_bottom).offset(AdaptationWidth(2));
        }];

        UILabel *fanyongDetail = [[UILabel alloc]init];
        fanyongDetail.numberOfLines = 0;
        [fanyongDetail setText:[NSString stringWithFormat:@"领券购买后，还可以额外获得一笔返佣"]];
        [fanyongDetail setFont:[UIFont systemFontOfSize:AdaptationWidth(12)]];
        [fanyongDetail setTextColor:XColorWithRGB(124, 124, 124)];
        [vipNoView2 addSubview:fanyongDetail];
        [fanyongDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(vipNoView2).offset(AdaptationWidth(10));
            make.right.mas_equalTo(vipNoView2).offset(AdaptationWidth(-10));
            make.bottom.mas_equalTo(vipNoView2).offset(AdaptationWidth(-10));
            make.top.mas_equalTo(fanyongLab.mas_bottom).offset(AdaptationWidth(4));
        }];

        //3
        UIView *vipNoView3 = [[UIView alloc]init];
        vipNoView3.backgroundColor = [UIColor whiteColor];
        [vipNoView3 setBorderWidth:1 andColor:XColorWithRGB(200, 200, 200)];
        [vipNoView3 setCornerValue:AdaptationWidth(6)];
        [view addSubview:vipNoView3];
        [vipNoView3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(vipNoImage.mas_bottom).offset(AdaptationWidth(15));
            make.width.mas_equalTo(AdaptationWidth(110));
            make.height.mas_equalTo(AdaptationWidth(136));
            make.right.mas_equalTo(view).offset(AdaptationWidth(-14));
        }];

        UIImageView *shouyiImage = [[UIImageView alloc]init];
        [shouyiImage setImage:[UIImage imageNamed:@"icon_vip_shouyi"]];
        [vipNoView3 addSubview:shouyiImage];
        [shouyiImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(vipNoView3);
            make.top.mas_equalTo(vipNoView3).offset(AdaptationWidth(7));

        }];

        UILabel *shouyiLab = [[UILabel alloc]init];
        [shouyiLab setText:[NSString stringWithFormat:@"品牌活动收益"]];
        [shouyiLab setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
        [shouyiLab setTextColor:LabelMainColor];
        [vipNoView3 addSubview:shouyiLab];
        [shouyiLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(vipNoView3);
            make.top.mas_equalTo(shouyiImage.mas_bottom).offset(AdaptationWidth(2));
        }];

        UILabel *shouyiDetail = [[UILabel alloc]init];
        shouyiDetail.numberOfLines = 0;
        [shouyiDetail setText:[NSString stringWithFormat:@"参加品牌超值活动，高额收益轻松赚"]];
        [shouyiDetail setFont:[UIFont systemFontOfSize:AdaptationWidth(12)]];
        [shouyiDetail setTextColor:XColorWithRGB(124, 124, 124)];
        [vipNoView3 addSubview:shouyiDetail];
        [shouyiDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(vipNoView3).offset(AdaptationWidth(10));
            make.right.mas_equalTo(vipNoView3).offset(AdaptationWidth(-10));
            make.bottom.mas_equalTo(vipNoView3).offset(AdaptationWidth(-10));
            make.top.mas_equalTo(shouyiLab.mas_bottom).offset(AdaptationWidth(4));
        }];
        //vip
        
        //1
        UIView *vipV1 = [[UIView alloc]init];
        vipV1.backgroundColor = [UIColor whiteColor];
        [vipV1 setBorderWidth:1 andColor:XColorWithRGB(255 , 199, 108)];
        [vipV1 setCornerValue:AdaptationWidth(6)];
        [view addSubview:vipV1];
        [vipV1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(vipNoView3.mas_bottom).offset(AdaptationWidth(15));
            make.width.mas_equalTo(AdaptationWidth(168));
            make.height.mas_equalTo(AdaptationWidth(184));
            make.left.mas_equalTo(view).offset(AdaptationWidth(14));
        }];
        UIImageView *v1biaoImage = [[UIImageView alloc]init];
        [v1biaoImage setImage:[UIImage imageNamed:@"icon_vip_biao"]];
        [vipV1 addSubview:v1biaoImage];
        [v1biaoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(AdaptationWidth(55));
            make.top.left.mas_equalTo(vipV1);
            
        }];
        
        UIImageView *renmaiImage = [[UIImageView alloc]init];
        [renmaiImage setImage:[UIImage imageNamed:@"icon_vip_connect"]];
        [vipV1 addSubview:renmaiImage];
        [renmaiImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(vipV1);
            make.top.mas_equalTo(vipV1).offset(AdaptationWidth(7));

        }];

        UILabel *renmaiLab = [[UILabel alloc]init];
        [renmaiLab setText:[NSString stringWithFormat:@"人脉收益"]];
        [renmaiLab setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
        [renmaiLab setTextColor:XColorWithRGB(216, 140, 16)];
        [vipV1 addSubview:renmaiLab];
        [renmaiLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(vipV1);
            make.top.mas_equalTo(renmaiImage.mas_bottom).offset(AdaptationWidth(2));
        }];

        UILabel *renmaiDetail = [[UILabel alloc]init];
        renmaiDetail.numberOfLines = 0;
        [renmaiDetail setText:[NSString stringWithFormat:@"您的团员每一次购买商品/参与品牌活动，您都可以获得收益，团员越多，收益越多"]];
        [renmaiDetail setFont:[UIFont systemFontOfSize:AdaptationWidth(12)]];
        [renmaiDetail setTextColor:XColorWithRGB(124, 124, 124)];
        [vipV1 addSubview:renmaiDetail];
        [renmaiDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(vipV1).offset(AdaptationWidth(10));
            make.right.mas_equalTo(vipV1).offset(AdaptationWidth(-10));
            make.bottom.mas_equalTo(vipV1).offset(AdaptationWidth(-10));
            make.top.mas_equalTo(renmaiLab.mas_bottom).offset(AdaptationWidth(4));
        }];

        //2
        UIView *vipVi2 = [[UIView alloc]init];
        vipVi2.backgroundColor = [UIColor whiteColor];
        [vipVi2 setBorderWidth:1 andColor:XColorWithRGB(255 , 199, 108)];
        [vipVi2 setCornerValue:AdaptationWidth(6)];
        [view addSubview:vipVi2];
        [vipVi2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(vipNoView3.mas_bottom).offset(AdaptationWidth(15));
            make.width.mas_equalTo(AdaptationWidth(168));
            make.height.mas_equalTo(AdaptationWidth(184));
            make.right.mas_equalTo(view).offset(AdaptationWidth(-14));
        }];
        UIImageView *v2biaoImage = [[UIImageView alloc]init];
        [v2biaoImage setImage:[UIImage imageNamed:@"icon_vip_biao"]];
        [vipVi2 addSubview:v2biaoImage];
        [v2biaoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(AdaptationWidth(55));
            make.top.left.mas_equalTo(vipVi2);
            
        }];

        UIImageView *shareImage = [[UIImageView alloc]init];
        [shareImage setImage:[UIImage imageNamed:@"icon_vip_profit"]];
        [vipVi2 addSubview:shareImage];
        [shareImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(vipVi2);
            make.top.mas_equalTo(vipVi2).offset(AdaptationWidth(7));

        }];

        UILabel *shareLab = [[UILabel alloc]init];
        [shareLab setText:[NSString stringWithFormat:@"分享收益"]];
        [shareLab setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
        [shareLab setTextColor:XColorWithRGB(216, 140, 16)];
        [vipVi2 addSubview:shareLab];
        [shareLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(vipVi2);
            make.top.mas_equalTo(shareImage.mas_bottom).offset(AdaptationWidth(2));
        }];

        UILabel *shareDetail = [[UILabel alloc]init];
        shareDetail.numberOfLines = 0;
        [shareDetail setText:[NSString stringWithFormat:@"您可分享商品/品牌活动给任何人，无论对方是否为你的团队成员，您都可以获得分享收益"]];
        [shareDetail setFont:[UIFont systemFontOfSize:AdaptationWidth(12)]];
        [shareDetail setTextColor:XColorWithRGB(124, 124, 124)];
        [vipVi2 addSubview:shareDetail];
        [shareDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(vipVi2).offset(AdaptationWidth(10));
            make.right.mas_equalTo(vipVi2).offset(AdaptationWidth(-10));
            make.bottom.mas_equalTo(vipVi2).offset(AdaptationWidth(-10));
            make.top.mas_equalTo(shareLab.mas_bottom).offset(AdaptationWidth(4));
        }];
        
    }
    
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  self.myViewModel.myModel.memberType.integerValue == 1 ? AdaptationWidth(800) : AdaptationWidth(950);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptationWidth(68);
}
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *identifier = @"VipTableViewCell";
    
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSNumber *state = self.connectionViewModel.memberList[indexPath.row][@"hasDone"];
        NSNumber *taskCode = self.connectionViewModel.memberList[indexPath.row][@"taskCode"];
        UIImageView *cellImage = [[UIImageView alloc]init];
        [cellImage setImage:state.integerValue ? [UIImage imageNamed:@"icon_vip_vipState"] :[UIImage imageNamed:@"icon_vip_state"]];
        [cell.contentView addSubview:cellImage];
        [cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell).offset(AdaptationWidth(14));
            make.top.mas_equalTo(cell).offset(AdaptationWidth(18));
            make.width.height.mas_equalTo(AdaptationWidth(14));
        }];
        
        UILabel *celltitle = [[UILabel alloc]init];
        [celltitle setText:self.connectionViewModel.memberList[indexPath.row][@"name"]];
        [celltitle setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
        [celltitle setTextColor:LabelMainColor];
        [cell.contentView addSubview:celltitle];
        [celltitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cellImage.mas_right).offset(AdaptationWidth(5));
            make.centerY.mas_equalTo(cellImage);
        }];
        
        UILabel *cellDetail = [[UILabel alloc]init];
        [cellDetail setText:self.connectionViewModel.memberList[indexPath.row][@"desc"]];
        [cellDetail setFont:[UIFont systemFontOfSize:AdaptationWidth(12)]];
        [cellDetail setTextColor:XColorWithRGB(124, 124, 124)];
        [cell.contentView addSubview:cellDetail];
        [cellDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(celltitle);
            make.right.mas_equalTo(cell).offset(AdaptationWidth(-14));
            make.top.mas_equalTo(celltitle.mas_bottom).offset(AdaptationWidth(4));
        }];
        
        UILabel *cellState = [[UILabel alloc]init];
        cellState.hidden = state.integerValue ? YES : NO;
        [cellState setText:[NSString stringWithFormat:@"未完成"]];
        [cellState setFont:[UIFont systemFontOfSize:AdaptationWidth(12)]];
        [cellState setTextColor:XColorWithRGB(124, 124, 124)];
        [cell.contentView addSubview:cellState];
        [cellState mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cellImage);
            make.right.mas_equalTo(cell).offset(AdaptationWidth(-14));
            
        }];
        
        UIImageView *stateImage = [[UIImageView alloc]init];
        stateImage.hidden = state.integerValue ? NO : YES;
        [stateImage setImage:[UIImage imageNamed:@"icon_vip_finish"]];
        [cell.contentView addSubview:stateImage];
        [stateImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(cell).offset(AdaptationWidth(-14));
            make.centerY.mas_equalTo(cell);
            
        }];
        
        if (taskCode.integerValue == 104) {
            cellState.hidden = YES;
            UIButton *allBtn = [[UIButton alloc]init];
            [allBtn setTitle:@"立即邀请" forState:UIControlStateNormal];
            [allBtn setBackgroundImage:[UIImage imageNamed:@"icon_vip_xiao"] forState:UIControlStateNormal];
            [allBtn setTitleColor:XColorWithRGB(155, 104, 0) forState:UIControlStateNormal];
            [allBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(12)]];
            //        allBtn.imageEdgeInsets = UIEdgeInsetsMake(0, AdaptationWidth(58), 0, 0);
            allBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -AdaptationWidth(10), 0, 0);
            [allBtn addTarget:self action:@selector(btnOnClickXiao:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:allBtn];
            [allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(cell);
                make.right.mas_equalTo(cell).offset(AdaptationWidth(-18));
                make.width.mas_equalTo(AdaptationWidth(70));
            }];
            self.paramsExt = [ self.connectionViewModel.memberList[indexPath.row][@"paramsExt"] mj_JSONObject];
        }
    
    
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.myViewModel.myModel.memberType.integerValue == 1 ? self.connectionViewModel.memberList.count : 0;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)btnOnClick:(UIButton *)btn{
    MyConnectionVC *vc  =[[MyConnectionVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)btnOnClickXiao:(UIButton *)btn{
    if (![WXApi isWXAppInstalled]) {
        [ProgressHUD showProgressHUDInView:nil withText:@"未安装微信" afterDelay:1 ];
        return ;
    }
    //        小程序分享
    
    
    NSDictionary *dic = self.paramsExt;
    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:dic[@"imageUrl"]]];
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];

        
        [shareParams SSDKSetupWeChatMiniProgramShareParamsByTitle:dic[@"title"]
                                                      description:dic[@"title"]
                                                       webpageUrl:[NSURL URLWithString:dic[@"url"]]
                                                             path:dic[@"setWxPath"]
                                                       thumbImage:nil
                                                     hdThumbImage:[UIImage imageWithData:imgData]
                                                         userName:dic[@"setWxUserName"]
                                                  withShareTicket:YES
                                                  miniProgramType:[dic[@"type"] integerValue]
                                               forPlatformSubType:SSDKPlatformSubTypeWechatSession];
        [ShareSDK share:SSDKPlatformSubTypeWechatSession parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            [UserInfo sharedInstance].isAlertShare = YES;
            [[UserInfo sharedInstance]saveUserInfo:[UserInfo sharedInstance]];
            
        }];
}
#pragma mark - load
- (MyViewModel *)myViewModel{
    if (!_myViewModel) {
        _myViewModel = [[MyViewModel alloc]init];
    }
    return _myViewModel;
}
- (ConnectionViewModel *)connectionViewModel{
    if (!_connectionViewModel) {
        _connectionViewModel = [[ConnectionViewModel alloc]init];
    }
    return _connectionViewModel;
}
- (NSDictionary *)paramsExt{
    if (!_paramsExt) {
        _paramsExt = [NSDictionary dictionary];
    }
    return _paramsExt;
}
- (UnLoginView *)unLoginView{
    if (!_unLoginView) {
        _unLoginView = [[NSBundle mainBundle]loadNibNamed:@"UnLogin" owner:nil options:nil].lastObject;
        [self.view addSubview: _unLoginView];
        [_unLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
        _unLoginView.hidden = NO;
    }
    return _unLoginView;
}
@end

