//
//  ExpectVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/27.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "ExpectVC.h"
#import "ExpectTableView.h"
@interface ExpectVC ()<UIScrollViewDelegate>
@property (nonatomic ,strong) UIScrollView *scrollView;
@property (nonatomic ,strong) ExpectTableView *taskTableView;
@property (nonatomic ,strong) ExpectTableView *shareTableView;
@property (nonatomic ,strong) ExpectTableView *connectionTableView;
@end

@implementation ExpectVC
{
    UIButton *btn1,*btn2,*btn3;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

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
    [loginLab1 setText:@"到账总收益(元)"];
    [loginLab1 setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
    [loginLab1 setTextColor:[UIColor whiteColor]];
    [self.view addSubview:loginLab1];
    [loginLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(AdaptationWidth(77));
    }];
    
    UILabel *loginLab2 = [[UILabel alloc]init];
    [loginLab2 setText:[NSString stringWithFormat:@"%.2f",[@1 doubleValue]/100]];
    [loginLab2 setFont:[UIFont fontWithName:@"PingFangSC-Bold" size:AdaptationWidth(24)]];
    [loginLab2 setTextColor:LabelMainColor];
    [self.view addSubview:loginLab2];
    [loginLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(loginLab1.mas_bottom).offset(AdaptationWidth(2));
    }];
    
    UIButton *balckBtn = [[UIButton alloc]init];
    balckBtn.tag = 4411;
    [balckBtn setImage:[UIImage imageNamed:@"icon_back-white"] forState:UIControlStateNormal];
    [balckBtn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:balckBtn];
    [balckBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(30);
        make.left.mas_equalTo(self.view).offset(20);
        make.height.width.mas_equalTo(AdaptationWidth(40));
    }];
    //
    UIButton *taskBtn = [[UIButton alloc]init];
    taskBtn.tag = 4412;
    taskBtn.selected = YES;
    [taskBtn setTitle:@"任务收益" forState:UIControlStateNormal];
    [taskBtn setTitleColor:LabelAssistantColor forState:UIControlStateNormal];
    [taskBtn setTitleColor:XColorWithRGB(56, 181, 173) forState:UIControlStateSelected];
    [taskBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
    [taskBtn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn1 = taskBtn;
    [self.view addSubview:taskBtn];
    [taskBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headerImage.mas_bottom).offset(AdaptationWidth(18));
        make.centerX.mas_equalTo(self.view).multipliedBy(0.5);
    }];
    
    UIButton *shareBtn = [[UIButton alloc]init];
    shareBtn.tag = 4413;
    [shareBtn setTitle:@"分享收益" forState:UIControlStateNormal];
    [shareBtn setTitleColor:XColorWithRGB(255, 188, 0) forState:UIControlStateSelected];
    [shareBtn setTitleColor:LabelAssistantColor forState:UIControlStateNormal];
    [shareBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
    [shareBtn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn2 = shareBtn;
    [self.view addSubview:shareBtn];
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headerImage.mas_bottom).offset(AdaptationWidth(18));
        make.centerX.mas_equalTo(self.view).multipliedBy(1);
    }];
    
    UIButton *connectionBtn = [[UIButton alloc]init];
    connectionBtn.tag = 4414;
    [connectionBtn setTitle:@"人脉收益" forState:UIControlStateNormal];
    [connectionBtn setTitleColor:RedColor forState:UIControlStateSelected];
    [connectionBtn setTitleColor:LabelAssistantColor forState:UIControlStateNormal];
    [connectionBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
    [connectionBtn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn3 = connectionBtn;
    [self.view addSubview:connectionBtn];
    [connectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headerImage.mas_bottom).offset(AdaptationWidth(18));
        make.centerX.mas_equalTo(self.view).multipliedBy(1.5);
    }];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.view);
        make.top.mas_equalTo(shareBtn.mas_bottom).offset(AdaptationWidth(16));
    }];
    
   
    self.taskTableView.frame = CGRectMake(0, 0, ScreenWidth, AdaptationWidth(464));
    [self.scrollView addSubview:self.taskTableView];

    
    self.shareTableView.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, AdaptationWidth(464));
    [self.scrollView addSubview:self.shareTableView];

    self.connectionTableView.frame = CGRectMake(ScreenWidth*2, 0, ScreenWidth, AdaptationWidth(464));
    [self.scrollView addSubview:self.connectionTableView];

    
}
- (void)btnOnClick:(UIButton *)btn{
    switch (btn.tag) {
        case 4411:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 4412:
        {
            btn1.selected = YES;
            btn2.selected = NO;
            btn3.selected = NO;
            
            [UIView animateWithDuration:0.3 animations:^{
                [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
            }];
        }
            break;
        case 4413:
        {
            btn1.selected = NO;
            btn2.selected = YES;
            btn3.selected = NO;
            [UIView animateWithDuration:0.3 animations:^{
                [self.scrollView setContentOffset:CGPointMake(ScreenWidth, 0) animated:NO];
            }];
        }
            break;
        case 4414:
        {
            btn1.selected = NO;
            btn2.selected = NO;
            btn3.selected = YES;
            [UIView animateWithDuration:0.3 animations:^{
                [self.scrollView setContentOffset:CGPointMake(ScreenWidth*2, 0) animated:NO];
            }];
        }
            break;
            
        default:
            break;
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    

       
        NSInteger index = scrollView.contentOffset.x / scrollView.Sw;
        switch (index) {
            case 0:
                btn1.selected = YES;
                btn2.selected = NO;
                btn3.selected = NO;
                break;
            case 1:
                btn1.selected = NO;
                btn2.selected = YES;
                btn3.selected = NO;
                break;
            case 2:
                btn1.selected = NO;
                btn2.selected = NO;
                btn3.selected = YES;
                break;
                
            default:
                break;
        }
    
}
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView  = [[UIScrollView alloc]init];
        _scrollView.contentSize = CGSizeMake(self.view.Sw * 3, 0);
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}
- (ExpectTableView *)taskTableView{
    if (!_taskTableView) {
        _taskTableView = [[ExpectTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _taskTableView.expectViewModel.viewModelType = ExpectTableViewTypeTesk;
        [_taskTableView.expectViewModel requestData];
    }
    return _taskTableView;
}
- (ExpectTableView *)shareTableView{
    if (!_shareTableView) {
        _shareTableView = [[ExpectTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _shareTableView.expectViewModel.viewModelType = ExpectTableViewTypeShare;
        [_shareTableView.expectViewModel requestData];
    }
    return _shareTableView;
}
- (ExpectTableView *)connectionTableView{
    if (!_connectionTableView) {
        _connectionTableView = [[ExpectTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _connectionTableView.expectViewModel.viewModelType = ExpectTableViewTypeConnection;
        [_connectionTableView.expectViewModel requestData];
    }
    return _connectionTableView;
}
@end
