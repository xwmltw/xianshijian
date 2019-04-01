//
//  MyPersonTableViewCell.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/19.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "MyPersonTableViewCell.h"

@implementation MyPersonTableViewCell
- (void)setConnectionFirstModel:(ConnectionFirstModel *)connectionFirstModel{
    if (connectionFirstModel.trueName) {
        self.LabTitle.text = [NSString stringWithFormat:@"%@(%@)",connectionFirstModel.telephone,connectionFirstModel.trueName];
    }else{
        self.LabTitle.text = [NSString stringWithFormat:@"%@",connectionFirstModel.telephone];
    }
    
    self.labMoney.text = [NSString stringWithFormat:@"已为您赚取￥%.2f",[connectionFirstModel.profitAmt doubleValue]/100];
    self.labNum.text = [NSString stringWithFormat:@"二级人脉%@人",connectionFirstModel.firstConnectionsCount.description];
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
