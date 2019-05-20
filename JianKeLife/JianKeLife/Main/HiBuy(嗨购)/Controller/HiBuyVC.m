//
//  HiBuyVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/4/22.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "HiBuyVC.h"
#import "HiBuyTableViewVC.h"
#import "HiBuyViewModel.h"
#import "HiBuySearchVC.h"
#import "LLSearchViewController.h"
#import "MessageVC.h"

@interface HiBuyVC ()<WMPageControllerDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray *titleData;
@property (nonatomic, strong) NSMutableArray *titleWith;
@property (nonatomic, strong) NSMutableArray *itemsWidthArry;
@property (nonatomic, strong) NSMutableArray *titleName;
@property (nonatomic, strong) NSMutableArray *vcData;
@property (nonatomic, assign) CGFloat itemsWidth;
@property (nonatomic ,strong) UICollectionView *collectionView;
@property (nonatomic ,strong) UIView *bgView;
@end

@implementation HiBuyVC

- (void)viewDidLoad {
    WEAKSELF
    [XNetWork requestNetWorkWithUrl:Xtb_classify_list andModel:nil andSuccessBlock:^(ResponseModel *model) {
        [weakSelf.titleData addObjectsFromArray:model.data[@"dataRows"]];
 
        [weakSelf gettitles];
    } andFailBlock:^(ResponseModel *model) {
        
    }];

}

- (void)gettitles{
    
    [self.titleData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.titleName addObject:obj[@"classifyName"]];
    }];
    
    
    [self.titleName enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
       CGSize size = [obj sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:AdaptationWidth(16)]}];
        self.itemsWidth = self.itemsWidth + size.width +15;
        [self.itemsWidthArry addObject: @(size.width)];
        [self.titleWith addObject:@(size.width + 15)];
    }];
    
    for (int i = 0; i < self.titleData.count; i ++) {
        [self.vcData addObject:[HiBuyTableViewVC new]];
    }
    
    
    self.titles = self.titleName;
    self.viewControllerClasses = self.vcData;
    self.titleSizeNormal = AdaptationWidth(16);
    self.titleSizeSelected = AdaptationWidth(16);
    self.menuViewStyle = WMMenuViewStyleLine;
//    if (self.titleData.count < 7) {
//        self.menuItemWidth = [UIScreen mainScreen].bounds.size.width / self.titleData.count;
//    }else{
//        self.menuItemWidth = [UIScreen mainScreen].bounds.size.width / 7;
//    }
    self.itemsWidths = self.titleWith;
    
    self.titleColorSelected = blueColor;
    self.titleColorNormal = LabelMainColor;
    self.progressColor = blueColor;
//    self.progressWidth = AdaptationWidth(36); // 这里可以设置不同的宽度
    self.progressViewWidths = self.itemsWidthArry;
    self.progressHeight = 4;//下划线的高度，需要WMMenuViewStyleLine样式
    
    //这里注意，需要写在最后面，要不然上面的效果不会出现
    [super viewDidLoad];
    
    [self reloadData];
//    [self creatSearchBtn];
    
    if (self.itemsWidth > ScreenWidth) {
        UIButton *selectBtn = [[UIButton alloc]init];
        selectBtn.tag = 5012;
        [selectBtn setBackgroundColor:[UIColor whiteColor]];
        [selectBtn setImage:[UIImage imageNamed:@"icon_down"] forState:UIControlStateNormal];
        [selectBtn addTarget:self action:@selector(btnOnClock:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:selectBtn];
        [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.mas_equalTo(self.view);
//            make.top.mas_equalTo(self.view).offset(AdaptationWidth(10));
            make.width.height.mas_equalTo(AdaptationWidth(42));
        }];
    }
    
    [TalkingData trackEvent:@"嗨购"];
   
    
}
- (void)creatSearchBtn{
    UIButton *searchBtn = [[UIButton alloc]init];
    searchBtn.tag = 5011;
    searchBtn.frame = CGRectMake(0, 0, AdaptationWidth(343), 35);
    [searchBtn setBackgroundColor:LineColor];
    [searchBtn setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
    [searchBtn setTitle:@"搜索商品或宝贝标题" forState:UIControlStateNormal];
    [searchBtn setTitleColor:LabelAssistantColor forState:UIControlStateNormal];
    [searchBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
    [searchBtn addTarget:self action:@selector(btnOnClock:) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setCornerValue:4];
    self.navigationItem.titleView = searchBtn;
    
    
    
}
- (void)btnOnClock:(UIButton *)btn{
    switch (btn.tag) {
        case 5011:
        {
           
//            HiBuySearchVC *vc = [[HiBuySearchVC alloc]init];
            LLSearchViewController *vc = [[LLSearchViewController alloc]init];

            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5012:
        {
            [self.view addSubview:self.bgView];
            self.bgView.hidden = NO;
        }
            break;
        case 5013:
        {
            self.bgView.hidden = YES;
        }
            break;
        
        default:
            break;
    }

}
#pragma mark - Datasource & Delegate

#pragma mark 返回子页面的个数
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titleData.count;
}

#pragma mark 返回某个index对应的页面
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    HiBuyTableViewVC *vc = self.vcData[index];
    vc.hiBuyViewModel.hiBuyProductQueryModel.prodClassifyId = self.titleData[index][@"classifyId"];
    vc.isFirstType = index == 0 ? YES : NO;
    return vc;
    
}

#pragma mark 返回index对应的标题
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    return self.titleData[index][@"classifyName"];
}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView{
    return CGRectMake(0, AdaptationWidth(42), ScreenWidth, ScreenHeight-AdaptationWidth(151));
}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView{
    if (self.itemsWidth > ScreenWidth) {
        return CGRectMake(0, 0, ScreenWidth-40, AdaptationWidth(42));
    }
    return CGRectMake(0, 0, self.itemsWidth + 20, AdaptationWidth(42));
}

