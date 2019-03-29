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
        blockSelf.firstLab.text = blockSelf.cashWithdrawalModel.withdrawRuleDesc[0];
        blockSelf.detailbLab.text = blockSelf.cashWithdrawalModel.withdrawRuleDesc[1];
        
    } andFailBlock:^(ResponseModel *model) {
        
    }];
}
- (IBAction)btnOnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 4031:
            self.wxBtn.selected = YES;
            self.zfbBtn.selected = NO;
            break;
        case 4032:
            self.wxBtn.selected = NO;
            self.zfbBtn.selected = YES;
            break;
        case 4033:
        {
            
            if (!self.moneyTextField.text.length) {
                [ProgressHUD showProgressHUDInView:nil withText:@"请输入提现金额" afterDelay:1];
                return;
            }
            if ([self.moneyTextField.text doubleValue] < [self.cashWithdrawalModel.minwithdrawAmount doubleValue]/100) {
                [ProgressHUD showProgressHUDInView:nil withText:@"低于最低提现金额" afterDelay:1];
                return;
            }
            if (!self.wxBtn.isSelected && !self.zfbBtn.isSelected) {
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
    if (self.cashWithdrawalModel.withdrawServiceRate) {
        self.inPutPasswordView.labDetail.text = [NSString stringWithFormat:@"将额外收取服务费(费率%@%%)",self.cashWithdrawalModel.withdrawServiceRate];
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
                [blockSelf.navigationController popToViewController:vc animated:YES];
            }
                break;
            case 4333:
            {
                if (!blockSelf.inPutPasswordView.passwordTF.text.length) {
                    [ProgressHUD showProgressHUDInView:nil withText:@"请输入钱包密码" afterDelay:1];
                    return;
                }
                
                [blockSelf wxInfo];//微信登录
                
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
    [dic setValue:[self serviceAmoutStr] forKey:@"serviceAmount"];
    [dic setValue:self.moneyTextField.text forKey:@"withdrawAmount"];
    BLOCKSELF
    [XNetWork requestNetWorkWithUrl:Xwechat_cash_withdraw andModel:dic andSuccessBlock:^(ResponseModel *model) {
        [ProgressHUD showProgressHUDInView:nil withText:@"提现成功" afterDelay:1];
        blockSelf.inPutPasswordView.hidden = YES;
    } andFailBlock:^(ResponseModel *model) {
        
    }];
}
- (NSString *)serviceAmoutStr{
    double oldMoney = [self.moneyTextField.text doubleValue] * [self.cashWithdrawalModel.withdrawServiceRate doubleValue] / 100;
    return [NSString stringWithFormat:@"%.2f",oldMoney];
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
