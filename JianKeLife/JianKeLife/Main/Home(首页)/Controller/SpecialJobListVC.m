//
//  SpecialJobListVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/4/1.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "SpecialJobListVC.h"
#import "HomeHotCollectionViewCell.h"
#import "JobDetailVC.h"

@interface SpecialJobListVC ()<UICollectionViewDelegate ,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic ,strong) UICollectionView *collectionView;
@end

@implementation SpecialJobListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"特色入口";
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.collectionView.delaysContentTouches = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = LineColor;
    [self.view addSubview:self.collectionView];
    
     [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeHotCollectionViewCell class]) bundle:[NSBundle mainBundle ]] forCellWithReuseIdentifier:NSStringFromClass([HomeHotCollectionViewCell class])];
//    WEAKSELF
//    [self.collectionView setCollectionSelectBlock:^(NSDictionary *result) {
//        JobDetailVC *vc = [[JobDetailVC alloc]init];
//        vc.productNo = result[@"productNo"];
//        [weakSelf.navigationController pushViewController:vc animated:YES];
//    }];
    
//    - (void)requestSpecialData:(NSNumber *)specialEntryId{
//        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//        [dic setObject:specialEntryId forKey:@"specialEntryId"];
//        [dic setObject:[self.pageQueryRedModel mj_keyValues] forKey:@"pageQueryReq"];
//        WEAKSELF
//        [XNetWork requestNetWorkWithUrl:Xquery_product_list andModel:dic andSuccessBlock:^(ResponseModel *model) {
//            [weakSelf.productList addObjectsFromArray:model.data[@"dataRows"]];
//            XBlockExec(weakSelf.responseSearchBlock,model);
//        } andFailBlock:^(ResponseModel *model) {
//            [weakSelf.footer endRefreshing];
//        }];
//    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.specialEntryList.count;
    
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeHotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomeHotCollectionViewCell class]) forIndexPath:indexPath];
    cell.cellTitle.text = self.specialEntryList[indexPath.row][@"productTitle"];
    [cell.cellImage sd_setImageWithURL:self.specialEntryList[indexPath.row][@"productFirstMainPicUrl"]];
    cell.cellMoney.text = [NSString stringWithFormat:@"%.2f",[self.specialEntryList[indexPath.row][@"productSalary"] doubleValue]/100];
    
    return cell;
}



#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
            JobDetailVC *vc = [[JobDetailVC alloc]init];
            vc.productNo = self.specialEntryList[indexPath.row][@"productNo"];
            [self.navigationController pushViewController:vc animated:YES];
}
// 选中高亮
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    //    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    //    cell.backgroundColor = [UIColor lightGrayColor];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    //    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    //    cell.backgroundColor = [UIColor whiteColor];
}
#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    return CGSizeMake(AdaptationWidth(166), AdaptationWidth(215));;
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(AdaptationWidth(15)/2, AdaptationWidth(15)/2, AdaptationWidth(15)/2, AdaptationWidth(15)/2);//分别为上、左、下、右
}

@end
