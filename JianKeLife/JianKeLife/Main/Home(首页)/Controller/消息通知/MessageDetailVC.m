//
//  MessageDetailVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/5/10.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "MessageDetailVC.h"
#import "MessageModel.h"


@interface MessageDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) BaseTableView *tableView;
@property (nonatomic, strong) PageQueryRedModel *pageQueryRedModel;
@property (nonatomic, strong) NSMutableArray *messageList;
@property (nonatomic, strong) MessageModel *messageModel;
@end

@implementation MessageDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView  = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    WEAKSELF
    [XNetWork requestNetWorkWithUrl:Xget_message_list andModel:@{@"messageType":self.messageType,@"pageQueryReq":self.pageQueryRedModel} andSuccessBlock:^(ResponseModel *model) {
        [weakSelf.messageList addObjectsFromArray:model.data[@"dataRows"]];
        [weakSelf.tableView reloadData];
    } andFailBlock:^(ResponseModel *model) {
        
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messageList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptationWidth(164);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"MessageListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        self.messageModel = [MessageModel mj_objectWithKeyValues:self.messageList[indexPath.row]];
        UILabel *timeLab = [[UILabel alloc]init];
        [timeLab setText:self.messageModel.createTimeDesc];
        [timeLab setFont:[UIFont systemFontOfSize:AdaptationWidth(12)]];
        [timeLab setTextColor:LabelAssistantColor];
        [cell.contentView addSubview:timeLab];
        [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(cell);
            make.top.mas_equalTo(cell).offset(10);
        }];
        
        UIView *headView = [[UIView alloc]init];
        [headView setCornerValue:4];
        headView.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:headView];
        [headView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(loginLab1.mas_bottom).offset(20);
            make.left.mas_equalTo(self.view).offset(10);
            make.width.mas_equalTo(AdaptationWidth(355));
            make.height.mas_equalTo(AdaptationWidth(99));
        }];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - load
- (PageQueryRedModel *)pageQueryRedModel{
    if (!_pageQueryRedModel) {
        _pageQueryRedModel = [[PageQueryRedModel alloc]init];
    }
    return _pageQueryRedModel;
}
- (NSMutableArray *)messageList{
    if (!_messageList) {
        _messageList = [NSMutableArray array];
    }
    return _messageList;
}
- (MessageModel *)messageModel{
    if (!_messageModel) {
        _messageModel = [[MessageModel alloc]init];
    }
    return _messageModel;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
