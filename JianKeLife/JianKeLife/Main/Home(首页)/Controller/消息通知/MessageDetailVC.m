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
    self.tableView.backgroundColor = BackgroundColor;
    [self.view addSubview:self.tableView];
    
    WEAKSELF
    [XNetWork requestNetWorkWithUrl:Xget_message_list andModel:@{@"messageType":self.messageType,@"pageQueryReq":[self.pageQueryRedModel mj_keyValues]} andSuccessBlock:^(ResponseModel *model) {
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
    [lab setText:@"咦，还没有数据哦～"];
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
    return self.messageList.count ? 0 : ScreenHeight;
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
            make.top.mas_equalTo(timeLab.mas_bottom).offset(6);
            make.left.mas_equalTo(cell).offset(10);
            make.width.mas_equalTo(AdaptationWidth(355));
            make.height.mas_equalTo(AdaptationWidth(99));
        }];
        
        UILabel *titleLab = [[UILabel alloc]init];

        [titleLab setText:self.messageModel.messageTitle];
        [titleLab setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
        [titleLab setTextColor:LabelMainColor];
        [headView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(headView).offset(AdaptationWidth(16));
            make.top.mas_equalTo(headView).offset(AdaptationWidth(16));
        }];
        
        UILabel *detailLab = [[UILabel alloc]init];
        detailLab.numberOfLines = 0;

        [detailLab setText:self.messageModel.messageContent];
        [detailLab setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
        [detailLab setTextColor:LabelAssistantColor];
        [headView addSubview:detailLab];
        [detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(headView).offset(AdaptationWidth(16));
            make.bottom.mas_equalTo(headView).offset(AdaptationWidth(-29));
            make.right.mas_equalTo(headView).offset(AdaptationWidth(-16));
            make.top.mas_equalTo(titleLab.mas_bottom).offset(AdaptationWidth(10));
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
