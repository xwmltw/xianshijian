//
//  HomeCollectionView.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/20.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "HomeCollectionView.h"

#import "HomeHotCollectionViewCell.h"
#import "SDCycleScrollView.h"


@interface HomeCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SDCycleScrollViewDelegate>
@property (nonatomic, strong) SDCycleScrollView *sdcycleScrollView;
@property (nonatomic ,strong) UIScrollView *specialScrollViewl;
@property (nonatomic ,strong) UIImageView *hotImageView;
@end
@implementation HomeCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        self.delaysContentTouches = NO;
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = LineColor;

        
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([HomeHotCollectionViewCell class]) bundle:[NSBundle mainBundle ]] forCellWithReuseIdentifier:NSStringFromClass([HomeHotCollectionViewCell class])];
       
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
        
        self.homeViewModel = [[HomeViewModel alloc]init];
        self.mj_footer = [self.homeViewModel creatMjRefresh];
        
        BLOCKSELF
        [self.homeViewModel setResponseBlock:^(id result) {
            [blockSelf.mj_footer endRefreshing];
            [blockSelf reloadData];
        }];
        
    }
    return self;
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 2) {
        return self.homeViewModel.productList.count;
    }
    return 0;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
 
    switch (indexPath.section) {
        case 2:{
            HomeHotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomeHotCollectionViewCell class]) forIndexPath:indexPath];
            cell.cellTitle.text = self.homeViewModel.productList[indexPath.row][@"productTitle"];
            [cell.cellImage sd_setImageWithURL:self.homeViewModel.productList[indexPath.row][@"productFirstMainPicUrl"]];
            cell.cellMoney.text = [NSString stringWithFormat:@"%.2f",[self.homeViewModel.productList[indexPath.row][@"productSalary"] doubleValue]/100];
            
            
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

 UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
    UICollectionReusableView *view2 = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
    
    switch (indexPath.section) {
        case 0:{
            [view addSubview: self.sdcycleScrollView];
            [self.sdcycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(view).offset(AdaptationWidth(16));
                make.top.bottom.mas_equalTo(view);
                make.right.mas_equalTo(view).offset(AdaptationWidth(-16));
                
            }];
            
        }
            break;
        case 1:{
            [view addSubview:self.specialScrollViewl];
            [self.specialScrollViewl mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(view).offset(AdaptationWidth(16));
                make.top.bottom.mas_equalTo(view);
                make.right.mas_equalTo(view).offset(AdaptationWidth(-16));
            }];
  
        }
            break;
        case 2:{
        
            [view addSubview:self.hotImageView];
            [self.hotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(view);
                make.left.mas_equalTo(view).offset(AdaptationWidth(16));
            }];
            [view2 removeFromSuperview];
            if (self.homeViewModel.productList.count == 0) {
                if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
                    
                    UIImageView *imageView = [[UIImageView alloc]init];
                    imageView.image = [UIImage imageNamed:@"icon_noData"];
                    [view2 addSubview:imageView];
                    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.mas_equalTo(view2);
                        make.top.mas_equalTo(view2).offset(40);
                        
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
        }
            break;
        default:
            break;
    
    }
    return view;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 2) {
        XBlockExec(self.collectionSelectBlock ,self.homeViewModel.productList[indexPath.row]);
    }
    
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
    switch (section) {
        case 0:{
            if (self.homeViewModel.clientGlobalInfo.bannerAdList.count) {
                 return CGSizeMake(self.Sw, AdaptationWidth(130));
            }else{
                return CGSizeMake(self.Sw, 0.1);
            }
           
        }
            break;
        case 1:{
            if (self.homeViewModel.clientGlobalInfo.specialEntryList.count) {
                return CGSizeMake(self.Sw, AdaptationWidth(90));
            }else{
                return CGSizeMake(self.Sw, 0.1);
            }
            
        }
            break;
        case 2:{
            return CGSizeMake(self.Sw, AdaptationWidth(30));
        }
            break;
        default:
            break;
    }
            return CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section == 2) {
        if (self.homeViewModel.productList.count == 0) {
             return CGSizeMake(self.Sw, AdaptationWidth(289));
        }
    }
    return CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        
        case 2:{
//            if (indexPath.row == 0) {
//                return CGSizeMake(AdaptationWidth(166), AdaptationWidth(191));
//            }
            return CGSizeMake(AdaptationWidth(166), AdaptationWidth(215));;
        }
            break;
        default:
            break;
    }
    return CGSizeZero;
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
#pragma  mark - btn
- (void)btnOnClick:(UIButton *)btn{
    
    
    [self.homeViewModel requestSpecialData:btn.tag-1021];
//    self.hotBtnBlck = self.homeViewModel.responseHotBlock;
//    BLOCKSELF
//    [self.homeViewModel setResponseHotBlock:^(id result) {
//        XBlockExec(blockSelf.hotBtnBlck,result);
//    }];

}
#pragma mark -SDCycleScrollView delegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    [self.homeViewModel requestBannerData:index];
}


