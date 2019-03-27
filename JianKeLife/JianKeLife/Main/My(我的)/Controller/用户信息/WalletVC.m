//
//  WalletVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/26.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "WalletVC.h"
#import "WalletTableView.h"
#import "CashWithdrawalVC.h"
@interface WalletVC ()
@property (nonatomic ,strong) WalletTableView *walletTableView;
@end

@implementation WalletVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"钱包";
    self.walletTableView  = [[WalletTableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    self.walletTableView.profitViewModel.tradeType = @2;
    [self.walletTableView.profitViewModel requestProfitData];
    self.view = self.walletTableView;
    
    BLOCKSELF
    [self.walletTableView setCashWithdrawalBtnBlock:^(id result) {
        CashWithdrawalVC *vc = [[CashWithdrawalVC alloc]init];
        vc.balance = blockSelf.walletTableView.profitViewModel.profitModel.totalAmount;
        [blockSelf.navigationController pushViewController:vc animated:YES];
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
