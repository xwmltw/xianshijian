//
//  HiBuyTableViewVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/4/22.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "HiBuyTableViewVC.h"
#import "HiBuyTableViewCell.h"
#import "SDCycleScrollView.h"
#import "LoginVC.h"
#import "BaseWebVC.h"
#import "JSDropDownMenu.h"
#import "HiBuyProductdetialVC.h"
#import "WXApi.h"
#import <ShareSDK/ShareSDK.h>
#import "SaiXuanView.h"
@interface HiBuyTableViewVC ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,JSDropDownMenuDelegate,JSDropDownMenuDataSource>
@property (nonatomic ,strong) SDCycleScrollView *sdcycleScrollView;
@property (nonatomic ,strong) JSDropDownMenu *dropDownMenu;
@property (nonatomic ,strong) NSArray *allAry ,*salesAry ,*priceAry ,*chooseAry;
@property (nonatomic ,assign) NSInteger allIndex, salesIndex, priceIndex, chooseIndex;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) UIButton *topBtn;
@property (nonatomic ,strong) SaiXuanView *saiXuanView;

@end

@implementation HiBuyTableViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = XColorWithRGB(248, 248, 248);
    
    if (self.isFirstType && self.clientGlobalInfo.bannerAdListTBPage.count > 0) {
        [self.view addSubview:self.sdcycleScrollView];
        [self.sdcycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view).offset(16);
            make.right.mas_equalTo(self.view).offset(-16);
            make.top.mas_equalTo(self.view).offset(AdaptationWidth(12));
            make.height.mas_equalTo(AdaptationWidth(130));
        }];
    }
    [self.view addSubview:self.dropDownMenu];
    
    
//    self.tableView.tableHeaderView = [self creatHead];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.dropDownMenu.mas_bottom).offset(2);
//        make.top.mas_equalTo(self.view);
        make.left.right.bottom.mas_equalTo(self.view);
//        make.bottom.mas_equalTo(self.view).offset(-40);
    }];
//    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"HiBuyTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HiBuyTableViewCell"];
    self.tableView.estimatedRowHeight = 146;
    self.tableView.mj_footer = [self.hiBuyViewModel creatMjRefresh];
    [self.hiBuyViewModel requestData];
    WEAKSELF
    [self.hiBuyViewModel setHiBuyTypeBlock:^(id result) {
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf.tableView reloadData];
    }];
    [self.hiBuyViewModel setHiBuyQuerBlock:^(id result) {
        [weakSelf.tableView reloadData];
        if (weakSelf.hiBuyViewModel.hiBuyTypeList.count) {
             //回到顶部
            NSIndexPath* indexPat = [NSIndexPath indexPathForRow:0 inSection:0];
            [weakSelf.tableView scrollToRowAtIndexPath:indexPat atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
   
    }];
    
    self.topBtn = [[UIButton alloc]init];
    self.topBtn.hidden = YES;
//    [self.topBtn setBackgroundColor:[UIColor whiteColor]];
    [self.topBtn setImage:[UIImage imageNamed:@"icon_top"] forState:UIControlStateNormal];
    [self.topBtn addTarget:self action:@selector(btnOnClock:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.topBtn];
    [self.topBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).offset(AdaptationWidth(-10));
        make.right.mas_equalTo(self.view).offset(AdaptationWidth(-10));
        make.width.height.mas_equalTo(AdaptationWidth(76));
    }];
    [XNotificationCenter addObserver:self selector:@selector(missBackgrond) name:@"backgroundTapped" object:nil];
}
//
- (UIView *)creatHead{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, AdaptationWidth(144)+45)];
    view.backgroundColor = [UIColor whiteColor];
    if (self.isFirstType && self.clientGlobalInfo.bannerAdListTBPage.count > 0) {
        [view addSubview:self.sdcycleScrollView];
        [self.sdcycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(view).offset(16);
            make.right.mas_equalTo(view).offset(-16);
            make.top.mas_equalTo(view).offset(AdaptationWidth(12));
            make.height.mas_equalTo(AdaptationWidth(130));
        }];
    }
    [view addSubview:self.dropDownMenu];
    return view;
}

