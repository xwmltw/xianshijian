//
//  HighShareVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/5/22.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "HighShareVC.h"
#import "JSDropDownMenu.h"
#import "HiBuyProductdetialVC.h"
#import "HiBuyTableViewCell.h"
#import "HighShareModelView.h"
#import "SaiXuanView.h"
@interface HighShareVC ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,JSDropDownMenuDelegate,JSDropDownMenuDataSource>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) JSDropDownMenu *dropDownMenu;
@property (nonatomic ,strong) HighShareModelView *highShareModelView;
@property (nonatomic ,strong) NSArray *allAry ,*salesAry ,*priceAry ,*chooseAry;
@property (nonatomic ,assign) NSInteger allIndex, salesIndex, priceIndex,chooseIndex;
@property (nonatomic ,strong) SaiXuanView *saiXuanView;
@end

@implementation HighShareVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UIImageView *image = [[UIImageView alloc]init];
    [image setImage: [UIImage imageNamed:@"icon_high_headbg"]];
    [self.view addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.view);
        make.height.mas_equalTo(AdaptationWidth(171));
    }];
    
    UILabel *title = [[UILabel alloc]init];
    title.text = self.highListTitle;
    [title setFont:[UIFont systemFontOfSize:AdaptationWidth(20)]];
    [title setTextColor:[UIColor whiteColor]];
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(30);
        make.centerX.mas_equalTo(self.view);
    }];
    
    UIButton *blackBtn = [[UIButton alloc]init];
    [blackBtn setImage:[UIImage imageNamed:@"icon_back-white"] forState:UIControlStateNormal];
    [blackBtn addTarget:self action:@selector(btnBlackClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:blackBtn];
    [blackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(30);
        make.left.mas_equalTo(self.view).offset(16);
        make.height.width.mas_equalTo(AdaptationWidth(30));
    }];
    
    [self.view addSubview:self.dropDownMenu];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.dropDownMenu.mas_bottom).offset(5);
        make.bottom.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view).offset(AdaptationWidth(10));
        make.right.mas_equalTo(self.view).offset(AdaptationWidth(-10));
    }];
    [self.tableView setCornerValue:6];
    self.tableView.estimatedRowHeight = 146;
    [self.tableView registerNib:[UINib nibWithNibName:@"HiBuyTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HiBuyTableViewCell"];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.mj_footer = [self.highShareModelView creatMjRefresh];
    
    
//    self.hiBuyViewModel.hiBuyProductQueryModel.keywords = self.keyStr;
    [self.highShareModelView requestTypeDate];
    WEAKSELF
    [self.highShareModelView setHiBuyTypeBlock:^(id result) {
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf.tableView reloadData];
    }];
    
    [self.highShareModelView setHiBuyQuerBlock:^(id result) {
        [weakSelf.tableView reloadData];
        if (weakSelf.highShareModelView.hiBuyTypeList.count) {
            //回到顶部
            NSIndexPath* indexPat = [NSIndexPath indexPathForRow:0 inSection:0];
            [weakSelf.tableView scrollToRowAtIndexPath:indexPat atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
        
    }];
    [XNotificationCenter addObserver:self selector:@selector(missBackgrond) name:@"backgroundTapped" object:nil];
}
- (void)missBackgrond{
    [self.saiXuanView removeFromSuperview];
}
- (void)btnBlackClick:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
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
    
    
    return self.highShareModelView.hiBuyTypeList.count ? nil : view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return  self.highShareModelView.hiBuyTypeList.count ? 0 : ScreenHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.highShareModelView.hiBuyTypeList.count;
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
    
    cell.model = [HiBuyProductModel mj_objectWithKeyValues:self.highShareModelView.hiBuyTypeList[indexPath.row]];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HiBuyProductdetialVC *vc = [[HiBuyProductdetialVC alloc]init];
    vc.productId = self.highShareModelView.hiBuyTypeList[indexPath.row][@"id"];
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
    
    [self.saiXuanView removeFromSuperview];
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
    //    switch (column) {
    //        case 0:
    //            return self.allAry[self.allIndex];
    //            break;
    //        case 1:
    //            return self.salesAry[self.salesIndex];
    //            break;
    //        case 2:
    //            return self.priceAry[self.priceIndex];
    //            break;
    //        case 3:
    //
    //            return self.chooseAry[self.chooseIndex];
    //            break;
    //
    //        default:
    //            break;
    //    }
    
    NSArray *arr = @[@"综合",@"销量",@"价格",@"筛选"];
    return arr[column];
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
            [self.view addSubview:self.saiXuanView];
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
            self.highShareModelView.hiBuyProductQueryModel.orderType = @(indexPath.row);
            self.allIndex = indexPath.row;
            [self.highShareModelView requestTypeDate];
            break;
        case 1:
            
            self.highShareModelView.hiBuyProductQueryModel.orderType = indexPath.row ? @(indexPath.row + 5) : 0;
            self.salesIndex = indexPath.row;
            [self.highShareModelView requestTypeDate];
            break;
        case 2:
            
            self.highShareModelView.hiBuyProductQueryModel.orderType = indexPath.row ? @(indexPath.row + 7) : 0;
            self.priceIndex = indexPath.row;
            [self.highShareModelView requestTypeDate];
            break;
        case 3:
            self.chooseIndex = indexPath.row;
            break;
            
        default:
            break;
    }
    [self.saiXuanView removeFromSuperview];
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
        
        _dropDownMenu = [[JSDropDownMenu alloc]initWithOrigin:CGPointMake(0, 66) andHeight:45];
        
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
- (HighShareModelView *)highShareModelView{
    if (!_highShareModelView) {
        _highShareModelView = [[HighShareModelView alloc]init];
    }
    return _highShareModelView;
}
- (SaiXuanView *)saiXuanView{
    if (!_saiXuanView) {
        _saiXuanView = [[SaiXuanView alloc]initWithFrame:CGRectMake(0, self.dropDownMenu.Y+46, ScreenWidth, AdaptationWidth(145))];
        [self.view addSubview:_saiXuanView];
        WEAKSELF
        [_saiXuanView setBtnBlock:^(NSString *min,NSString *max) {
            if(min.length == 0) {
                [ProgressHUD showProgressHUDInView:nil withText:@"请输入最低价格" afterDelay:1];
                return ;
            }
            if(max.length == 0) {
                [ProgressHUD showProgressHUDInView:nil withText:@"请输入最高价格" afterDelay:1];
                return ;
            }
            if ([min doubleValue] >[max doubleValue]) {
                [ProgressHUD showProgressHUDInView:nil withText:@"最高的价格不可以比最低价还小哟~" afterDelay:1];
                return ;
            }
            //回到顶部
            //             [weakSelf.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
            weakSelf.highShareModelView.hiBuyProductQueryModel.minPrice = @([min doubleValue]);
            weakSelf.highShareModelView.hiBuyProductQueryModel.maxPrice = @([max doubleValue]);
            [weakSelf.highShareModelView requestTypeDate];
            [_saiXuanView removeFromSuperview];
            [weakSelf.dropDownMenu hideMenu] ;
        }];
        //        [_saiXuanView mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.right.mas_equalTo(self.view);
        //            make.height.mas_equalTo(AdaptationWidth(143));
        //            make.top.mas_equalTo(self)
        //        }];
    }
    return _saiXuanView;
}
- (void)dealloc{
    [XNotificationCenter removeObserver:@"backgroundTapped"];
}

@end
