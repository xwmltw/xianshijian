//
//  TaskTableViewCell.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/19.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "TaskTableViewCell.h"

@implementation TaskTableViewCell

- (void)layoutSubviews{
    [self.cellGiveBtn setCornerValue:2];
    [self.cellGiveBtn setBorderWidth:1 andColor:blueColor];
}
- (void)awakeFromNib {
    [super awakeFromNib];
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



-(void)setModel:(id)model{
    
}
- (void)setTaskTableView:(TaskTableView)taskTableView{
    switch (taskTableView) {
        case TaskTableViewStay:
            self.cellGiveBtn.hidden = NO;
            self.cellGoBtn.hidden = NO;
            self.cellLookBtn.hidden = YES;
            self.cellVerifyBtn.hidden = YES;
            break;
        case TaskTableViewIng:
            self.cellGiveBtn.hidden = YES;
            self.cellGoBtn.hidden = YES;
            self.cellLookBtn.hidden = NO;
            self.cellVerifyBtn.hidden = YES;
            break;
        case TaskTableViewOver:
            self.cellGiveBtn.hidden = YES;
            self.cellGoBtn.hidden = YES;
            self.cellLookBtn.hidden = YES;
            self.cellVerifyBtn.hidden = NO;
            break;
            
        default:
            break;
    }
}
- (IBAction)btnOnClick:(UIButton *)sender {
    
}

@end
