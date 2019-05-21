//
//  HomeTableView.m
//  JianKeLife
//
//  Created by yanqb on 2019/5/20.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "HomeTableView.h"
#import "SDCycleScrollView.h"

#import "HiBuyVC.h"
#import "HiBuyTableViewVC.h"

@interface HomeTableView ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,WMPageControllerDelegate,WMPageControllerDataSource>
@property (nonatomic, strong) SDCycleScrollView *sdcycleScrollView;
@property (nonatomic ,strong) UIScrollView *specialScrollViewl;
@property (nonatomic ,strong) WMPageController *wMPageController;

@property (nonatomic, strong) NSMutableArray *titleData;
@property (nonatomic, strong) NSMutableArray *titleWith;
@property (nonatomic, strong) NSMutableArray *itemsWidthArry;
@property (nonatomic, strong) NSMutableArray *titleName;
@property (nonatomic, strong) NSMutableArray *vcData;
@property (nonatomic, assign) CGFloat itemsWidth;
@end

@implementation HomeTableView
- (void)initTableView{
    self.delegate = self;
    self.dataSource = self;
    self.tableHeaderView = [self creatTableHeaderView];
    
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
    [self reloadData];
}
- (UIView *)creatTableHeaderView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, AdaptationWidth(242))];
    [view addSubview: self.sdcycleScrollView];
    [self.sdcycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view).offset(AdaptationWidth(16));
        make.top.mas_equalTo(view);
        make.right.mas_equalTo(view).offset(AdaptationWidth(-16));
        make.height.mas_equalTo(AdaptationWidth(130));
    }];
    
    [view addSubview:self.specialScrollViewl];
    [self.specialScrollViewl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view).offset(AdaptationWidth(16));
        make.top.mas_equalTo(self.sdcycleScrollView.mas_bottom).offset(AdaptationWidth(6));
        make.right.mas_equalTo(view).offset(AdaptationWidth(-16));
        make.height.mas_equalTo(AdaptationWidth(100));
    }];
    return view;
}
#pragma  mark - tablebiew
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    
    [view addSubview:self.wMPageController.view];
    self.wMPageController.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [self.wMPageController reloadData];
   
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return ScreenHeight*2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
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
#pragma  mark - btn
- (void)btnOnClick:(UIButton *)btn{
    
    [TalkingData trackEvent:@"首页-点击【特色入口】"];
    [self.homeViewModel requestSpecialData:btn.tag-1021];
}
#pragma mark -SDCycleScrollView delegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSNumber *isLogin = self.homeViewModel.clientGlobalInfo.bannerAdList[index][@"isNeedLogin"];
    if (isLogin.integerValue == 1) {
        if (![[UserInfo sharedInstance]isSignIn]) {
            [XNetWork unLoginNotification];
            return;
        }
        
    }
    [TalkingData trackEvent:@"首页-点击【Banner广告】"];
    [self.homeViewModel requestBannerData:index];
}


- (SDCycleScrollView *)sdcycleScrollView{
    if (!_sdcycleScrollView) {
        NSMutableArray *imageArry = [NSMutableArray array];
        [self.homeViewModel.clientGlobalInfo.bannerAdList enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [imageArry addObject:obj[@"adImgUrl"]];
        }];
        _sdcycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"iamge_rule"]];
        [_sdcycleScrollView setCornerValue:AdaptationWidth(8)];
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
        _specialScrollViewl.contentSize = CGSizeMake(self.homeViewModel.clientGlobalInfo.specialEntryList.count *AdaptationWidth(80), 0);
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
                    make.left.mas_equalTo(self->_specialScrollViewl).offset(AdaptationWidth(80)*i);
                    make.top.mas_equalTo(self->_specialScrollViewl);
                    make.height.mas_equalTo(AdaptationWidth(75));
                    make.width.mas_equalTo(AdaptationWidth(56));
                }];
            }else{
                [balckBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(self->_specialScrollViewl).offset(AdaptationWidth(95)*i);
                    make.top.mas_equalTo(self->_specialScrollViewl);
                    make.height.mas_equalTo(AdaptationWidth(75));
                    make.width.mas_equalTo(AdaptationWidth(56));
                }];
            }
            
        }
    }
    return _specialScrollViewl;
}
- (HomeViewModel *)homeViewModel{
    if (!_homeViewModel) {
        _homeViewModel = [[HomeViewModel alloc]init];
    }
    return _homeViewModel;
}
- (WMPageController *)wMPageController{
    if (!_wMPageController) {
        _wMPageController = [[WMPageController alloc]init];
        _wMPageController.delegate = self;
        _wMPageController.dataSource = self;
//        _wMPageController.titles = self.titleName;
        _wMPageController.viewControllerClasses = self.vcData;
        _wMPageController.titleSizeNormal = AdaptationWidth(16);
        _wMPageController.titleSizeSelected = AdaptationWidth(16);
        _wMPageController.menuViewStyle = WMMenuViewStyleLine;
        //    if (self.titleData.count < 7) {
        //        self.menuItemWidth = [UIScreen mainScreen].bounds.size.width / self.titleData.count;
        //    }else{
        //        self.menuItemWidth = [UIScreen mainScreen].bounds.size.width / 7;
        //    }
        _wMPageController.itemsWidths = self.titleWith;
        
        _wMPageController.titleColorSelected = blueColor;
        _wMPageController.titleColorNormal = LabelMainColor;
        _wMPageController.progressColor = blueColor;
        //    self.progressWidth = AdaptationWidth(36); // 这里可以设置不同的宽度
        _wMPageController.progressViewWidths = self.itemsWidthArry;
        _wMPageController.progressHeight = 4;
    }
    return _wMPageController;
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
