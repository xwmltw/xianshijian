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
#import "WSLWaterFlowLayout.h"

@interface SpecialJobListVC ()<UICollectionViewDelegate ,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,WSLWaterFlowLayoutDelegate>
@property (nonatomic ,strong) UICollectionView *collectionView;
@end

@implementation SpecialJobListVC
{
    WSLWaterFlowLayout *_flow;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"特色入口";
     _flow = [[WSLWaterFlowLayout alloc] init];
    _flow.delegate = self;
    _flow.flowLayoutStyle = WSLWaterFlowVerticalEqualWidth;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-49) collectionViewLayout:_flow];
    self.collectionView.delaysContentTouches = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = LineColor;
    [self.view addSubview:self.collectionView];
    
     [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeHotCollectionViewCell class]) bundle:[NSBundle mainBundle ]] forCellWithReuseIdentifier:NSStringFromClass([HomeHotCollectionViewCell class])];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
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
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *view2 = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
    
    NSArray*views = view2.subviews;
    for(int i =0; i < views.count; i++) {
        [views[i] removeFromSuperview];
    }
    if (self.specialEntryList.count == 0) {
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



#pragma  mark - WSLWaterFlowLayout delegate

//返回每个item大小
- (CGSize)waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = self.specialEntryList[indexPath.row][@"productTitle"];
    CGSize detailSize = [str boundingRectWithSize:CGSizeMake(AdaptationWidth(100), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:nil context:nil].size;
    if (detailSize.height < 14) {
        return CGSizeMake(0, AdaptationWidth(191));
    }
    return CGSizeMake(0, AdaptationWidth(215));
    
}

/** 脚视图Size */
-(CGSize )waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout sizeForFooterViewInSection:(NSInteger)section{
    if (self.specialEntryList.count == 0) {
        return CGSizeMake(self.view.Sw, self.view.Sh);
    }
    return CGSizeMake(self.view.Sw, 0.1);
}

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


@end
