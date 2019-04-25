//
//  HiBuySearchVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/4/24.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "HiBuySearchVC.h"
#import "JSDropDownMenu.h"
#import "HiBuyProductdetialVC.h"
#import "HiBuyTableViewCell.h"
#import "hiBuyViewModel.h"

@interface HiBuySearchVC ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,JSDropDownMenuDelegate,JSDropDownMenuDataSource>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) JSDropDownMenu *dropDownMenu;
@property (nonatomic ,strong) HiBuyViewModel *hiBuyViewModel;
@property (nonatomic ,strong) NSArray *allAry ,*salesAry ,*priceAry ,*chooseAry;
@property (nonatomic ,assign) NSInteger allIndex, salesIndex, priceIndex,chooseIndex;
@end

@implementation HiBuySearchVC
- (void)setBackNavigationBarItem{
    [self.navigationItem setHidesBackButton:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackgroundColor;
    
    //搜索框
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    searchBar.delegate = self;
    searchBar.placeholder = @"请输入搜索关键词";
    searchBar.showsCancelButton = YES;
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    searchBar.text = self.keyStr;
    
    UIButton *btn = [searchBar valueForKey:@"cancelButton"];
    btn.enabled = YES;
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn setTitleColor:LabelMainColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = searchBar;
    
    [self.view addSubview:self.dropDownMenu];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.dropDownMenu.mas_bottom).offset(2);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    self.tableView.estimatedRowHeight = 146;
    [self.tableView registerNib:[UINib nibWithNibName:@"HiBuyTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HiBuyTableViewCell"];
    self.tableView.mj_footer = [self.hiBuyViewModel creatMjRefresh];
    
    
    self.hiBuyViewModel.hiBuyProductQueryModel.keywords = self.keyStr;
    [self.hiBuyViewModel requestTypeDate];
    WEAKSELF
    [self.hiBuyViewModel setHiBuyTypeBlock:^(id result) {
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf.tableView reloadData];
    }];
    
}
- (void)btnOnClick:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma  mark - UISearchBar delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    UIButton *cancelBtn = [searchBar valueForKeyPath:@"cancelButton"]; //首先取出cancelBtn
    cancelBtn.enabled = YES;
    
