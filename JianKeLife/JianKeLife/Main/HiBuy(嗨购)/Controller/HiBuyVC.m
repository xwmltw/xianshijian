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

@interface HiBuyVC ()<WMPageControllerDataSource>
@property (nonatomic, strong) NSMutableArray *titleData;
@property (nonatomic, strong) NSMutableArray *vcData;
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
    NSMutableArray *arry = [NSMutableArray array];
    [self.titleData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [arry addObject:obj[@"classifyName"]];
    }];
    
    for (int i = 0; i < self.titleData.count; i ++) {
        [self.vcData addObject:[HiBuyTableViewVC new]];
    }
    
    self.titles = arry;
    self.viewControllerClasses = self.vcData;
    self.titleSizeNormal = AdaptationWidth(16);
    self.titleSizeSelected = AdaptationWidth(16);
    self.menuViewStyle = WMMenuViewStyleLine;
    if (self.titleData.count < 7) {
        self.menuItemWidth = [UIScreen mainScreen].bounds.size.width / self.titleData.count;
    }else{
        self.menuItemWidth = [UIScreen mainScreen].bounds.size.width / 7;
    }
    
    self.titleColorSelected = blueColor;
    self.titleColorNormal = LabelMainColor;
    self.progressColor = blueColor;
    self.progressWidth = AdaptationWidth(36); // 这里可以设置不同的宽度
    self.progressHeight = 4;//下划线的高度，需要WMMenuViewStyleLine样式
    
    //这里注意，需要写在最后面，要不然上面的效果不会出现
    [super viewDidLoad];
    
    [self reloadData];
    [self creatSearchBtn];
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
- (void)btnOnClock:(UIButton *)btn{
    

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
    return CGRectMake(0, 0, ScreenWidth, AdaptationWidth(42));
}

- (NSMutableArray *)titleData {
    if (!_titleData) {
        _titleData = [NSMutableArray array];
    }
    return _titleData;
}
- (NSMutableArray *)vcData {
    if (!_vcData) {
        _vcData = [NSMutableArray array];
        
    }
    return _vcData;
}
@end
