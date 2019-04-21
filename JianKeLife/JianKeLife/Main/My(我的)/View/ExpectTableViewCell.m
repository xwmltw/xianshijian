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
    
//    UIView *view = [[UIView alloc]init];
//    view.backgroundColor = [UIColor whiteColor];
//    [self.contentView addSubview:view];
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self).offset(AdaptationWidth(10));
//        make.right.mas_equalTo(self).offset(AdaptationWidth(-10));
//        make.top.mas_equalTo(self).offset(AdaptationWidth(5));
//        make.bottom.mas_equalTo(self).offset(AdaptationWidth(-5));
//    }];
    
    UILabel *detail = [[UILabel alloc]init];
    detail.text = model.profitAmountDesc;
    detail.numberOfLines = 0;
    [detail setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
    [detail setTextColor:LabelMainColor];
    [self.contentView addSubview:detail];
    [detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(AdaptationWidth(16));
        make.width.mas_equalTo(AdaptationWidth(235));
        make.top.mas_equalTo(self).offset(AdaptationWidth(12));
//        make.bottom.mas_equalTo(view).offset(AdaptationWidth(-31));
    }];
    
    UILabel *momeyLan = [[UILabel alloc]init];
    momeyLan.text = [NSString stringWithFormat:@"+%.2f",[model.profitAmount doubleValue]/100];
    [momeyLan setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
    [momeyLan setTextColor:RedColor];
    [self.contentView addSubview:momeyLan];
    [momeyLan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-AdaptationWidth(16));
        make.top.mas_equalTo(self).offset(AdaptationWidth(12));
    }];
    
    UIImageView *typeImage = [[UIImageView alloc]init];
    [typeImage setImage:[UIImage imageNamed:@"icon_expect_buy"]];
    [self.contentView addSubview:typeImage];
    [typeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-AdaptationWidth(16));
        make.top.mas_equalTo(momeyLan.mas_bottom).offset(2);
        make.width.mas_equalTo(AdaptationWidth(46));
        make.height.mas_equalTo(AdaptationWidth(18));
    }];
    
    
    UILabel *overLab = [[UILabel alloc]init];
    overLab.text = model.profitAmountReceiveDesc;
//    overLab.text = @"阿斯蒂芬斯蒂芬是";
    [overLab setFont:[UIFont systemFontOfSize:AdaptationWidth(12)]];
    [overLab setTextColor:LabelAssistantColor];
    [self.contentView addSubview:overLab];
    [overLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-AdaptationWidth(16));
        make.bottom.mas_equalTo(self).offset(AdaptationWidth(-12));
    }];
    
    UILabel *dateLab = [[UILabel alloc]init];
    dateLab.text = model.createTime;
    [dateLab setFont:[UIFont systemFontOfSize:AdaptationWidth(12)]];
    [dateLab setTextColor:LabelAssistantColor];
    [self.contentView addSubview:dateLab];
    [dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(AdaptationWidth(16));
        make.bottom.mas_equalTo(self).offset(AdaptationWidth(-12));
       
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = LineColor;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self);
        make.left.mas_equalTo(self).offset(AdaptationWidth(16));
        make.right.mas_equalTo(self).offset(AdaptationWidth(-16));
        make.height.mas_equalTo(AdaptationWidth(1));
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
