//
//  TaskIngTableView.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/19.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "TaskIngTableView.h"
#import "TaskTableViewCell.h"


@interface TaskIngTableView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TaskIngTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.backgroundColor = XColorWithRGB(248, 248, 248);
        [self registerNib:[UINib nibWithNibName:@"TaskTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TaskTableViewCell"];
        self.estimatedRowHeight = 0;
        self.mj_header = [self.taskViewModel creatMjRefreshHeader];
        self.mj_footer = [self.taskViewModel creatMjRefresh];
        self.taskViewModel.taskType = TaskTableViewTypeIng;
        [self.taskViewModel requestTaskData];
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"TaskTableViewCell" owner:self options:nil]lastObject];
        
    }
    cell.taskTableView = TaskTableViewTypeIng;
    cell.model = [TaskModel mj_objectWithKeyValues:self.taskViewModel.taskList[indexPath.row]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setTaskCellBlock:^(id result) {
        XBlockExec(self.taskIngBtnBlcok,result,self.taskViewModel.taskList[indexPath.row][@"productApplyId"]);
    }];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (TaskViewModel *)taskViewModel{
    if (!_taskViewModel) {
        _taskViewModel = [[TaskViewModel alloc]init];
    }
    return _taskViewModel;
}
@end
