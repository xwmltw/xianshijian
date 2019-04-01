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
    if ([model.moneyFlowTypeDesc isEqualToString:@"任务收益"]) {
        [self.labState setTextColor:XColorWithRGB(56, 181, 173)];
        [self.labState setBorderWidth:1 andColor:XColorWithRGB(56, 181, 173)];
    }else if ([model.moneyFlowTypeDesc isEqualToString:@"分享收益"]){
        [self.labState setTextColor:RedColor];
        [self.labState setBorderWidth:1 andColor:RedColor];
    }else{
        [self.labState setBorderWidth:1 andColor:XColorWithRGB(255, 198, 83)];
        [self.labState setTextColor:XColorWithRGB(255, 198, 83)];
    }
    self.labDetial.text = model.moneyFlowTitle;
    if ([model.tradeAmount doubleValue]>0) {
        self.labMoney.text = [NSString stringWithFormat:@"+%.2f",[model.tradeAmount doubleValue]/100];
    }else{
        self.labMoney.text = [NSString stringWithFormat:@"-%.2f",[model.tradeAmount doubleValue]/100];
    }
    
    self.labDate.text = model.tradeTime;
    self.labState.text = model.moneyFlowTypeDesc;
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
