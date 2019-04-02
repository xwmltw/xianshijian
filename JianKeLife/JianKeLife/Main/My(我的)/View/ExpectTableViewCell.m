//
//  ExpectTableViewCell.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/27.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "ExpectTableViewCell.h"

@implementation ExpectTableViewCell

- (void)setModel:(ExpectCellModel *)model{
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(AdaptationWidth(10));
        make.right.mas_equalTo(self).offset(AdaptationWidth(-10));
        make.top.mas_equalTo(self).offset(AdaptationWidth(5));
        make.bottom.mas_equalTo(self).offset(AdaptationWidth(-5));
    }];
    
    UILabel *detail = [[UILabel alloc]init];
    detail.text = model.profitAmountDesc;
    detail.numberOfLines = 2;
    [detail setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
    [detail setTextColor:LabelMainColor];
    [view addSubview:detail];
    [detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view).offset(AdaptationWidth(12));
        make.width.mas_equalTo(AdaptationWidth(235));
        make.top.mas_equalTo(view).offset(AdaptationWidth(10));
//        make.bottom.mas_equalTo(view).offset(AdaptationWidth(-31));
    }];
    
    UILabel *momeyLan = [[UILabel alloc]init];
    momeyLan.text = [NSString stringWithFormat:@"+%.2f",[model.profitAmount doubleValue]/100];
    [momeyLan setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
    [momeyLan setTextColor:RedColor];
    [view addSubview:momeyLan];
    [momeyLan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(view).offset(-10);
        make.top.mas_equalTo(view).offset(AdaptationWidth(10));
    }];
    
    UILabel *overLab = [[UILabel alloc]init];
    overLab.text = @"完成后您可赚";
    [overLab setFont:[UIFont systemFontOfSize:AdaptationWidth(12)]];
    [overLab setTextColor:LabelAssistantColor];
    [view addSubview:overLab];
    [overLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(view).offset(-10);
        make.top.mas_equalTo(momeyLan.mas_bottom).offset(AdaptationWidth(2));
    }];
    
    UILabel *dateLab = [[UILabel alloc]init];
    dateLab.text = model.createTime;
    [dateLab setFont:[UIFont systemFontOfSize:AdaptationWidth(12)]];
    [dateLab setTextColor:LabelAssistantColor];
    [view addSubview:dateLab];
    [dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view).offset(AdaptationWidth(10));
        make.bottom.mas_equalTo(view).offset(AdaptationWidth(-10));
       
    }];
    

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
