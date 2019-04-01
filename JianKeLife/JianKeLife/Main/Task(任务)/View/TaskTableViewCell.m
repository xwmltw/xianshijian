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
    self.cellDate.hidden = NO;
    self.cellTitelDate.hidden = NO;;
    self.passImage.hidden = YES;
    self.passLab.hidden = YES;
    
    switch (self.taskTableView) {
        case TaskTableViewTypeStay:
            self.cellGiveBtn.hidden = NO;
            self.cellGoBtn.hidden = NO;
            self.cellLookBtn.hidden = YES;
            self.cellVerifyBtn.hidden = YES;
            self.passLab.hidden = YES;
            self.passImage.hidden = YES;
            self.cellTitelDate.text = @"返佣倒计时";
            self.cellDate.text = [DateHelper getDateFromTimeNumber:self.model.ctmSubmitDeadTimeLeft];
            break;
        case TaskTableViewTypeIng:
            self.cellGiveBtn.hidden = YES;
            self.cellGoBtn.hidden = YES;
            self.cellLookBtn.hidden = NO;
            self.cellVerifyBtn.hidden = YES;
            self.passLab.hidden = YES;
            self.passImage.hidden = YES;
            self.cellTitelDate.text = @"审核倒计时";
            self.cellDate.text = [DateHelper getDateFromTimeNumber:self.model.entAuditDeadTimeLeft];
            break;
        case TaskTableViewTypeOver:
            self.cellGiveBtn.hidden = YES;
            self.cellGoBtn.hidden = YES;
            self.cellLookBtn.hidden = YES;
            self.cellVerifyBtn.hidden = NO;
            self.cellDate.hidden = YES;
            self.cellTitelDate.hidden = YES;
            self.passImage.hidden = NO;
            self.passLab.hidden = NO;
            switch (model.prodTradeAuditStatus.integerValue) {
                case 1:
                case 2:
                    [self.passImage setImage:[UIImage imageNamed:@"icon_pass"]];
                    self.passLab.text = @"已通过";
                    [self.passLab setTextColor:XColorWithRGB(0, 162, 0)];
                    break;
                    
                    
                case 3:
                    [self.passImage setImage:[UIImage imageNamed:@"icon_unPass"]];
                    self.passLab.text = @"未通过";
                    [self.passLab setTextColor:LabelAssistantColor];
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
