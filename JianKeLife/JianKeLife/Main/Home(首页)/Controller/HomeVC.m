//
//  HomeVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/18.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "HomeVC.h"
#import "HomeCollectionView.h"
#import "JobDetailVC.h"
#import "SearchVC.h"
#import "BaseWebVC.h"
#import "SpecialJobListVC.h"

@interface HomeVC ()
@property (nonatomic ,strong) HomeCollectionView *collectionView;

@end

@implementation HomeVC
- (void)setBackNavigationBarItem{};
- (void)viewDidLoad {
    [super viewDidLoad];
    WEAKSELF
    [XNetWork requestNetWorkWithUrl:Xget_global_info andModel:nil andSuccessBlock:^(ResponseModel *model) {
        ClientGlobalInfo *clientGlobalInfo = [[ClientGlobalInfo alloc]init];
        clientGlobalInfo = [ClientGlobalInfo mj_objectWithKeyValues:model.data];
        [clientGlobalInfo setClientGlobalInfoModel];

        [weakSelf getData];
    } andFailBlock:^(id result) {
        
    }];
    
    
}
- (void)getData{
    

    [self creatSearchBtn];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //    flowLayout.minimumLineSpacing = 0;
    //    flowLayout.minimumInteritemSpacing = -1;
    self.collectionView = [[HomeCollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    if (self.clientGlobalInfo.bannerAdList.count) {
        [self.collectionView.headArray addObject:@(HomeCollectionHeadBanner)];
    }
    if (self.clientGlobalInfo.specialEntryList.count) {
        [self.collectionView.headArray addObject:@(HomeCollectionHeadSpecial)];
    }
    
    [self.collectionView.headArray addObject:@(HomeCollectionHeadHot)];
    self.view  = self.collectionView;
    [self scrollViewSelect];
    [self specialViewSelect];
    [self collectionCellSelect];
    
    
//    [XAlertView alertWithTitle:@"更新提示" message:self.clientGlobalInfo.versionInfo.versionDesc cancelButtonTitle:self.clientGlobalInfo.versionInfo.needForceUpdate.integerValue ? @"":@"取消"confirmButtonTitle:@"更新" viewController:self completion:^(UIAlertAction *action, NSInteger buttonIndex) {
//        if (buttonIndex == 1) {
//            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:self.clientGlobalInfo.versionInfo.url]];
//            exit(0);
//        }
//
//    }];
    
}
- (void)creatSearchBtn{
    UIButton *searchBtn = [[UIButton alloc]init];
    searchBtn.frame = CGRectMake(0, 0, AdaptationWidth(343), 30);
    [searchBtn setBackgroundColor:LineColor];
    [searchBtn setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
    [searchBtn setTitle:@"输入关键词" forState:UIControlStateNormal];
    [searchBtn setTitleColor:LabelAssistantColor forState:UIControlStateNormal];
    [searchBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
    [searchBtn addTarget:self action:@selector(btnOnClock:) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setCornerValue:4];
    self.navigationItem.titleView = searchBtn;
}
- (void)scrollViewSelect{
    BLOCKSELF
    [self.collectionView.homeViewModel setResponseBannerWebBlock:^(id result) {
        BaseWebVC *vc = [[BaseWebVC alloc]init];
        [vc reloadForGetWebView:result];
        vc.hidesBottomBarWhenPushed = YES;
        [blockSelf.navigationController pushViewController:vc animated:YES];
    }];
}
- (void)specialViewSelect{
    BLOCKSELF
    [self.collectionView.homeViewModel setResponseHotWebBlock:^(id result) {
        BaseWebVC *vc = [[BaseWebVC alloc]init];
        [vc reloadForGetWebView:result];
        vc.hidesBottomBarWhenPushed = YES;
        [blockSelf.navigationController pushViewController:vc animated:YES];
    }];
    self.collectionView.homeViewModel.responseHotBlock = ^(NSMutableArray *result) {
        SpecialJobListVC *vc = [[SpecialJobListVC alloc]init];
        vc.specialEntryList = result;
        vc.hidesBottomBarWhenPushed = YES;
        [blockSelf.navigationController pushViewController:vc animated:YES];
    };
}
- (void)collectionCellSelect{
    WEAKSELF
    self.collectionView.collectionSelectBlock = ^(NSDictionary *result) {
        
        JobDetailVC *vc = [[JobDetailVC alloc]init];
        vc.productNo = result[@"productNo"];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
}
- (void)btnOnClock:(UIButton *)btn{
    SearchVC *vc = [[SearchVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
/*
 #pragma mark - Navi;gation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
