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

@interface ConnectionsVC ()
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UILabel *personNumLab;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIButton *extendBtn;
@property (weak, nonatomic) IBOutlet UIButton *myPersonBtn;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *selectView;

@property (nonatomic ,strong) ExtendTableView *extendTableView;
@property (nonatomic ,strong) MyPersonTableView *myPersonTableView;
@end

@implementation ConnectionsVC

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    statusBar.backgroundColor = XColorWithRGB(171, 216, 255);
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
//            [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.bottom.mas_equalTo(self.selectView.mas_bottom).offset(AdaptationWidth(-2));
//                make.centerX.mas_equalTo(self.selectView).multipliedBy(0.5);
//                make.width.mas_equalTo(AdaptationWidth(41));
//                make.height.mas_equalTo(AdaptationWidth(4));
//            }];
            
            self.extendTableView.hidden = NO;
            self.myPersonTableView.hidden = YES;
        }
            break;
        case 302:
        {
            self.extendBtn.selected = NO;
            self.myPersonBtn.selected = YES;
//            [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.bottom.mas_equalTo(self.selectView.mas_bottom).offset(AdaptationWidth(-2));
//                make.centerX.mas_equalTo(self.selectView).multipliedBy(1.5);
//                make.width.mas_equalTo(AdaptationWidth(41));
//                make.height.mas_equalTo(AdaptationWidth(4));
//            }];
            
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
    self.extendTableView.hidden = NO;
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
    }
    return _myPersonTableView;
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
