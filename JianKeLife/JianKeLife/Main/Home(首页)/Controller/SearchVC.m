//
//  SearchVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/23.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "SearchVC.h"

#import "SearchCollectionView.h"

#import "JobDetailVC.h"
#import "LLSearchViewController.h"

@interface SearchVC ()<UISearchBarDelegate>

@property (nonatomic ,strong)SearchCollectionView *collectionView;

@end

@implementation SearchVC
- (void)setBackNavigationBarItem{
    [self.navigationItem setHidesBackButton:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackgroundColor;
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(5, 7, self.view.frame.size.width, 30)];
    //搜索框
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(58, 0, ScreenWidth-78, 30)];
    searchBar.delegate = self;
    searchBar.placeholder = @"请输入搜索关键词";
    searchBar.showsCancelButton = YES;
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    
    
    UIButton *btn = [searchBar valueForKey:@"cancelButton"];
    btn.enabled = YES;
    [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [btn setTitleColor:XColorWithRGB(96, 96, 96) forState:UIControlStateNormal];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:searchBar];
    
    self.navigationItem.titleView = titleView;
    
    UIButton *selectBtn = [[UIButton alloc]init];
    [selectBtn setCornerValue:4];
    selectBtn.backgroundColor = XColorWithRGB(238, 238, 238);
    //    [selectBtn setImage:[UIImage imageNamed:@"icon_search_select"] forState:UIControlStateNormal];
    [selectBtn setTitle:@"▼ 活动" forState:UIControlStateNormal];
    [selectBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [selectBtn setTitleColor:XColorWithRGB(96, 96, 96) forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(btnOnclickSelect:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:selectBtn];
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(titleView);
        make.width.mas_equalTo(58);
        make.height.mas_equalTo(30);
    }];
    
    
    self.collectionView = [[SearchCollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:nil];
    self.view  = self.collectionView;
    
    BLOCKSELF
    [self.collectionView setCollectionSelectBlock:^(NSDictionary *result) {
        JobDetailVC *vc = [[JobDetailVC alloc]init];
        vc.productNo = result[@"productNo"];
        [blockSelf.navigationController pushViewController:vc animated:YES];
    }];
}
- (void)btnOnClick:(UIButton *)btn{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)btnOnclickSelect:(UIButton *)btn{
    LLSearchViewController *vc = [[LLSearchViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma  mark - UISearchBar delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    UIButton *cancelBtn = [searchBar valueForKeyPath:@"cancelButton"]; //首先取出cancelBtn
    cancelBtn.enabled = YES;

    self.collectionView.searchVieModel.keywords = searchBar.text;
    [self.collectionView.searchVieModel.productList removeAllObjects];
    self.collectionView.searchVieModel.pageQueryRedModel.page = @1;
    [self.collectionView.searchVieModel requestData];
}

@end