//    self.collectionView.searchVieModel.keywords = searchBar.text;
//    [self.collectionView.searchVieModel.productList removeAllObjects];
//    self.collectionView.searchVieModel.pageQueryRedModel.page = @1;
//    [self.collectionView.searchVieModel requestData];
    self.hiBuyViewModel.hiBuyProductQueryModel.keywords = searchBar.text;
    [self.hiBuyViewModel requestTypeDate];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"icon_noData"];
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view);
        make.top.mas_equalTo(view).offset(50);
        
    }];
    UILabel *lab = [[UILabel alloc]init];
    [lab setText:@"暂无产品,去首页看看~"];
    [lab setFont:[UIFont systemFontOfSize:16]];
    [lab setTextColor:LabelMainColor];
    [view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view);
        make.top.mas_equalTo(imageView.mas_bottom).offset(34);
    }];
    
    
    return self.hiBuyViewModel.hiBuyTypeList.count ? nil : view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return  self.hiBuyViewModel.hiBuyTypeList.count ? 0 : ScreenHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.hiBuyViewModel.hiBuyTypeList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 146;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HiBuyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HiBuyTableViewCell"];
    if (!cell) {
        cell = [[HiBuyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HiBuyTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.model = [HiBuyProductModel mj_objectWithKeyValues:self.hiBuyViewModel.hiBuyTypeList[indexPath.row]];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HiBuyProductdetialVC *vc = [[HiBuyProductdetialVC alloc]init];
    vc.productId = self.hiBuyViewModel.hiBuyTypeList[indexPath.row][@"id"];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark - dropDownMenu

- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu{
    
    return 4;
}
- (BOOL)displayByCollectionViewInColumn:(NSInteger)column{
    
    return NO;
}
- (BOOL)haveRightTableViewInColumn:(NSInteger)column{
    return NO;
}
- (CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
    return 1;
}
- (NSInteger)currentLeftSelectedRow:(NSInteger)column{
    switch (column) {
        case 0:
            return self.allIndex;
            break;
        case 1:
            return self.salesIndex;
            break;
        case 2:
            return self.priceIndex;
            break;
        case 3:
            return self.chooseIndex;
            break;
            
        default:
            break;
    }
    return 0;
}
- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
    
    switch (column) {
        case 0:
            return self.allAry.count;
            break;
        case 1:
            return self.salesAry.count;
            break;
        case 2:
            return self.priceAry.count;
            break;
        case 3:
            return self.chooseAry.count;
            break;
            
        default:
            break;
    }
    return 0;
}

-(NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{
    switch (column) {
        case 0:
            return self.allAry[self.allIndex];
            break;
        case 1:
            return self.salesAry[self.salesIndex];
            break;
        case 2:
            return self.priceAry[self.priceIndex];
            break;
        case 3:
            return self.chooseAry[self.chooseIndex];
            break;
            
        default:
            break;
    }
    
    return @"xwm";
}
- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath{
    [self.tableView setContentOffset:self.tableView.contentOffset animated:NO];
    
    switch (indexPath.column) {
        case 0:
            return self.allAry[indexPath.row];
            break;
        case 1:
            return self.salesAry[indexPath.row];
            break;
        case 2:
            return self.priceAry[indexPath.row];
            break;
        case 3:
            return self.chooseAry[indexPath.row];
            break;
            
        default:
            break;
    }
    
    return @"xwm";
}
- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath{
    switch (indexPath.column) {
        case 0:
            self.hiBuyViewModel.hiBuyProductQueryModel.orderType = @(indexPath.row);
            self.allIndex = indexPath.row;
            [self.hiBuyViewModel requestTypeDate];
            break;
        case 1:
            
            self.hiBuyViewModel.hiBuyProductQueryModel.orderType = indexPath.row ? @(indexPath.row + 5) : 0;
            self.salesIndex = indexPath.row;
            [self.hiBuyViewModel requestTypeDate];
            break;
        case 2:
            
            self.hiBuyViewModel.hiBuyProductQueryModel.orderType = indexPath.row ? @(indexPath.row + 7) : 0;
            self.priceIndex = indexPath.row;
            [self.hiBuyViewModel requestTypeDate];
            break;
        case 3:
            self.chooseIndex = indexPath.row;
            break;
            
        default:
            break;
    }
}
#pragma mark-懒加载
- (NSArray *)allAry{
    if (!_allAry) {
        _allAry = [NSArray arrayWithObjects:@"综合",@"佣金金额由高到低",@"佣金金额由低到高",@"优惠券由高到低",@"优惠券由低到高", nil];
    }
    return _allAry;
}
- (NSArray *)salesAry{
    if (!_salesAry) {
        _salesAry = [NSArray arrayWithObjects:@"由高到低",@"由低到高", nil];
    }
    return _salesAry;
}
- (NSArray *)priceAry{
    if (!_priceAry) {
        _priceAry = [NSArray arrayWithObjects:@"由高到低",@"由低到高", nil];
    }
    return _priceAry;
}
- (NSArray *)chooseAry{
    if (!_chooseAry) {
        _chooseAry = [NSArray arrayWithObjects:@"最低金额",@"最高金额", nil];
    }
    return _chooseAry;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (JSDropDownMenu *)dropDownMenu{
    if (!_dropDownMenu) {
        
        _dropDownMenu = [[JSDropDownMenu alloc]initWithOrigin:CGPointMake(0, 0) andHeight:45];
        
        _dropDownMenu.indicatorColor = XColorWithRBBA(34, 58, 80, 0.68);
        _dropDownMenu.indicatorHightColor = blueColor;
        _dropDownMenu.separatorColor = XColorWithRGB(233, 233, 235);
        _dropDownMenu.textColor = XColorWithRBBA(34, 58, 80, 0.68);
        _dropDownMenu.textHightColor = blueColor;
        _dropDownMenu.dataSource = self;
        _dropDownMenu.delegate = self;
    }
    return _dropDownMenu;
}
- (HiBuyViewModel *)hiBuyViewModel{
    if (!_hiBuyViewModel) {
        _hiBuyViewModel = [[HiBuyViewModel alloc]init];
    }
    return _hiBuyViewModel;
}
@end
