//
//  ProfitTableViewCell.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/26.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "ProfitTableViewCell.h"

@implementation ProfitTableViewCell
- (void)setModel:(ProtifDetailModel *)model{
    self.labDetial.text = model.moneyFlowTypeDesc;
    self.labMoney.text = [NSString stringWithFormat:@"%.2f",[model.tradeAmount doubleValue]/100];
    self.labDate.text = model.tradeTime;
    self.labState.text = model.moneyFlowTitle;
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
