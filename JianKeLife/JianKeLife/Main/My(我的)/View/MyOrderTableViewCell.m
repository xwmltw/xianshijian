//
//  MyOrderTableViewCell.m
//  JianKeLife
//
//  Created by yanqb on 2019/4/18.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "MyOrderTableViewCell.h"

@implementation MyOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.bgView setCornerValue:4];
    [self.copybtn setCornerValue:2];
}
- (void)setModel:(MyOrderModel *)model{
    if ([model.orderType isEqualToString:@"天猫"]) {
        [self.logoImage setImage:[UIImage imageNamed:@""]];
    }else{
        [self.logoImage setImage:[UIImage imageNamed:@""]];
    }
    switch (model.tkStatus.integerValue) {
        case 3:
            self.stautsLab.text = @"订单结算";
            break;
        case 12:
            self.stautsLab.text = @"订单付款";
            break;
        case 13:
            self.stautsLab.text = @"订单失效";
            break;
        case 14:
            self.stautsLab.text = @"订单成功";
            break;
            
        default:
            break;
    }
    self.detailLab.text = model.itemTitle;
    self.dateLab.text = [NSString stringWithFormat:@"创建时间 %@",model.orderCreateTime];
    self.payMoney.text = [NSString stringWithFormat:@"付款金额 %.2f",[model.alipayTotalPrice doubleValue]/100];
    self.expectLab.text = [NSString stringWithFormat:@"预估收益 %.2f",[model.pubSharePreFee doubleValue]/100];
    self.productNo.text = [NSString stringWithFormat:@"订单号: %@",model.tradeId];
    [self.productImage sd_setImageWithURL:[NSURL URLWithString:model.pictUrl]];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (IBAction)btnOnClick:(UIButton *)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.model.tradeId;
    [ProgressHUD showProgressHUDInView:nil withText:@"复制成功" afterDelay:1];
}

@end
