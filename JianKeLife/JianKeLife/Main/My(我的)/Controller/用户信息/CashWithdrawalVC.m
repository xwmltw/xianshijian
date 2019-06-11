//
//  CashWithdrawalVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/26.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "CashWithdrawalVC.h"
#import "GetBackWalletVC.h"
#import "CashWithdrawalModel.h"
#import "SetWalletPasswordView.h"
#import "InPutPasswordView.h"
#import "WXApi.h"

@interface CashWithdrawalVC ()
@property (nonatomic ,strong) CashWithdrawalModel *cashWithdrawalModel;
@property (nonatomic ,strong) SetWalletPasswordView *setWalletPasswordView;
@property (nonatomic ,strong) InPutPasswordView *inPutPasswordView;
@end

@implementation CashWithdrawalVC
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现";
    self.view.backgroundColor = XColorWithRGB(248, 248, 248);
    [self.sureBtn setCornerValue:4];
    
    self.balanceLab.text = [NSString stringWithFormat:@"钱包余额：￥%.2f",[self.balance doubleValue]/100];
    [self requestData];
    
}
- (void)requestData{
    BLOCKSELF
    [XNetWork requestNetWorkWithUrl:Xquery_withdraw_cfg andModel:nil andSuccessBlock:^(ResponseModel *model) {
        blockSelf.cashWithdrawalModel = [CashWithdrawalModel mj_objectWithKeyValues:model.data];
        
        blockSelf.firstLab.text = blockSelf.cashWithdrawalModel.withdrawRuleDesc.count ? blockSelf.cashWithdrawalModel.withdrawRuleDesc[0] :@"";
        blockSelf.detailbLab.text = blockSelf.cashWithdrawalModel.withdrawRuleDesc.count > 1 ? blockSelf.cashWithdrawalModel.withdrawRuleDesc[1] :@"";
        
    } andFailBlock:^(ResponseModel *model) {
        
    }];
}
- (IBAction)btnOnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 4031:
            self.wxBtn.selected = !sender.selected;
            
            break;
        
        case 4033:
        {
            
            
            if (!self.moneyTextField.text.length) {
                [ProgressHUD showProgressHUDInView:nil withText:@"请输入提现金额" afterDelay:1];
                return;
            }
            if (self.cashWithdrawalModel.isFirstWithdraw.integerValue == 1 && [self.moneyTextField.text doubleValue] > [self.cashWithdrawalModel.firstMaxWithdrawAmount doubleValue]/100) {
                [ProgressHUD showProgressHUDInView:nil withText:[NSString stringWithFormat:@"首次提现最高可提现金额%.2f",[self.cashWithdrawalModel.firstMaxWithdrawAmount doubleValue]/100] afterDelay:1];
                return;
            }
            if (self.cashWithdrawalModel.isFirstWithdraw.integerValue == 0 && [self.moneyTextField.text doubleValue] < [self.cashWithdrawalModel.minwithdrawAmount doubleValue]/100) {
                [ProgressHUD showProgressHUDInView:nil withText:[NSString stringWithFormat:@"最低提现金额%.2f",[self.cashWithdrawalModel.minwithdrawAmount doubleValue]/100] afterDelay:1];
                return;
            }
            if ([self.moneyTextField.text doubleValue] > ([self.balance doubleValue]/100)) {
                [ProgressHUD showProgressHUDInView:nil withText:@"当前钱包余额不足" afterDelay:1];
                return;
            }
            if (!self.wxBtn.isSelected ) {
                [ProgressHUD showProgressHUDInView:nil withText:@"请选择提现方式" afterDelay:1];
                return;
            }
            
            if (self.cashWithdrawalModel.isSetPwd.integerValue == 0) {
                [self setPassword];
                return;
            }
            [self inPutPassword];
            
            
        }
            break;
            
        default:
            break;
    }
}
- (void)setPassword{
    [self.view addSubview:self.setWalletPasswordView];
    self.setWalletPasswordView.hidden = NO;
    [self.setWalletPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    BLOCKSELF
    [self.setWalletPasswordView setSetPasswordBtnBlock:^(UIButton *result) {
        switch (result.tag) {
                
            case 4321:
                blockSelf.setWalletPasswordView.hidden = YES;
                break;
            case 4322:
            {
                
                [XNetWork requestNetWorkWithUrl:Xset_money_pwd andModel:@{@"pwd":blockSelf.setWalletPasswordView.passwordTextField.text} andSuccessBlock:^(ResponseModel *model) {
                    [ProgressHUD showProgressHUDInView:nil withText:@"设置成功" afterDelay:1];
                    blockSelf.setWalletPasswordView.hidden = YES;
                    blockSelf.cashWithdrawalModel.isSetPwd = @1;
                    [blockSelf inPutPassword];
                } andFailBlock:^(ResponseModel *model) {
                    
                }];
            }
                break;
                
            default:
                break;
        }
    }];
    
}
- (void)inPutPassword{
    [self.view addSubview:self.inPutPasswordView];
    self.inPutPasswordView.labMoney.text = [NSString stringWithFormat:@"￥%.2f",[self.moneyTextField.text doubleValue]];
    double num = [self.moneyTextField.text doubleValue] * [self.cashWithdrawalModel.withdrawServiceRate doubleValue]/100;
    if (num > 0.01) {

        self.inPutPasswordView.labDetail.text = [NSString stringWithFormat:@"将额外收取%.2f元服务费(费率%@%%)",num,self.cashWithdrawalModel.withdrawServiceRate];

    }else{
        self.inPutPasswordView.labDetail.text = @"";
    }
    self.inPutPasswordView.hidden = NO;
    [self.inPutPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    BLOCKSELF
    [self.inPutPasswordView setInPutPasswordBtnBlock:^(UIButton *result) {
        switch (result.tag) {
            case 4331:
                blockSelf.inPutPasswordView.hidden = YES;
                break;
            case 4332:
            {
                GetBackWalletVC *vc =[[GetBackWalletVC alloc]init];
                [blockSelf.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 4333:
            {
                if (!blockSelf.inPutPasswordView.passwordTF.text.length) {
                    [ProgressHUD showProgressHUDInView:nil withText:@"请输入钱包密码" afterDelay:1];
                    return;
                }
                
                [XNetWork requestNetWorkWithUrl:Xcheck_pwd andModel:@{@"moneyPwd":blockSelf.inPutPasswordView.passwordTF.text} andSuccessBlock:^(ResponseModel *model) {
                    [blockSelf wxInfo];//微信登录
                } andFailBlock:^(ResponseModel *model) {
                    
                }];
                
                
            }
                break;
                
            default:
                break;
        }
    }];
}
- (void)wxInfo{
    
    
    [XNotificationCenter addObserver:self selector:@selector(WXNotification:) name:WXLoginNotification object:nil];
    
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc]init];
    req.scope = @"snsapi_userinfo";
    req.state = @"123";
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];
    
}
- (void)wxInPut:(NSString *)openid{

    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.inPutPasswordView.passwordTF.text forKey:@"moneyPwd"];
    [dic setValue:openid forKey:@"openId"];
    [dic setValue:@([[self serviceAmoutStr] doubleValue]*100) forKey:@"serviceAmount"];
    [dic setValue:@([self.moneyTextField.text doubleValue]*100) forKey:@"withdrawAmount"];
    BLOCKSELF
    [XNetWork requestNetWorkWithUrl:Xwechat_cash_withdraw andModel:dic andSuccessBlock:^(ResponseModel *model) {
        [ProgressHUD showProgressHUDInView:nil withText:@"提现成功" afterDelay:1];
        blockSelf.inPutPasswordView.hidden = YES;
        [blockSelf.navigationController popToRootViewControllerAnimated:YES];
    } andFailBlock:^(ResponseModel *model) {
        
    }];
}
- (NSString *)serviceAmoutStr{
    int oldMoney = [self.moneyTextField.text doubleValue] * [self.cashWithdrawalModel.withdrawServiceRate doubleValue];
    return [NSString stringWithFormat:@"%d",oldMoney];
}
#pragma  mark - t通知
- (void)WXNotification:(NSNotification *)notification{
    NSString *code = notification.userInfo[@"code"];
    
    BLOCKSELF
    [XNetWork getWXLoginAppID:self.cashWithdrawalModel.wxAppId andSecret:self.cashWithdrawalModel.wxAppSecret andCode:code andBlock:^(id result) {
        [blockSelf wxInPut:result[@"openid"]];
    }];
}
- (CashWithdrawalModel *)cashWithdrawalModel{
    if (!_cashWithdrawalModel) {
        _cashWithdrawalModel = [[CashWithdrawalModel alloc]init];
    }
    return _cashWithdrawalModel;
}
- (SetWalletPasswordView *)setWalletPasswordView{
    if (!_setWalletPasswordView) {
        _setWalletPasswordView = [[NSBundle mainBundle]loadNibNamed:@"SetWalletPasswordView" owner:nil options:nil].lastObject;
    }
    return _setWalletPasswordView;
}
- (InPutPasswordView *)inPutPasswordView{
    if (!_inPutPasswordView) {
        _inPutPasswordView = [[NSBundle mainBundle]loadNibNamed:@"InPutPasswordView" owner:nil options:nil].lastObject;
        
    }
    return _inPutPasswordView;
}

@end
