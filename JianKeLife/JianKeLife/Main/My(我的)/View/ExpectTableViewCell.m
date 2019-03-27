//
//  ExpectTableViewCell.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/27.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "ExpectTableViewCell.h"

@implementation ExpectTableViewCell
{
    UILabel *detail;
    UILabel *momeyLan;
    UILabel *dateLab;
}
- (void)layoutSubviews{
    
    UIView *view = [[UIView alloc]init];
    [self.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(AdaptationWidth(10));
        make.right.mas_equalTo(self).offset(AdaptationWidth(-10));
        make.top.mas_equalTo(self).offset(AdaptationWidth(5));
        make.bottom.mas_equalTo(self).offset(AdaptationWidth(-5));
    }];
    
    detail = [[UILabel alloc]init];
    detail.numberOfLines = 0;
    [detail setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
    [detail setTextColor:LabelMainColor];
    [view addSubview:detail];
    [detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view).offset(AdaptationWidth(10));
        make.width.mas_equalTo(AdaptationWidth(235));
        make.top.mas_equalTo(view).offset(AdaptationWidth(10));
        make.bottom.mas_equalTo(self).offset(AdaptationWidth(-31));
    }];
    
    momeyLan = [[UILabel alloc]init];
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
        make.top.mas_equalTo(self->momeyLan.mas_bottom).offset(AdaptationWidth(2));
    }];
    
    dateLab = [[UILabel alloc]init];
    [dateLab setFont:[UIFont systemFontOfSize:AdaptationWidth(12)]];
    [dateLab setTextColor:LabelAssistantColor];
    [view addSubview:dateLab];
    [dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view).offset(AdaptationWidth(10));
        make.bottom.mas_equalTo(view).offset(AdaptationWidth(-10));
    
    }];
}
- (void)setModel:(ExpectCellModel *)model{
//    detail.text = model.profitAmountDesc;
    detail.text = @"qwedfqwefdqwdfhqwhdfjqhdlkjqwghedgqwefgqwlgeqlhywe";
    momeyLan.text = [NSString stringWithFormat:@"%.2f",[model.profitAmount doubleValue]/100];
    dateLab.text = model.createTime;
    CGSize detailSize = [detail.text boundingRectWithSize:CGSizeMake(AdaptationWidth(235), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:nil context:nil].size;
    model.width = detailSize.width + AdaptationWidth(53);
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
