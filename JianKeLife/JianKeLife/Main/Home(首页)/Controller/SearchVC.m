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
    
    //搜索框
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    searchBar.delegate = self;
    searchBar.placeholder = @"请输入搜索关键词";
    searchBar.showsCancelButton = YES;
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
//    for (UIView *view in [[searchBar.subviews lastObject]subviews]) {
//        if ([view isKindOfClass:[UIButton class]]) {
//            UIButton *btn = (UIButton *)view;
//            btn.enabled = YES;
//            [btn setTitle:@"取消" forState:UIControlStateNormal];
//            [btn setTitleColor:LabelMainColor forState:UIControlStateNormal];
//            [btn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
//        }
//    }
    
    UIButton *btn = [searchBar valueForKey:@"cancelButton"];
    btn.enabled = YES;
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn setTitleColor:LabelMainColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = searchBar;
    
    
    
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
    [self.navigationController popViewControllerAnimated:YES];
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
