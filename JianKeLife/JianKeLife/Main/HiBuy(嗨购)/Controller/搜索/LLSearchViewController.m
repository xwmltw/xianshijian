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


@interface LLSearchViewController ()<UISearchBarDelegate>

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
    if (!_searchView) {
        self.searchView = [[LLSearchView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64) hotArray:self.hotArray historyArray:self.historyArray];
        __weak LLSearchViewController *weakSelf = self;
        _searchView.tapAction = ^(NSString *str) {
            HiBuySearchVC *vc = [[HiBuySearchVC alloc]init];
            vc.keyStr = str;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
    }
    return _searchView;
}





- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!_searchBar.isFirstResponder) {
        [self.searchBar becomeFirstResponder];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 回收键盘
    [self.searchBar resignFirstResponder];
//    _searchSuggestVC.view.hidden = YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setBarButtonItem];
    self.view.backgroundColor = BackgroundColor;
    
//    [self.view addSubview:self.searchSuggestVC.view];
//    [self addChildViewController:_searchSuggestVC];
    
    WEAKSELF
    [XNetWork requestNetWorkWithUrl:Xquery_tb_product_keyword andModel:nil andSuccessBlock:^(ResponseModel *model) {
        [weakSelf.hotArray addObjectsFromArray:model.data[@"dataRows"]];
        [weakSelf.view addSubview:weakSelf.searchView];
    } andFailBlock:^(ResponseModel *model) {
        
    }];
}


- (void)setBarButtonItem
{
    [self.navigationItem setHidesBackButton:YES];
    // 创建搜索框
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(5, 7, self.view.frame.size.width, 30)];
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(titleView.frame) - 15, 30)];
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
    [cancleBtn setTitleColor:LabelMainColor forState:UIControlStateNormal];

    
    [titleView addSubview:searchBar];
    self.searchBar = searchBar;
    [self.searchBar becomeFirstResponder];
    self.navigationItem.titleView = titleView;
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
}


- (void)presentVCFirstBackClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


/** 点击取消 */
- (void)cancelDidClick
{
    [self.searchBar resignFirstResponder];
    
    [self.navigationController popViewControllerAnimated:YES];
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
    [self.navigationController popViewControllerAnimated:YES];
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