- (SDCycleScrollView *)sdcycleScrollView{
    if (!_sdcycleScrollView) {
        NSMutableArray *imageArry = [NSMutableArray array];
        [self.homeViewModel.clientGlobalInfo.bannerAdList enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [imageArry addObject:obj[@"adImgUrl"]];
        }];
        _sdcycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"iamge_rule"]];
        _sdcycleScrollView.imageURLStringsGroup = imageArry;
        _sdcycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
        _sdcycleScrollView.autoScrollTimeInterval = 3;
        _sdcycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _sdcycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _sdcycleScrollView.pageDotColor = XColorWithRBBA(255, 255, 255, 0.4);
        if (imageArry.count == 1) {
            _sdcycleScrollView.autoScroll = NO;
        }
    }
    return _sdcycleScrollView;
}
- (UIScrollView *)specialScrollViewl{
    if (!_specialScrollViewl) {
        _specialScrollViewl  = [[UIScrollView alloc]init];
        _specialScrollViewl.contentSize = CGSizeMake(self.Sw * 2, 0);
        _specialScrollViewl.showsVerticalScrollIndicator = NO;
        _specialScrollViewl.showsHorizontalScrollIndicator = NO;
        _specialScrollViewl.pagingEnabled = NO;
        _specialScrollViewl.bounces = NO;

        
        for (int i=0; i < self.homeViewModel.clientGlobalInfo.specialEntryList.count; i++) {
            UIButton *balckBtn = [[UIButton alloc]init];
            balckBtn.tag = 1021 + i;
            [balckBtn setTitle:self.homeViewModel.clientGlobalInfo.specialEntryList[i][@"specialEntryTitle"] forState:UIControlStateNormal];

            [balckBtn setTitleColor:LabelMainColor forState:UIControlStateNormal];
            [balckBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
//            [balckBtn sd_setImageWithURL:self.homeViewModel.clientGlobalInfo.specialEntryList[i][@"specialEntryIcon"] forState:UIControlStateNormal];

            [balckBtn sd_setImageWithURL:self.homeViewModel.clientGlobalInfo.specialEntryList[i][@"specialEntryIcon"] forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                balckBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 20, 0);
                balckBtn.titleEdgeInsets = UIEdgeInsetsMake(AdaptationWidth(70), -image.size.width, 0,  -5);
            }];

            
            
            
            [balckBtn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_specialScrollViewl addSubview:balckBtn];
            if (self.homeViewModel.clientGlobalInfo.specialEntryList.count > 4) {
                [balckBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(self->_specialScrollViewl).offset(AdaptationWidth(75)*i);
                    make.top.mas_equalTo(self->_specialScrollViewl);
                    make.height.mas_equalTo(AdaptationWidth(90));
                    make.width.mas_equalTo(AdaptationWidth(70));
                }];
            }else{
                [balckBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(self->_specialScrollViewl).offset(AdaptationWidth(90)*i);
                    make.top.mas_equalTo(self->_specialScrollViewl);
                    make.height.mas_equalTo(AdaptationWidth(90));
                    make.width.mas_equalTo(AdaptationWidth(70));
                }];
            }
            
        }
    }
    return _specialScrollViewl;
}
- (UIImageView *)hotImageView{
    if (!_hotImageView) {
        _hotImageView = [[UIImageView alloc]init];
        [_hotImageView setImage:[UIImage imageNamed:@"icon_cell_hot"]];
    }
    return _hotImageView;
}
@end
