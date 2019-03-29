//
//  TaskDetailVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/28.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "TaskDetailVC.h"
#import "TaskDetailModel.h"

@interface TaskDetailVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic ,strong) UICollectionView *collectionView;
@property (nonatomic ,strong) TaskDetailModel *taskDetailModel;
@end

@implementation TaskDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"返佣审核详情";
    self.view.backgroundColor = BackgroundColor;
    [self requestData];
    
     UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.collectionView.delaysContentTouches = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = LineColor;
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(10);
        make.right.mas_equalTo(self.view).offset(-10);
        make.top.mas_equalTo(self.view).offset(10);
        make.bottom.mas_equalTo(self.view).offset(-10);
    }];
}

- (void)requestData{
    BLOCKSELF
    [XNetWork requestNetWorkWithUrl:Xproduct_apply_detail andModel:@{@"productApplyId":@""} andSuccessBlock:^(ResponseModel *model) {
        blockSelf.taskDetailModel = [TaskDetailModel mj_objectWithKeyValues:model.data];
        [blockSelf.collectionView reloadData];
    } andFailBlock:^(ResponseModel *model) {
        
    }];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(section == 0){
        return self.taskDetailModel.prodSubmitPicUrl.count;
    }
    return 0;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"taskdetailcell" forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.taskDetailModel.prodSubmitPicUrl[indexPath.row]]];
    [cell.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(cell);
    }];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
    if (indexPath.section == 0) {
        UILabel *timeLab = [[UILabel alloc]init];
        [timeLab setText:[NSString stringWithFormat:@"提交时间 %@",self.taskDetailModel.ctmSubmitTimeStr]];
        [timeLab setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
        [timeLab setTextColor:LabelAssistantColor];
        [view addSubview:timeLab];
        [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(view).offset(AdaptationWidth(14));
            make.top.mas_equalTo(view).offset(AdaptationWidth(9));
        }];
        
        UILabel *titleLab = [[UILabel alloc]init];
        [titleLab setText:@"上传图片"];
        [titleLab setFont:[UIFont systemFontOfSize:AdaptationWidth(20)]];
        [titleLab setTextColor:LabelMainColor];
        [view addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(view).offset(AdaptationWidth(14));
            make.top.mas_equalTo(timeLab.mas_bottom).offset(AdaptationWidth(16));
        }];
        return view;
    }
    UILabel *titleLab = [[UILabel alloc]init];
    [titleLab setText:@"上传文本"];
    [titleLab setFont:[UIFont systemFontOfSize:AdaptationWidth(20)]];
    [titleLab setTextColor:LabelMainColor];
    [view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view).offset(AdaptationWidth(14));
        make.top.mas_equalTo(view).offset(AdaptationWidth(9));
    }];
    
    UILabel *detailLab = [[UILabel alloc]init];
    detailLab.numberOfLines = 0;
    [detailLab setText:self.taskDetailModel.prodSubmitContent];
    [detailLab setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
    [detailLab setTextColor:LabelMainColor];
    [view addSubview:detailLab];
    [detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view).offset(AdaptationWidth(14));
        make.right.mas_equalTo(view).offset(AdaptationWidth(-14));
        make.top.mas_equalTo(titleLab.mas_bottom).offset(AdaptationWidth(10));
    }];
    
    UILabel *notiLab = [[UILabel alloc]init];
    [notiLab setText:self.taskDetailModel.prodTradeAuditRemark];
    [notiLab setFont:[UIFont systemFontOfSize:AdaptationWidth(12)]];
    [notiLab setTextColor:LabelAssistantColor];
    [view addSubview:notiLab];
    [notiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view).offset(AdaptationWidth(16));
        make.right.mas_equalTo(view).offset(AdaptationWidth(-16));
        make.bottom.mas_equalTo(view).offset(AdaptationWidth(-14));
    }];
    return view;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
   
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
            
            return CGSizeMake(ScreenWidth, AdaptationWidth(78));
        }
            break;
        case 1:{
            
            return CGSizeMake(ScreenWidth, AdaptationWidth(175));
        }
            break;
        
        default:
            break;
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
            
        case 0:{
            
            return CGSizeMake(AdaptationWidth(94), AdaptationWidth(94));;
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
- (TaskDetailModel *)taskDetailModel{
    if (!_taskDetailModel) {
        _taskDetailModel = [[TaskDetailModel alloc]init];
    }
    return _taskDetailModel;
}
@end
