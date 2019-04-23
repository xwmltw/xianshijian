//
//  HiBuyTableViewCell.m
//  JianKeLife
//
//  Created by yanqb on 2019/4/22.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "HiBuyTableViewCell.h"

@implementation HiBuyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.proImage setCornerValue:4];
    [self.expcetLab setCornerValue:1];
    [self.juanLab setCornerValue:1];
}
- (void)setModel:(HiBuyProductModel *)model{
    [self.proImage sd_setImageWithURL:[NSURL URLWithString:model.pictUrl]];
    self.detailLab.text = model.title;
    self.proNameLab.text = model.shopTitle;
    if (model.couponAmount.integerValue > 0) {
        self.juanAffter.hidden = NO;
        self.moneyLab.text = [NSString stringWithFormat:@"%.2f",[model.afterCouplePrice doubleValue]];
    }else{
        self.juanAffter.hidden = YES;
        self.moneyLab.text = [NSString stringWithFormat:@"%.2f",[model.zkFinalPrice doubleValue]];
    }
    
    self.numLab.text = [NSString stringWithFormat:@"销量%d",model.volume.integerValue];
    self.expcetLab.text = [NSString stringWithFormat:@"预估收益%.2f",[model.commissionAmount doubleValue]];
    self.juanLab.text = [NSString stringWithFormat:@"卷￥%.2f",[model.couponAmount doubleValue]];
//    self.typeImage setImage:[]
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
