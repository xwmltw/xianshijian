//
//  ExpectTableView.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/27.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "ExpectTableView.h"
#import "ExpectTableViewCell.h"

@interface  ExpectTableView ()<UITableViewDelegate ,UITableViewDataSource>

@end

@implementation ExpectTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.backgroundColor = XColorWithRGB(248, 248, 248);
        self.delegate = self;
        self.dataSource = self;
        self.estimatedRowHeight = 0;
   
        
        WEAKSELF
        [self.expectViewModel setExpectListBlock:^(id result) {
            
            [weakSelf reloadData];
        }];
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]init];

    UIImageView *imageView = [[UIImageView alloc]init];
    [view addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view).offset(10);
        make.centerY.mas_equalTo(view);
        make.width.mas_equalTo(AdaptationWidth(20));
    }];
    
    UILabel *loginLab2 = [[UILabel alloc]init];
    [loginLab2 setText:@"收益即将到账，抓紧时间完成吧"];
    [loginLab2 setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(12)]];
    
    [view addSubview:loginLab2];
    [loginLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_right).offset(AdaptationWidth(2));
        make.centerY.mas_equalTo(view);
        
    }];
    
    
    UILabel *tips = [[UILabel alloc]init];
    [tips setText:[NSString stringWithFormat:@"预计收益￥%.2f",[self.expectViewModel.expectModel.currTypeAllEstimateProfit doubleValue]/100]];
    [tips setFont:[UIFont systemFontOfSize:AdaptationWidth(12)]];
    [tips setTextColor:XColorWithRGB(255, 69, 69)];
    [view addSubview:tips];
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(view).offset(-10);
        make.centerY.mas_equalTo(view);
    }];
    
    switch (self.expectViewModel.viewModelType) {
        case ExpectTableViewTypeTesk:
            [imageView setImage:[UIImage imageNamed:@"icon_task_noti"]];
            view.backgroundColor = XColorWithRGB(215, 236, 235);
            [loginLab2 setTextColor:XColorWithRGB(56, 181, 173)];
            
            break;
        case ExpectTableViewTypeShare:
            [imageView setImage:[UIImage imageNamed:@"icon_share_noti"]];
            view.backgroundColor = XColorWithRGB(249, 237, 205);
            [loginLab2 setTextColor:XColorWithRGB(255, 162, 0)];
            
             break;
            break;
        case ExpectTableViewTypeConnection:
            [imageView setImage:[UIImage imageNamed:@"icon_connection_noti"]];
            view.backgroundColor = XColorWithRGB(249, 223, 223);
            [loginLab2 setTextColor:XColorWithRGB(255, 68, 68)];
            
             break;
            break;
            
        default:
            break;
    }
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AdaptationWidth(28);
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"icon_noData"];
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view);
        make.top.mas_equalTo(view).offset(140);
        
    }];
    UILabel *lab = [[UILabel alloc]init];
    [lab setText:@"暂无收益,去首页看看吧~"];
    [lab setFont:[UIFont systemFontOfSize:16]];
    [lab setTextColor:LabelMainColor];
    [view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view);
        make.top.mas_equalTo(imageView.mas_bottom).offset(34);
    }];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return  self.expectViewModel.expectList.count ? 0 : ScreenHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    NSDictionary * attributes = @{
                                  NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(16)],
                                  NSParagraphStyleAttributeName: paragraphStyle
                                  };
    CGSize textRect = CGSizeMake(AdaptationWidth(235), MAXFLOAT);
    CGFloat textHeight = [self.expectViewModel.expectList[indexPath.row][@"profitAmountDesc"] boundingRectWithSize: textRect
                                                    options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                 attributes:attributes
                                                    context:nil].size.height;
//    self.jobDetailViewModel.productModel.cell2Width =  AdaptationWidth(textHeight + 70) ;
//
//        CGSize detailSize = [self.expectViewModel.expectList[indexPath.row][@"profitAmountDesc"] boundingRectWithSize:CGSizeMake(235, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:nil context:nil].size;
//    MyLog(@"%@",self.expectViewModel.expectList[indexPath.row][@"profitAmountDesc"]);
    CGFloat cellH = 50 + textHeight;
    return AdaptationWidth(cellH);
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.expectViewModel.expectList.count;
//    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ExpectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExpectTableViewCell"];
    if (!cell) {
        cell = [[ExpectTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ExpectTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = XColorWithRGB(248, 248, 248);
    }
    cell.model = [ExpectCellModel mj_objectWithKeyValues:self.expectViewModel.expectList[indexPath.row]];
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (ExpectViewModel *)expectViewModel{
    if (!_expectViewModel) {
        _expectViewModel  =[[ExpectViewModel alloc]init];
    }
    return _expectViewModel;
}

@end
