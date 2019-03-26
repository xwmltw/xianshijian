//
//  WalletTableViewCell.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/26.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "WalletTableViewCell.h"

@implementation WalletTableViewCell

- (void)setModel:(ProtifDetailModel *)model{
    self.labDetail.text = model.moneyFlowTitle;
    self.labMoney.text = [NSString stringWithFormat:@"%.2f",[model.tradeAmount doubleValue]];
    self.labDate.text = model.tradeTime;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