#pragma mark -UICollectionView
//有多少的分组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}
//每个分组里有多少个item
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titleData.count;
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(AdaptationWidth(54), AdaptationWidth(75));
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(AdaptationWidth(10), AdaptationWidth(20), AdaptationWidth(10), AdaptationWidth(20));
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                              withReuseIdentifier:@"CollectionHeadTypeView"
                                                                                     forIndexPath:indexPath];
    UILabel *lab = [[UILabel alloc]init];
    [lab setText:@"全部分类"];
    [lab setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
    [lab setTextColor:XColorWithRGB(124, 124, 124)];
    [headerView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headerView).offset(AdaptationWidth(16));
        make.top.mas_equalTo(headerView).offset(AdaptationWidth(10));
    }];
    
    UIButton *selectBtn = [[UIButton alloc]init];
    selectBtn.tag = 5013;
    [selectBtn setBackgroundColor:[UIColor whiteColor]];
    [selectBtn setImage:[UIImage imageNamed:@"icon_down"] forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(btnOnClock:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:selectBtn];
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(headerView).offset(AdaptationWidth(-16));
        make.top.mas_equalTo(headerView).offset(AdaptationWidth(10));
        make.width.height.mas_equalTo(AdaptationWidth(30));
    }];
        return headerView;
    }
    return nil;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    
    return CGSizeMake(ScreenWidth, AdaptationWidth(42));
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //根据identifier从缓冲池里去出cell
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HiBuyTypeCell" forIndexPath:indexPath];
    UIImageView *imageCell = [[UIImageView alloc]init];
    
    [imageCell sd_setImageWithURL:[NSURL URLWithString:XNULL_TO_NIL(self.titleData[indexPath.row][@"classifyImgUrl"])] placeholderImage:[UIImage imageNamed:@"今日值享logo定稿"]];
//    [imageCell sd_setImageWithURL:[NSURL URLWithString:self.titleData[indexPath.row][@"classifyImgUrl"]]];
    [cell.contentView addSubview:imageCell];
    [imageCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(cell);
        make.height.mas_equalTo(AdaptationWidth(54));
    }];
    
    UILabel *lab = [[UILabel alloc]init];
    [lab setText:self.titleName[indexPath.row]];
    [lab setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
    [lab setTextColor:LabelMainColor];
    [cell.contentView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(cell);
        make.top.mas_equalTo(imageCell.mas_bottom).offset(1);
    }];
    
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.bgView.hidden = YES;
    self.selectIndex = (int)indexPath.row;
    
}
- (NSMutableArray *)titleData {
    if (!_titleData) {
        _titleData = [NSMutableArray array];
    }
    return _titleData;
}
- (NSMutableArray *)titleWith {
    if (!_titleWith) {
        _titleWith = [NSMutableArray array];
    }
    return _titleWith;
}
- (NSMutableArray *)itemsWidthArry {
    if (!_itemsWidthArry) {
        _itemsWidthArry = [NSMutableArray array];
    }
    return _itemsWidthArry;
}
- (NSMutableArray *)titleName {
    if (!_titleName) {
        _titleName = [NSMutableArray array];
    }
    return _titleName;
}
- (NSMutableArray *)vcData {
    if (!_vcData) {
        _vcData = [NSMutableArray array];
        
    }
    return _vcData;
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, AdaptationWidth(324)) collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"HiBuyTypeCell"];
        [_collectionView registerClass:[UICollectionReusableView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:@"CollectionHeadTypeView"];
    }
    return _collectionView;
}
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _bgView.backgroundColor = XColorWithRBBA(0, 0, 0, 0.3);
        
        [_bgView addSubview:self.collectionView];
    }
    return _bgView;
}
@end
