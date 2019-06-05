//
//  MyPersonSecondVC.m
//  JianKeLife
//
//  Created by 肖伟民 on 2019/3/28.
//  Copyright © 2019 xwm. All rights reserved.
//

#import "MyPersonSecondVC.h"
#import "MyPersonTableViewCell.h"
@interface MyPersonSecondVC()<UITableViewDelegate ,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic, strong) PageQueryRedModel *pageQueryRedModel;
@property (nonatomic, strong) NSMutableArray *myPersonSecondList;
@end
@implementation MyPersonSecondVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"二级人脉（%@）",self.model.firstConnectionsCount.description];
    self.view.backgroundColor = BackgroundColor;
    [self getData];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"MyPersonTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyPersonTableViewCell2"];

    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
}
- (void)getData{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.model.id forKey:@"firstConnectionsId"];
    [dic setObject:[self.pageQueryRedModel mj_keyValues] forKey:@"pageQueryReq"];
    WEAKSELF
    [XNetWork requestNetWorkWithUrl:Xget_second_connections_info andModel:dic andSuccessBlock:^(ResponseModel *model) {
        [weakSelf.myPersonSecondList addObjectsFromArray: model.data[@"dataRows"]];
        [weakSelf.tableView reloadData];
    } andFailBlock:^(ResponseModel *model) {
        
    }];
}
- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.myPersonSecondList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptationWidth(63);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyPersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyPersonTableViewCell2"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MyPersonTableViewCell2" owner:self options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.connectionFirstModel = [ConnectionFirstModel mj_objectWithKeyValues:self.myPersonSecondList[indexPath.row]];
    cell.labNum.hidden = YES;
    cell.rightImage.hidden = YES;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (NSMutableArray *)myPersonSecondList{
    if (!_myPersonSecondList) {
        _myPersonSecondList = [NSMutableArray array];
    }
    return _myPersonSecondList;
}
- (PageQueryRedModel *)pageQueryRedModel{
    if (!_pageQueryRedModel) {
        _pageQueryRedModel = [[PageQueryRedModel alloc]init];
    }
    return _pageQueryRedModel;
}
@end
