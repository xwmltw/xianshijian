//
//  ExtendTableView.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/19.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "ExtendTableView.h"

@interface ExtendTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ExtendTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.backgroundColor = XColorWithRGB(248, 248, 248);
        self.estimatedRowHeight = 0;
        
        
    }
    return self;
}
- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptationWidth(103);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return AdaptationWidth(17);
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExtendTableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ExtendTableViewCell"];
    }
    UIImageView *cellImage = [[UIImageView alloc]init];
    
    [cell.contentView addSubview:cellImage];
    [cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cell).offset(AdaptationWidth(10));
        make.top.mas_equalTo(cell).offset(AdaptationWidth(5));
        make.right.mas_equalTo(cell).offset(AdaptationWidth(-10));
        make.bottom.mas_equalTo(cell).offset(AdaptationWidth(-5));
    }];
    
    UILabel *cellTitle = [[UILabel alloc]init];
    [cellTitle setFont:[UIFont systemFontOfSize:AdaptationWidth(18)]];
    [cellTitle setTextColor:LabelMainColor];
    [cell.contentView addSubview:cellTitle];
    [cellTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cell).offset(AdaptationWidth(26));
        make.top.mas_equalTo(cell).offset(AdaptationWidth(22));
    }];
     
     UILabel *cellDetail = [[UILabel alloc]init];
     [cellDetail setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
     [cellDetail setTextColor:LabelMainColor];
     [cell.contentView addSubview:cellDetail];
     [cellDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cell).offset(AdaptationWidth(26));
        make.top.mas_equalTo(cellTitle.mas_bottom).offset(AdaptationWidth(3));
    }];
    switch (indexPath.row) {
        case 0:
            [cellImage setImage:[UIImage imageNamed:@"image_shareposter"]];
            cellTitle.text = @"推广海报";
            cellDetail.text = @"保存海报，分享给好友/朋友圈 ->";
            break;
        case 1:
            [cellImage setImage:[UIImage imageNamed:@"iamge_sharelink"]];
            cellTitle.text = @"推广链接";
            cellDetail.text = @"复制注册链接分享给好友 ->";
            break;
        case 2:
        {
            [cellImage setImage:[UIImage imageNamed:@"iamge_rule"]];
            [cellTitle setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
            [cellTitle mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(cell).offset(AdaptationWidth(15));
            }];
            cellTitle.text = @"邀请好友成为你的人脉";
            cellDetail.text = [NSString stringWithFormat:@"享受%@%%佣金提成",self.firstCut.description];
            
            UIButton *btn = [[UIButton alloc]init];
            [btn setTitle:@"查看规则" forState:UIControlStateNormal];
            [btn setBackgroundColor:XColorWithRGB(255, 221, 88)];
            [btn setTitleColor:XColorWithRGB(152, 6, 6) forState:UIControlStateNormal];
            [btn setCornerValue:3];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(12)]];
            [btn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(cell).offset(AdaptationWidth(26));
                make.bottom.mas_equalTo(cell).offset(AdaptationWidth(-15));
                make.width.mas_equalTo(AdaptationWidth(65));
                make.height.mas_equalTo(AdaptationWidth(24));
            }];
            
        }
            break;
            
        default:
            break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XBlockExec(self.extendCellSelectBlcok,indexPath.row);
}
- (void)btnOnClick:(UIButton *)btn{
    XBlockExec(self.extendBtnSelectBlcok ,nil);
}
@end
