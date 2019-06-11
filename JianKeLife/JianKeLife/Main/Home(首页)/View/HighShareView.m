//
//  HighShareView.m
//  JianKeLife
//
//  Created by yanqb on 2019/5/22.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "HighShareView.h"
#import "HiBuyProductModel.h"
#import "HiBuyProductdetialVC.h"
#import "XControllerViewHelper.h"
#import "HighShareVC.h"

@interface HighShareView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)HiBuyProductModel *hiBuyProductModel;
@end

@implementation HighShareView
- (void)creatInitTableView{
    self.delegate = self;
    self.dataSource = self;
    self.scrollEnabled = NO;
}

#pragma  mark - tablebiew
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.highListAry.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    UIImageView *image = [[UIImageView alloc]init];
    [image setImage:[UIImage imageNamed:@"icon_high_hot"]];
    [view addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view).offset(AdaptationWidth(12));
        make.centerY.mas_equalTo(view);
    }];
    
    UILabel *detailtitle = [[UILabel alloc]init];
    detailtitle.text = self.highListTitle;
    [detailtitle setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(16)]];
    [detailtitle setTextColor:LabelMainColor];
    [view addSubview:detailtitle];
    [detailtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(image.mas_right).offset(AdaptationWidth(4));
        make.centerY.mas_equalTo(view);
        
    }];
    
    UIButton *allBtn = [[UIButton alloc]init];
    [allBtn setTitle:@"查看全部" forState:UIControlStateNormal];
    [allBtn setImage:[UIImage imageNamed:@"icon_right"] forState:UIControlStateNormal];
    [allBtn setTitleColor:LabelAssistantColor forState:UIControlStateNormal];
    [allBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
    allBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
    allBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -35, 0, 0);
    [allBtn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:allBtn];
    [allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(view).offset(AdaptationWidth(-12));
        make.centerY.mas_equalTo(view);
    }];
    
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return AdaptationWidth(50);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return AdaptationWidth(120);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"HighListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.hiBuyProductModel = [HiBuyProductModel mj_objectWithKeyValues:self.highListAry[indexPath.row]];
        UIView *view = [[UIView alloc]init];
        [view setBorderWidth:1 andColor:BackgroundColor];
        view.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(cell);
            make.left.mas_equalTo(cell).offset(AdaptationWidth(8));
            make.right.mas_equalTo(cell).offset(AdaptationWidth(-8));
            make.bottom.mas_equalTo(cell);
        }];
        
        UIImageView *image = [[UIImageView alloc]init];
        [image sd_setImageWithURL:[NSURL URLWithString:self.hiBuyProductModel.pictUrl] placeholderImage:[UIImage imageNamed:@"今日值享logo定稿"]];
        [view addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(view).offset(AdaptationWidth(8));
            make.left.mas_equalTo(view).offset(AdaptationWidth(8));
            make.centerY.mas_equalTo(view);
//            make.bottom.mas_equalTo(view).offset(AdaptationWidth(-8));
            make.width.height.mas_equalTo(AdaptationWidth(96));
        }];
        
        UIImageView *numImage = [[UIImageView alloc]init];
        switch (indexPath.row) {
            case 0:
                [numImage setImage:[UIImage imageNamed:@"icon_high_one"]];
                break;
            case 1:
                [numImage setImage:[UIImage imageNamed:@"icon_high_two"]];
                break;
            case 2:
                [numImage setImage:[UIImage imageNamed:@"icon_high_three"]];
                break;
                
            default:
                break;
        }
        
        [image addSubview:numImage];
        [numImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(image);
            make.left.mas_equalTo(image);
            make.width.height.mas_equalTo(AdaptationWidth(17));
        }];
        
        UILabel *lab = [[UILabel alloc]init];
        lab.text = self.hiBuyProductModel.title;
        [lab setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(16)]];
        [lab setTextColor:LabelMainColor];
        [view addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(image.mas_right).offset(AdaptationWidth(14));
            make.right.mas_equalTo(view).offset(AdaptationWidth(-14));
            make.top.mas_equalTo(image);
            
        }];
        
        UILabel *yuguLab = [[UILabel alloc]init];
        yuguLab.textAlignment = NSTextAlignmentCenter;
        [yuguLab setCornerValue:AdaptationWidth(2)];
        [yuguLab setBorderWidth:1 andColor:RedColor];
        if (self.hiBuyProductModel.commissionAmount.doubleValue) {
            yuguLab.text = [NSString stringWithFormat:@"预估收益￥%.2f",[self.hiBuyProductModel.commissionAmount doubleValue]];
        }else{
            yuguLab.text = @"";
        }
        [yuguLab setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(12)]];
        [yuguLab setTextColor:RedColor];
        [view addSubview:yuguLab];
        [yuguLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(image.mas_right).offset(AdaptationWidth(14));
            make.width.mas_equalTo(AdaptationWidth(95));
            make.bottom.mas_equalTo(image);
            
        }];
        
        UILabel *juanLab = [[UILabel alloc]init];
        [juanLab setCornerValue:AdaptationWidth(2)];
        [juanLab setBorderWidth:1 andColor:XColorWithRGB(255, 157, 0)];
        juanLab.textAlignment = NSTextAlignmentCenter;
        [juanLab setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(12)]];
        [juanLab setTextColor:XColorWithRGB(255, 157, 0)];
        [view addSubview:juanLab];
        [juanLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(yuguLab.mas_right).offset(AdaptationWidth(7));
            make.width.mas_equalTo(AdaptationWidth(60));
            make.bottom.mas_equalTo(image);
            
        }];
        
        UILabel *unitLab = [[UILabel alloc]init];
        unitLab.text = @"￥";
        [unitLab setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(12)]];
        [unitLab setTextColor:RedColor];
        [view addSubview:unitLab];
        [unitLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(image.mas_right).offset(AdaptationWidth(14));
            make.bottom.mas_equalTo(view).offset(AdaptationWidth(-35));
            
        }];
        
        UILabel *moneyLab = [[UILabel alloc]init];
        
        [moneyLab setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(20)]];
        [moneyLab setTextColor:RedColor];
        [view addSubview:moneyLab];
        [moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(unitLab.mas_right).offset(AdaptationWidth(1));
            make.bottom.mas_equalTo(unitLab).offset(AdaptationWidth(4));
            
        }];
        
        NSMutableAttributedString *attribttedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥%.2f",[self.hiBuyProductModel.zkFinalPrice doubleValue]] attributes:nil];
        [attribttedStr addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),NSStrikethroughColorAttributeName:LabelAssistantColor} range:NSMakeRange(0, attribttedStr.length)];
        
        UILabel *oldLab = [[UILabel alloc]init];
        oldLab.attributedText = attribttedStr;
        [oldLab setFont:[UIFont systemFontOfSize:AdaptationWidth(12)]];
        [oldLab setTextColor:LabelAssistantColor];
        [cell.contentView addSubview:oldLab];
        [oldLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(moneyLab.mas_right).offset(AdaptationWidth(5));
            make.bottom.mas_equalTo(unitLab);
        }];
        
        if (self.hiBuyProductModel.couponAmount.integerValue > 0) {
            oldLab.hidden = NO;
            juanLab.text = [NSString stringWithFormat:@"劵￥%.2f",[self.hiBuyProductModel.couponAmount doubleValue]];
            moneyLab.text = [NSString stringWithFormat:@"%.2f",[self.hiBuyProductModel.afterCouplePrice doubleValue]];
        }else{
            oldLab.hidden = YES;
            juanLab.text = [NSString stringWithFormat:@""];
            moneyLab.text = [NSString stringWithFormat:@"%.2f",[self.hiBuyProductModel.zkFinalPrice doubleValue]];
        }
        
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HiBuyProductdetialVC *vc = [[HiBuyProductdetialVC alloc]init];
    vc.productId = self.highListAry[indexPath.row][@"id"];
    vc.hidesBottomBarWhenPushed = YES;
    [[XControllerViewHelper getTopViewController].navigationController pushViewController:vc animated:YES];
}
- (void)btnOnClick:(UIButton *)btn{
    HighShareVC*vc = [[HighShareVC alloc]init];
    vc.highListTitle = self.highListTitle;
    vc.hidesBottomBarWhenPushed = YES;
    [[XControllerViewHelper getTopViewController].navigationController pushViewController:vc animated:YES];
}
- (HiBuyProductModel *)hiBuyProductModel{
    if (!_hiBuyProductModel) {
        _hiBuyProductModel = [[HiBuyProductModel alloc]init];
    }
    return _hiBuyProductModel;
}
@end
