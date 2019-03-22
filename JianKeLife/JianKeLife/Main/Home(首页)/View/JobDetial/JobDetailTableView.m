//
//  JobDetailTableView.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/20.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "JobDetailTableView.h"

@interface JobDetailTableView ()<UITableViewDelegate ,UITableViewDataSource>

@end

@implementation JobDetailTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.backgroundColor = BackgroundColor;
        self.delegate = self;
        self.dataSource = self;
        self.estimatedSectionHeaderHeight = 0;
        
        
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return AdaptationWidth(300);
    }
    return AdaptationWidth(100);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"JobDetialIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = BackgroundColor;
    }
    switch (indexPath.row) {
        case 0:
        {
            UIImageView *cellImage = [[UIImageView alloc]init];
            [cellImage sd_setImageWithURL:[NSURL URLWithString:@"https://img-my.csdn.net/uploads/201407/26/1406383291_8239.jpg"]];
            [cell.contentView addSubview:cellImage];
            [cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.mas_equalTo(cell);
                make.height.mas_equalTo(AdaptationWidth(250));
            }];
            
            UIView *view = [[UIView alloc]init];
            view.backgroundColor  = RedColor;
            [cell.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.mas_equalTo(cell);
                make.height.mas_equalTo(AdaptationWidth(50));
            }];
            
            UILabel *cellDetail = [[UILabel alloc]init];
            cellDetail.text = @"返佣 ￥";
            [cellDetail setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
            [cellDetail setTextColor:[UIColor whiteColor]];
            [view addSubview:cellDetail];
            [cellDetail mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(view).offset(AdaptationWidth(26));
                make.centerY.mas_equalTo(view);
            }];
            
            UILabel *detailMoney = [[UILabel alloc]init];
            detailMoney.text = @"120.00";
            [detailMoney setFont:[UIFont fontWithName:@"PingFangSC-Bold" size:AdaptationWidth(30)]];
            [detailMoney setTextColor:[UIColor whiteColor]];
            [view addSubview:detailMoney];
            [detailMoney mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(cellDetail.mas_right).offset(AdaptationWidth(3));
                make.centerY.mas_equalTo(view);
            }];
            
            UILabel *getNum = [[UILabel alloc]init];
            getNum.text = @"已领取233";
            [getNum setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(12)]];
            [getNum setTextColor:[UIColor whiteColor]];
            [view addSubview:getNum];
            [getNum mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(view).offset(AdaptationWidth(-18));
                make.centerY.mas_equalTo(view);
            }];
        }
            break;
        case 1:
        {
            UIView *view = [[UIView alloc]init];
            [view setCornerValue:4];
            view.backgroundColor  = [UIColor whiteColor];
            [cell.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(cell).offset(10);
                make.right.mas_equalTo(cell).offset(-10);
                make.top.mas_equalTo(cell).offset(4);
                make.bottom.mas_equalTo(cell).offset(-4);
            }];
            
            UILabel *detailMoney = [[UILabel alloc]init];
            detailMoney.numberOfLines = 2;
            detailMoney.text = @"招商银行信用卡办理关注评论评论评最多20字";
            [detailMoney setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(18)]];
            [detailMoney setTextColor:LabelMainColor];
            [view addSubview:detailMoney];
            [detailMoney mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(view).offset(AdaptationWidth(16));
                make.right.mas_equalTo(view).offset(AdaptationWidth(-16));
                make.top.mas_equalTo(view).offset(AdaptationWidth(12));
                
            }];
            
            UIImageView *cellImage = [[UIImageView alloc]init];
            cellImage.image = [UIImage imageNamed:@"icon_jobDetail_time"];
            [view addSubview:cellImage];
            [cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(view).offset(AdaptationWidth(16));
                make.bottom.mas_equalTo(view).offset(AdaptationWidth(-12));
            }];
            
            UILabel *detailTime = [[UILabel alloc]init];
            detailTime.text = @"领取截止至 2019/02/26";
            [detailTime setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(12)]];
            [detailTime setTextColor:LabelAssistantColor];
            [view addSubview:detailTime];
            [detailTime mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(cellImage.mas_right).offset(AdaptationWidth(3));
                make.centerY.mas_equalTo(cellImage);
                
                
            }];
            
        }
            break;
        case 2:
        {
            UIView *view = [[UIView alloc]init];
            [view setCornerValue:4];
            view.backgroundColor  = [UIColor whiteColor];
            [cell.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(cell).offset(10);
                make.right.mas_equalTo(cell).offset(-10);
                make.top.mas_equalTo(cell).offset(4);
                make.bottom.mas_equalTo(cell).offset(-4);
            }];
            
            UILabel *title = [[UILabel alloc]init];
            title.text = @"面向群体";
            [title setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(16)]];
            [title setTextColor:LabelMainColor];
            [view addSubview:title];
            [title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(view).offset(AdaptationWidth(16));
                make.right.mas_equalTo(view).offset(AdaptationWidth(-16));
                make.top.mas_equalTo(view).offset(AdaptationWidth(12));
                
            }];
            
            UILabel *detial = [[UILabel alloc]init];
            detial.numberOfLines = 0;
            detial.text = @"22周岁以上上海银行新用户;\n没有听过别的渠道申请过的用户；";
            [detial setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(14)]];
            [detial setTextColor:LabelMainColor];
            [view addSubview:detial];
            [detial mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(view).offset(AdaptationWidth(16));
                make.right.mas_equalTo(view).offset(AdaptationWidth(-16));
                make.top.mas_equalTo(title.mas_bottom).offset(AdaptationWidth(6));
                make.bottom.mas_equalTo(view).offset(AdaptationWidth(-12));
                
            }];
           
        }
            break;
        case 3:
        {
            UIView *view = [[UIView alloc]init];
            [view setCornerValue:4];
            view.backgroundColor  = [UIColor whiteColor];
            [cell.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(cell).offset(10);
                make.right.mas_equalTo(cell).offset(-10);
                make.top.mas_equalTo(cell).offset(4);
                make.bottom.mas_equalTo(cell).offset(-4);
            }];
            
            UILabel *title = [[UILabel alloc]init];
            title.text = @"产品详情";
            [title setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(16)]];
            [title setTextColor:LabelMainColor];
            [view addSubview:title];
            [title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(view);
                make.top.mas_equalTo(view).offset(AdaptationWidth(12));
                
            }];
            
            UILabel *detial = [[UILabel alloc]init];
            detial.numberOfLines = 0;
            detial.text = @"默认文字在前，图片在后。产品详情运用内容显性化，部分内容外露，用户先获得一部分信息后，有兴趣会滑动查看更多产品详情。";
            [detial setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(14)]];
            [detial setTextColor:LabelMainColor];
            [view addSubview:detial];
            [detial mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(view).offset(AdaptationWidth(16));
                make.right.mas_equalTo(view).offset(AdaptationWidth(-16));
                make.top.mas_equalTo(title.mas_bottom).offset(AdaptationWidth(6));
                make.bottom.mas_equalTo(view).offset(AdaptationWidth(-12));
                
            }];
        }
            break;
            
            
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    XBlockExec(self.jobDetailCellBlock ,indexPath.row);
    
}

@end
