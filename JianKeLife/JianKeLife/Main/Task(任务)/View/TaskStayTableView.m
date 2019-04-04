//
//  TaskStayTableView.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/19.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "TaskStayTableView.h"
#import "TaskTableViewCell.h"


@interface TaskStayTableView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TaskStayTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.backgroundColor = XColorWithRGB(248, 248, 248);
        [self registerNib:[UINib nibWithNibName:@"TaskTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TaskTableViewCell"];
        self.mj_header = [self.taskViewModel creatMjRefreshHeader];
        self.mj_footer = [self.taskViewModel creatMjRefresh];
        self.estimatedRowHeight = 0;
        self.taskViewModel.taskType = TaskTableViewTypeStay;
        if ([UserInfo sharedInstance].isSignIn){
            [self.taskViewModel requestTaskData];
        }
        
        BLOCKSELF
        [self.taskViewModel setTaskListBlock:^(id result) {
            [blockSelf.mj_header endRefreshing];
            [blockSelf.mj_footer endRefreshing];
            [blockSelf reloadData];
        }];
    }
    return self;
}
- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.taskViewModel.taskList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptationWidth(145);
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
    [lab setText:@"还没有领取产品,去首页看看吧~"];
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
    
    return  self.taskViewModel.taskList.count ? 0 : ScreenHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"TaskTableViewCell" owner:self options:nil]lastObject];

    }
    cell.taskTableView = TaskTableViewTypeStay;
    cell.model = [TaskModel mj_objectWithKeyValues:self.taskViewModel.taskList[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    cell.taskCellBlock = self.taskStayBtnBlcok;
    [cell setTaskCellBlock:^(id result) {
        XBlockExec(self.taskStayBtnBlcok,result,self.taskViewModel.taskList[indexPath.row]);
    }];
    
    BLOCKSELF
    cell.taskCellCancelBlock = ^(id result) {
        [blockSelf.taskViewModel requestTaskCancelData:self.taskViewModel.taskList[indexPath.row][@"productApplyId"]];
    };
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XBlockExec(self.taskStayCellselect ,self.taskViewModel.taskList[indexPath.row][@"productNo"]);
}

- (TaskViewModel *)taskViewModel{
    if (!_taskViewModel) {
        _taskViewModel = [[TaskViewModel alloc]init];
    }
    return _taskViewModel;
}
@end
