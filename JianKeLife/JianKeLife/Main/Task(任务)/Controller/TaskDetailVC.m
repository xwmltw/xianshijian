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
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"taskdetailcell"];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TaskDetailIdentifier"];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(10);
        make.right.mas_equalTo(self.view).offset(-10);
        make.top.mas_equalTo(self.view).offset(10);
        make.bottom.mas_equalTo(self.view).offset(-10);
    }];
}

- (void)requestData{
    BLOCKSELF
    [XNetWork requestNetWorkWithUrl:Xproduct_apply_detail andModel:@{@"productApplyId":self.productApplyId} andSuccessBlock:^(ResponseModel *model) {
        blockSelf.taskDetailModel = [TaskDetailModel mj_objectWithKeyValues:model.data];
        [blockSelf.collectionView reloadData];
    } andFailBlock:^(ResponseModel *model) {
        
    }];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
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

//- (UIView *)col
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {

        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TaskDetailIdentifier" forIndexPath:indexPath];
        NSArray*views = view.subviews;
        
        for(int i =0; i < views.count; i++) {
            
            [views[i] removeFromSuperview];
            
        }
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
    }else{
        
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
        NSArray*views = footer.subviews;
        
        for(int i =0; i < views.count; i++) {
            
            [views[i] removeFromSuperview];
            
        }
        UILabel *textLab = [[UILabel alloc]init];
        [textLab setText:@"上传文本"];
        [textLab setFont:[UIFont systemFontOfSize:AdaptationWidth(20)]];
        [textLab setTextColor:LabelMainColor];
        [footer addSubview:textLab];
        [textLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(footer).offset(AdaptationWidth(14));
            make.top.mas_equalTo(footer).offset(AdaptationWidth(9));
        }];
        
        UILabel *detailLab = [[UILabel alloc]init];
        detailLab.numberOfLines = 0;
        [detailLab setText:self.taskDetailModel.prodSubmitContent];
        [detailLab setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
        [detailLab setTextColor:LabelMainColor];
        [footer addSubview:detailLab];
        [detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(footer).offset(AdaptationWidth(14));
            make.right.mas_equalTo(footer).offset(AdaptationWidth(-14));
            make.top.mas_equalTo(textLab.mas_bottom).offset(AdaptationWidth(10));
        }];
        
        UILabel *notiLab = [[UILabel alloc]init];
        notiLab.numberOfLines = 0;
        [notiLab setText:[NSString stringWithFormat:@"注：商户若未在 %@ 完成审核，平台将自动打款给用户。",self.taskDetailModel.entAuditDeadTimeStr]];
        [notiLab setFont:[UIFont systemFontOfSize:AdaptationWidth(12)]];
        [notiLab setTextColor:LabelAssistantColor];
        [footer addSubview:notiLab];
        [notiLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(footer).offset(AdaptationWidth(16));
            make.right.mas_equalTo(footer).offset(AdaptationWidth(-16));
            make.bottom.mas_equalTo(footer).offset(AdaptationWidth(-14));
        }];
        return footer;
    }
    return nil;
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

            
    return CGSizeMake(ScreenWidth, AdaptationWidth(78));
    
   
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(ScreenWidth, AdaptationWidth(175));
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
            
        case 0:{
            
            return CGSizeMake(AdaptationWidth(335)/3 ,AdaptationWidth(335)/3);
        }
            break;
        default:
            break;
    }
    return CGSizeZero;
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(AdaptationWidth(15)/2, AdaptationWidth(15)/2, AdaptationWidth(15)/2, AdaptationWidth(15)/2);//分别为上、左、下、右
}
- (TaskDetailModel *)taskDetailModel{
    if (!_taskDetailModel) {
        _taskDetailModel = [[TaskDetailModel alloc]init];
    }
    return _taskDetailModel;
}
@end
