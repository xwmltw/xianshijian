//
//  TaskTableViewCell.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/19.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "TaskTableViewCell.h"
#import "DateHelper.h"
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



-(void)setModel:(TaskModel *)model{
    [self.cellImage sd_setImageWithURL:[NSURL URLWithString:model.productFirstMainPicUrl]];
    self.celltitle.text = model.productTitle;
    self.cellMoney.text = [NSString stringWithFormat:@"%.2f",[model.productSalary doubleValue]/100];
    
}
- (void)setTaskTableView:(TaskTableViewType)taskTableView{
    switch (taskTableView) {
        case TaskTableViewTypeStay:
            self.cellGiveBtn.hidden = NO;
            self.cellGoBtn.hidden = NO;
            self.cellLookBtn.hidden = YES;
            self.cellVerifyBtn.hidden = YES;
            self.cellTitelDate.text = @"返佣倒计时";
            self.cellDate.text = [DateHelper getDateFromTimeNumber:self.model.ctmSubmitDeadTimeLeft];
            break;
        case TaskTableViewTypeIng:
            self.cellGiveBtn.hidden = YES;
            self.cellGoBtn.hidden = YES;
            self.cellLookBtn.hidden = NO;
            self.cellVerifyBtn.hidden = YES;
            self.cellTitelDate.text = @"审核倒计时";
           self.cellDate.text = [DateHelper getDateFromTimeNumber:self.model.entAuditDeadTimeLeft];
            break;
        case TaskTableViewTypeOver:
            self.cellGiveBtn.hidden = YES;
            self.cellGoBtn.hidden = YES;
            self.cellLookBtn.hidden = YES;
            self.cellVerifyBtn.hidden = NO;
            
            switch (self.model.prodTradeAuditStatus.integerValue) {
                case 1:
                    self.cellTitelDate.text = @"系统通过";
                    [self.cellTitelDate setBackgroundColor:XColorWithRGB(0, 162, 0)];
                    break;
                case 2:
                    self.cellTitelDate.text = @"验收通过";
                    [self.cellTitelDate setBackgroundColor:XColorWithRGB(0, 162, 0)];
                    break;
                case 3:
                    self.cellTitelDate.text = @"未通过";
                    [self.cellTitelDate setBackgroundColor:LabelAssistantColor];
                    break;
                    
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
}

- (IBAction)btnOnClick:(UIButton *)sender {
    if (sender.tag == 201) {
        XBlockExec(self.taskCellCancelBlock, sender);
    }else{
        XBlockExec(self.taskCellBlock, sender);
    }
}

@end
