//
//  MyPersonTableView.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/19.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "MyPersonTableView.h"
#import "MyPersonTableViewCell.h"

@interface MyPersonTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MyPersonTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
//        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.tableFooterView = [[UIView alloc]init];
        self.backgroundColor = XColorWithRGB(248, 248, 248);
        [self registerNib:[UINib nibWithNibName:@"MyPersonTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyPersonTableViewCell"];
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
    return AdaptationWidth(63);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    
    UILabel *title = [[UILabel alloc]init];
    title.text = @"一级人脉（3）";
    [title setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
    [title setTextColor:LabelAssistantColor];
    [view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view).offset(AdaptationWidth(16));
        make.centerY.mas_equalTo(view);
    }];
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyPersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyPersonTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MyPersonTableViewCell" owner:self options:nil]lastObject];
        
    }
  
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
