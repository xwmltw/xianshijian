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
#import "WSLWaterFlowLayout.h"

@interface HomeVC ()<WSLWaterFlowLayoutDelegate>
{
     WSLWaterFlowLayout * _flow;
}
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
    _flow = [[WSLWaterFlowLayout alloc] init];
    _flow.delegate = self;
    _flow.flowLayoutStyle = WSLWaterFlowVerticalEqualWidth;
    self.collectionView = [[HomeCollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:_flow];
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
    self.collectionView.homeViewModel.responseHotBlock = ^(NSMutableArray *result ,NSNumber *row) {
        SpecialJobListVC *vc = [[SpecialJobListVC alloc]init];
        vc.title = blockSelf.clientGlobalInfo.specialEntryList[row.integerValue][@"specialEntryTitle"];
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
#pragma  mark - WSLWaterFlowLayout delegate

//返回每个item大小
- (CGSize)waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
   NSString *str = self.collectionView.homeViewModel.productList[indexPath.row][@"productTitle"];
    CGSize detailSize = [str boundingRectWithSize:CGSizeMake(AdaptationWidth(100), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:nil context:nil].size;
     if (detailSize.height < 14) {
        return CGSizeMake(0, AdaptationWidth(191));
    }
    return CGSizeMake(0, AdaptationWidth(215));
    
}

/** 头视图Size */
-(CGSize )waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout sizeForHeaderViewInSection:(NSInteger)section{
    HomeCollectionHead row = [self.collectionView.headArray[section]integerValue];
    switch (row) {
        case HomeCollectionHeadBanner:{
            if (self.clientGlobalInfo.bannerAdList.count) {
                return CGSizeMake(self.view.Sw, AdaptationWidth(130));
            }else{
                return CGSizeMake(self.view.Sw, 0.1);
            }
            
        }
            break;
        case HomeCollectionHeadSpecial:{
            if (self.clientGlobalInfo.specialEntryList.count) {
                return CGSizeMake(self.view.Sw, AdaptationWidth(90));
            }else{
                return CGSizeMake(self.view.Sw, 0.1);
            }
            
        }
            break;
        case HomeCollectionHeadHot:{
            return CGSizeMake(self.view.Sw, AdaptationWidth(30));
        }
            break;
        default:
            break;
    }
    return CGSizeZero;
}
///** 脚视图Size */
//-(CGSize )waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout sizeForFooterViewInSection:(NSInteger)section{
//    return CGSizeMake(40, 40);
//}

///** 列数*/
//-(CGFloat)columnCountInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
//    return 3;
//}
///** 行数*/
//-(CGFloat)rowCountInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
//    return 5;
//}
/** 列间距*/
-(CGFloat)columnMarginInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return 5;
}
/** 行间距*/
-(CGFloat)rowMarginInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return 5;
}
/** 边缘之间的间距*/
-(UIEdgeInsets)edgeInsetInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
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