#pragma mark - 通知
- (void)missBackgrond{
    [self.saiXuanView removeFromSuperview];
}
#pragma mark -btn
- (void)btnOnClock:(UIButton *)btn{
    NSIndexPath* indexPat = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPat atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat height = self.isFirstType ? AdaptationWidth(300) : AdaptationWidth(ScreenHeight - 100);
    if(scrollView.contentOffset.y < height){
        self.topBtn.hidden = YES;
        
    }else{
        self.topBtn.hidden = NO;
        
    }
   
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"icon_noData"];
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view);
        make.top.mas_equalTo(view).offset(50);
        
    }];
    UILabel *lab = [[UILabel alloc]init];
    [lab setText:@"该分类暂无产品,去其他分类看看~"];
    [lab setFont:[UIFont systemFontOfSize:16]];
    [lab setTextColor:LabelMainColor];
    [view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view);
        make.top.mas_equalTo(imageView.mas_bottom).offset(34);
    }];


    return self.hiBuyViewModel.hiBuyTypeList.count ? nil : view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return self.hiBuyViewModel.hiBuyTypeList.count ? 0 : ScreenHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.hiBuyViewModel.hiBuyTypeList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 146;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HiBuyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HiBuyTableViewCell"];
    if (!cell) {
        cell = [[HiBuyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HiBuyTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.model = [HiBuyProductModel mj_objectWithKeyValues:self.hiBuyViewModel.hiBuyTypeList[indexPath.row]];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HiBuyProductdetialVC *vc = [[HiBuyProductdetialVC alloc]init];
    vc.productId = self.hiBuyViewModel.hiBuyTypeList[indexPath.row][@"id"];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark - SDCycleScrollView delegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    NSNumber *isLogin = self.clientGlobalInfo.bannerAdListTBPage[index][@"isNeedLogin"];
    if (isLogin.integerValue == 1) {
        if (![[UserInfo sharedInstance]isSignIn]) {
            [XNetWork unLoginNotification];
            return;
        }
        
    }
    
    NSNumber *adType = self.clientGlobalInfo.bannerAdListTBPage[index][@"adType"];
    NSString *adId = self.clientGlobalInfo.bannerAdListTBPage[index][@"adId"];
    NSString *adDetailUrl = XNULL_TO_NIL(self.clientGlobalInfo.bannerAdListTBPage[index][@"adDetailUrl"]);
    [XNetWork requestNetWorkWithUrl:Xadvertise_access_log andModel:@{@"adId":adId} andSuccessBlock:^(ResponseModel *model) {
        
    } andFailBlock:^(ResponseModel *model) {
        
    }];
    
    switch (adType.integerValue) {
        case 1:
        {
            BaseWebVC *vc = [[BaseWebVC alloc]init];
            [vc reloadForGetWebView:adDetailUrl];
            vc.hidesBottomBarWhenPushed = YES;
//            WEAKSELF
//            [vc.webParentView setScriptBlock:^(id result) {
//                [weakSelf webViewWithScript:result];
//            }];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:adDetailUrl]];
        }
            break;
            
            
        default:
            break;
    }
}

//#pragma mark - js交互
//- (void)webViewWithScript:(WKScriptMessage *)message{
//    if ([message.name isEqualToString:@"triggerAppMethod_laxin_XCX"]) {
//        if (![WXApi isWXAppInstalled]) {
//            [ProgressHUD showProgressHUDInView:nil withText:@"未安装微信" afterDelay:1 ];
//            return ;
//        }
//        //        小程序分享
//        NSDictionary *dic = [message.body mj_JSONObject];
//
//        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
//        [shareParams SSDKSetupWeChatMiniProgramShareParamsByTitle:AppName
//                                                      description:AppName
//                                                       webpageUrl:[NSURL URLWithString:@"https://www.baidu.com/"]
//                                                             path:dic[@"page"]
//                                                       thumbImage:nil
//                                                     hdThumbImage:[UIImage imageNamed:@"LaunchScreen_LOGO"]
//                                                         userName:dic[@"userName"]
//                                                  withShareTicket:YES
//                                                  miniProgramType:[dic[@"type"] integerValue]
//                                               forPlatformSubType:SSDKPlatformSubTypeWechatSession];
//        [ShareSDK share:SSDKPlatformSubTypeWechatSession parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
//
//        }];
//    }
//}

#pragma mark - dropDownMenu

- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu{

    return 4;
}
- (BOOL)displayByCollectionViewInColumn:(NSInteger)column{
    
    return NO;
}
- (BOOL)haveRightTableViewInColumn:(NSInteger)column{
    return NO;
}
- (CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
    return 1;
}

- (NSInteger)currentLeftSelectedRow:(NSInteger)column{
    switch (column) {
        case 0:
            return self.allIndex;
            break;
        case 1:
            return self.salesIndex;
            break;
        case 2:
            return self.priceIndex;
            break;
        case 3:
           
            return self.chooseIndex;
            break;
            
        default:
            break;
    }
    return 0;
}
- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
    
    [self.saiXuanView removeFromSuperview];
    switch (column) {
        case 0:
            return self.allAry.count;
            break;
        case 1:
            return self.salesAry.count;
            break;
        case 2:
            return self.priceAry.count;
            break;
        case 3:
            
            return self.chooseAry.count;
            break;
            
        default:
            break;
    }
    return 0;
}

-(NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{
//    switch (column) {
//        case 0:
//            return self.allAry[self.allIndex];
//            break;
//        case 1:
//            return self.salesAry[self.salesIndex];
//            break;
//        case 2:
//            return self.priceAry[self.priceIndex];
//            break;
//        case 3:
//            return self.chooseAry[self.chooseIndex];
//            break;
//
//        default:
//            break;
//    }
    NSArray *arr = @[@"综合",@"销量",@"价格",@"筛选"];
    return arr[column];
}
- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath{
//    [self.tableView setContentOffset:self.tableView.contentOffset animated:NO];
    
    switch (indexPath.column) {
        case 0:
            return self.allAry[indexPath.row];
            break;
        case 1:
            return self.salesAry[indexPath.row];
            break;
        case 2:
            return self.priceAry[indexPath.row];
            break;
        case 3:
            [self.view addSubview:self.saiXuanView];
            return self.chooseAry[indexPath.row];
            break;

        default:
            break;
    }
//    NSArray *arr = @[@"综合",@"销量",@"价格",@"筛选"];
    return @"";
   
}
- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath{
    
    
    switch (indexPath.column) {
        case 0:
            self.hiBuyViewModel.hiBuyProductQueryModel.orderType = @(indexPath.row);
            self.allIndex = indexPath.row;
            [self.hiBuyViewModel requestTypeDate];
            
            break;
        case 1:
            
            self.hiBuyViewModel.hiBuyProductQueryModel.orderType = indexPath.row ? @(indexPath.row + 5) : 0;
            self.salesIndex = indexPath.row;
            [self.hiBuyViewModel requestTypeDate];
           
           
            break;
        case 2:
         
            self.hiBuyViewModel.hiBuyProductQueryModel.orderType = indexPath.row ? @(indexPath.row + 7) : 0;
            self.priceIndex = indexPath.row;
            [self.hiBuyViewModel requestTypeDate];
            break;
        case 3:
//            self.chooseIndex = indexPath.row;
            
            break;
            
        default:
            break;
    }
    [self.saiXuanView removeFromSuperview];
    
}
#pragma mark-懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}
- (JSDropDownMenu *)dropDownMenu{
    if (!_dropDownMenu) {
        if (_isFirstType && self.clientGlobalInfo.bannerAdListTBPage.count) {
            _dropDownMenu = [[JSDropDownMenu alloc]initWithOrigin:CGPointMake(0, AdaptationWidth(144)) andHeight:45];
        }else{
            _dropDownMenu = [[JSDropDownMenu alloc]initWithOrigin:CGPointMake(0, 0) andHeight:45];
        }
        _dropDownMenu.indicatorColor = XColorWithRBBA(34, 58, 80, 0.68);
        _dropDownMenu.indicatorHightColor = blueColor;
        _dropDownMenu.separatorColor = XColorWithRGB(233, 233, 235);
        _dropDownMenu.textColor = XColorWithRBBA(34, 58, 80, 0.68);
        _dropDownMenu.textHightColor = blueColor;
        _dropDownMenu.dataSource = self;
        _dropDownMenu.delegate = self;
    }
    return _dropDownMenu;
}


- (SDCycleScrollView *)sdcycleScrollView{
    if (!_sdcycleScrollView) {
        NSMutableArray *imageArry = [NSMutableArray array];
        [self.clientGlobalInfo.bannerAdListTBPage enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [imageArry addObject:obj[@"adImgUrl"]];
        }];
        _sdcycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"icon_noData"]];
        _sdcycleScrollView.imageURLStringsGroup = imageArry;
        _sdcycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
        _sdcycleScrollView.autoScrollTimeInterval = 3;
        _sdcycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _sdcycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _sdcycleScrollView.pageDotColor = XColorWithRBBA(255, 255, 255, 0.4);
        _sdcycleScrollView.backgroundColor = [UIColor whiteColor];
        if (imageArry.count == 1) {
            _sdcycleScrollView.autoScroll = NO;
        }
    }
    return _sdcycleScrollView;
}

