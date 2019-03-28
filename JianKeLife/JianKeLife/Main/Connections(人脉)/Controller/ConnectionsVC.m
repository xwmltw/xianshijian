//
//  ConnectionsVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/19.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "ConnectionsVC.h"
#import "ExtendTableView.h"
#import "MyPersonTableView.h"
#import "ConnectionViewModel.h"
#import "MyPersonSecondVC.h"

@interface ConnectionsVC ()
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UILabel *personNumLab;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *firstLab;
@property (weak, nonatomic) IBOutlet UILabel *secondLab;
@property (weak, nonatomic) IBOutlet UIButton *extendBtn;
@property (weak, nonatomic) IBOutlet UIButton *myPersonBtn;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *selectView;

@property (nonatomic ,strong) ExtendTableView *extendTableView;
@property (nonatomic ,strong) MyPersonTableView *myPersonTableView;
@property (nonatomic ,strong) ConnectionViewModel *connectionViewModel;
@end

@implementation ConnectionsVC

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    statusBar.backgroundColor = XColorWithRGB(171, 216, 255);
    [self getData];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    statusBar.backgroundColor = [UIColor clearColor];
}

- (IBAction)btnOnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 301:
        {

            self.extendBtn.selected = YES;
            self.myPersonBtn.selected = NO;
            self.lineView.X = self.selectView.Sw/4-20;
            self.extendTableView.hidden = NO;
            self.myPersonTableView.hidden = YES;
        }
            break;
        case 302:
        {
            self.extendBtn.selected = NO;
            self.myPersonBtn.selected = YES;
            
            self.lineView.X = self.selectView.Sw/4*3-20;
            
            self.extendTableView.hidden = YES;
            self.myPersonTableView.hidden = NO;
        }
            break;
        case 303:
        {
            
        }
            break;
            
        default:
            break;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.headerView setCornerValue:2];
    [self.selectView setCornerValue:2];
    [self.firstLab setBorderWidth:1 andColor:LabelAssistantColor];
    [self.firstLab setCornerValue:2];
    [self.secondLab setBorderWidth:1 andColor:LabelAssistantColor];
    [self.secondLab setCornerValue:2];
    
    self.extendTableView.hidden = NO;
    [self.extendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.selectView).offset (AdaptationWidth(10));
        make.centerX.mas_equalTo(self.selectView).multipliedBy(0.5);
    }];
    [self.myPersonBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.selectView).offset (AdaptationWidth(10));
        make.centerX.mas_equalTo(self.selectView).multipliedBy(1.5);
    }];
    
    
}
- (void)getData{
    [self.connectionViewModel requestData];
    BLOCKSELF
    [self.connectionViewModel setConnectionRequestBlcok:^(id result) {
        blockSelf.moneyLab.text = [NSString stringWithFormat:@"%.2f",[blockSelf.connectionViewModel.connectionModel.profitAmt doubleValue]/100];
        blockSelf.personNumLab.text = [NSString stringWithFormat:@"已邀请人脉%@人",blockSelf.connectionViewModel.connectionModel.totalCount.description];
        blockSelf.firstLab.text = [NSString stringWithFormat:@"一级%@人",blockSelf.connectionViewModel.connectionModel.firstConnectionsCount.description];
        blockSelf.secondLab.text = [NSString stringWithFormat:@"二级%@人",blockSelf.connectionViewModel.connectionModel.secondConnectionsCount.description];
    }];
}
- (XBlock)MyPersonFirstBlock{
    BLOCKSELF
    XBlock Blcok = ^(id result){
        MyPersonSecondVC *vc = [[MyPersonSecondVC alloc]init];
        vc.model = result;
        [blockSelf.navigationController pushViewController:vc animated:YES];
    };
    return Blcok;
}
- (ExtendTableView *)extendTableView{
    if (!_extendTableView) {
        _extendTableView = [[ExtendTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:_extendTableView];
        [_extendTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view).offset(10);
            make.right.mas_equalTo(self.view).offset(-10);
            make.top.mas_equalTo(self.selectView.mas_bottom);
            make.height.mas_equalTo(AdaptationWidth(329));
        }];
    }
    return _extendTableView;
}
- (MyPersonTableView *)myPersonTableView{
    if (!_myPersonTableView) {
        _myPersonTableView = [[MyPersonTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:_myPersonTableView];
        [_myPersonTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view).offset(10);
            make.right.mas_equalTo(self.view).offset(-10);
            make.top.mas_equalTo(self.selectView.mas_bottom);
            make.bottom.mas_equalTo(self.view);
        }];
        _myPersonTableView.connectionCellSelectBlock = [self MyPersonFirstBlock];
    }
    return _myPersonTableView;
}


- (ConnectionViewModel *)connectionViewModel{
    if (!_connectionViewModel) {
        _connectionViewModel = [[ConnectionViewModel alloc]init];
    }
    return _connectionViewModel;
}

@end
