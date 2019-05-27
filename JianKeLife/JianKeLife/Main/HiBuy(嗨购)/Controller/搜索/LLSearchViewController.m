//
//  LLSearchViewController.m
//  LLSearchView
//
//  Created by 王龙龙 on 2017/7/25.
//  Copyright © 2017年 王龙龙. All rights reserved.
//

#import "LLSearchViewController.h"
#import "LLSearchView.h"
#import "HiBuySearchVC.h"
#import "SearchVC.h"


@interface LLSearchViewController ()<UISearchBarDelegate>
{
    UIView *titleView;
}
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) LLSearchView *searchView;
@property (nonatomic, strong) NSMutableArray *hotArray;
@property (nonatomic, strong) NSMutableArray *historyArray;


@end

@implementation LLSearchViewController

- (NSMutableArray *)hotArray
{
    if (!_hotArray) {
        self.hotArray = [NSMutableArray array];
    }
    return _hotArray;
}

- (NSMutableArray *)historyArray
{
    if (!_historyArray) {
        _historyArray = [NSKeyedUnarchiver unarchiveObjectWithFile:KHistorySearchPath];
        if (!_historyArray) {
            self.historyArray = [NSMutableArray array];
        }
    }
    return _historyArray;
}


- (LLSearchView *)searchView
{
    [_searchView removeFromSuperview];
//    if (!_searchView) {
        _searchView = [[LLSearchView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64) hotArray:self.hotArray historyArray:self.historyArray];
        __weak LLSearchViewController *weakSelf = self;
        _searchView.tapAction = ^(NSString *str) {
            HiBuySearchVC *vc = [[HiBuySearchVC alloc]init];
            vc.keyStr = str;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
//    }
    return _searchView;
}





- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    if (!_searchBar.isFirstResponder) {
//        [self.searchBar becomeFirstResponder];
//    }
    WEAKSELF
    [XNetWork requestNetWorkWithUrl:Xquery_tb_product_keyword andModel:nil andSuccessBlock:^(ResponseModel *model) {
        weakSelf.hotArray = model.data[@"dataRows"];
        [weakSelf.view addSubview:weakSelf.searchView];
    } andFailBlock:^(ResponseModel *model) {
        
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 回收键盘
//    [self.searchBar resignFirstResponder];
//    _searchSuggestVC.view.hidden = YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setBarButtonItem];
    self.view.backgroundColor = BackgroundColor;
    
//    [self.view addSubview:self.searchSuggestVC.view];
//    [self addChildViewController:_searchSuggestVC];
    
    
}


- (void)setBarButtonItem
{
    
    [self.navigationItem setHidesBackButton:YES];
    // 创建搜索框
    titleView = [[UIView alloc] initWithFrame:CGRectMake(5, 7, self.view.frame.size.width, 30)];
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(58, 0, CGRectGetWidth(titleView.frame) - 78, 30)];
    searchBar.placeholder = @"搜索商品或宝贝标题";
//    searchBar.backgroundImage = [UIImage imageNamed:@"clearImage"];
    searchBar.delegate = self;
    searchBar.showsCancelButton = YES;
    UIView *searchTextField = searchTextField = [searchBar valueForKey:@"_searchField"];
    searchTextField.backgroundColor = [UIColor colorWithRed:234/255.0 green:235/255.0 blue:237/255.0 alpha:1];
    [searchBar setImage:[UIImage imageNamed:@"sort_magnifier"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    UIButton *cancleBtn = [searchBar valueForKey:@"cancelButton"];
    //修改标题和标题颜色
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [cancleBtn setTitleColor:XColorWithRGB(96, 96, 96) forState:UIControlStateNormal];

    UIButton *selectBtn = [[UIButton alloc]init];
    [selectBtn setCornerValue:4];
    selectBtn.backgroundColor = XColorWithRGB(238, 238, 238);
//    [selectBtn setImage:[UIImage imageNamed:@"icon_search_select"] forState:UIControlStateNormal];
    [selectBtn setTitle:@"▼ 商品" forState:UIControlStateNormal];
    [selectBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [selectBtn setTitleColor:XColorWithRGB(96, 96, 96) forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(btnOnclick:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:selectBtn];
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(self->titleView);
        make.width.mas_equalTo(58);
        make.height.mas_equalTo(30);
    }];
    
    [titleView addSubview:searchBar];
    self.searchBar = searchBar;
//    [self.searchBar becomeFirstResponder];
    self.navigationItem.titleView = titleView;
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
}


- (void)presentVCFirstBackClick:(UIButton *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


/** 点击取消 */
- (void)cancelDidClick
{
    [self.searchBar resignFirstResponder];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)btnOnclick:(UIButton *)btn{
//    UIButton *actiBtn = [[UIButton alloc]init];
//    [actiBtn setBorderWidth:1 andColor:XColorWithRGB(238, 238, 238)];
////    actiBtn.backgroundColor = XColorWithRGB(238, 238, 238);
//    //    [selectBtn setImage:[UIImage imageNamed:@"icon_search_select"] forState:UIControlStateNormal];
//    [actiBtn setTitle:@"活动" forState:UIControlStateNormal];
//    [actiBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
//    [actiBtn setTitleColor:XColorWithRGB(96, 96, 96) forState:UIControlStateNormal];
//    [actiBtn addTarget:self action:@selector(btnOnclick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:actiBtn];
//    [actiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(btn);
//        make.top.mas_equalTo(btn.mas_bottom);
//        make.width.mas_equalTo(58);
//        make.height.mas_equalTo(30);
//    }];
    SearchVC *vc = [[SearchVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setHistoryArrWithStr:(NSString *)str
{
    for (int i = 0; i < _historyArray.count; i++) {
        if ([_historyArray[i] isEqualToString:str]) {
            [_historyArray removeObjectAtIndex:i];
            break;
        }
    }
    [_historyArray insertObject:str atIndex:0];
    [NSKeyedArchiver archiveRootObject:_historyArray toFile:KHistorySearchPath];
}


#pragma mark - UISearchBarDelegate -


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self setHistoryArrWithStr:searchBar.text];
    HiBuySearchVC *vc = [[HiBuySearchVC alloc]init];
    vc.keyStr = searchBar.text;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