- (NSArray *)allAry{
    if (!_allAry) {
        _allAry = [NSArray arrayWithObjects:@"综合",@"佣金金额由高到低",@"佣金金额由低到高",@"优惠券由高到低",@"优惠券由低到高", nil];
    }
    return _allAry;
}
- (NSArray *)salesAry{
    if (!_salesAry) {
        _salesAry = [NSArray arrayWithObjects:@"由高到低",@"由低到高", nil];
    }
    return _salesAry;
}
- (NSArray *)priceAry{
    if (!_priceAry) {
        _priceAry = [NSArray arrayWithObjects:@"由高到低",@"由低到高", nil];
    }
    return _priceAry;
}
- (NSArray *)chooseAry{
    if (!_chooseAry) {
        _chooseAry = [NSArray arrayWithObjects:@"最高金额", nil];
    }
    return _chooseAry;
}
- (HiBuyViewModel *)hiBuyViewModel{
    if (!_hiBuyViewModel) {
        _hiBuyViewModel = [[HiBuyViewModel alloc]init];
    }
    return _hiBuyViewModel;
}
- (SaiXuanView *)saiXuanView{
    if (!_saiXuanView) {
        _saiXuanView = [[SaiXuanView alloc]initWithFrame:CGRectMake(0, self.dropDownMenu.Y+46, ScreenWidth, AdaptationWidth(145))];
        [self.view addSubview:_saiXuanView];
        WEAKSELF
        [_saiXuanView setBtnBlock:^(NSString *min,NSString *max) {
            if(min.length == 0) {
                [ProgressHUD showProgressHUDInView:nil withText:@"请输入最低价格" afterDelay:1];
                return ;
            }
            if(max.length == 0) {
                [ProgressHUD showProgressHUDInView:nil withText:@"请输入最高价格" afterDelay:1];
                return ;
            }
            if ([min doubleValue] >[max doubleValue]) {
                [ProgressHUD showProgressHUDInView:nil withText:@"最高的价格不可以比最低价还小哟~" afterDelay:1];
                return ;
            }
            //回到顶部
//             [weakSelf.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
                weakSelf.hiBuyViewModel.hiBuyProductQueryModel.minPrice = @([min doubleValue]);
                weakSelf.hiBuyViewModel.hiBuyProductQueryModel.maxPrice = @([max doubleValue]);
                [weakSelf.hiBuyViewModel requestTypeDate];
            [_saiXuanView removeFromSuperview];
            [weakSelf.dropDownMenu hideMenu] ;
        }];
//        [_saiXuanView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.mas_equalTo(self.view);
//            make.height.mas_equalTo(AdaptationWidth(143));
//            make.top.mas_equalTo(self)
//        }];
    }
    return _saiXuanView;
}
- (void)dealloc{
    [XNotificationCenter removeObserver:@"backgroundTapped"];
}
@end
