//
//  SearchCollectionView.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/23.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "SearchCollectionView.h"
#import "HomeHotCollectionViewCell.h"


@interface SearchCollectionView ()<UICollectionViewDelegate ,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    BOOL stateData;
}
@end

@implementation SearchCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        self.delaysContentTouches = NO;
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = LineColor;
        
        
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([HomeHotCollectionViewCell class]) bundle:[NSBundle mainBundle ]] forCellWithReuseIdentifier:NSStringFromClass([HomeHotCollectionViewCell class])];
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
        
        self.searchVieModel = [[SearchVieModel alloc]init];
        self.mj_footer = [self.searchVieModel creatMjRefresh];
        stateData = NO;
        BLOCKSELF
        [self.searchVieModel setResponseSearchBlock:^(id result) {
            self->stateData = YES;
            [blockSelf.mj_footer endRefreshing];
            [blockSelf reloadData];
        }];
        
        
        
    }
    return self;
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.searchVieModel.productList.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    HomeHotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomeHotCollectionViewCell class]) forIndexPath:indexPath];
    cell.cellTitle.text = self.searchVieModel.productList[indexPath.row][@"productTitle"];
    [cell.cellImage sd_setImageWithURL:self.searchVieModel.productList[indexPath.row][@"productFirstMainPicUrl"]];
    cell.cellMoney.text = [NSString stringWithFormat:@"%.2f",[self.searchVieModel.productList[indexPath.row][@"productSalary"] doubleValue]/100];
    
    
    
    return cell;
}



#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    XBlockExec(self.collectionSelectBlock ,self.searchVieModel.productList[indexPath.row]);
    
    
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
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    
    if (self.searchVieModel.productList.count == 0 && stateData) {
        return CGSizeMake(self.Sw, self.Sh);
    }
    
    return CGSizeZero;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
     UICollectionReusableView *view2 = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
    [view2 removeFromSuperview];
    if (self.searchVieModel.productList.count == 0) {
        if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
           
                UIImageView *imageView = [[UIImageView alloc]init];
                imageView.image = [UIImage imageNamed:@"icon_noData"];
                [view2 addSubview:imageView];
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.mas_equalTo(view2);
                    make.top.mas_equalTo(view2).offset(140);
                    
                }];
                UILabel *lab = [[UILabel alloc]init];
                [lab setText:@"暂无产品状态"];
                [lab setFont:[UIFont systemFontOfSize:16]];
                [lab setTextColor:LabelMainColor];
                [view2 addSubview:lab];
                [lab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.mas_equalTo(view2);
                    make.top.mas_equalTo(imageView.mas_bottom).offset(34);
                }];
            
        }
    }
    return view2;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  
        
        return CGSizeMake(AdaptationWidth(166), AdaptationWidth(215));;
    
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
@end
