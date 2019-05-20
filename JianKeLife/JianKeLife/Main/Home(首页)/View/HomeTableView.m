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

@interface HomeTableView ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
@property (nonatomic, strong) SDCycleScrollView *sdcycleScrollView;
@property (nonatomic ,strong) UIScrollView *specialScrollViewl;
@end

@implementation HomeTableView

- (UIView *)tableHeaderView{
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
        make.top.mas_equalTo(view);
        make.right.mas_equalTo(view).offset(AdaptationWidth(-16));
        make.height.mas_equalTo(AdaptationWidth(100));
    }];
    return view;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    HiBuyVC *vc = [[HiBuyVC alloc]init];
    [view addSubview:vc.view];
    [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(view);
    }];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return ScreenHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
