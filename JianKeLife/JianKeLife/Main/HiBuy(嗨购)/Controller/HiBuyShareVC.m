//
//  HiBuyShareVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/4/24.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "HiBuyShareVC.h"
#import "HiBuyShareCodeView.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareSheetConfiguration.h>

@interface HiBuyShareVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic ,strong) UIView *view3;
@property (nonatomic ,strong) UICollectionView *collectionView;
@property (nonatomic ,strong) HiBuyShareCodeView *hiBuyShareCodeView;
@end

@implementation HiBuyShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分享";
    
    self.view.backgroundColor = BackgroundColor;
    
    UIView *view1 = [[UIView alloc]init];
    view1.backgroundColor = XColorWithRGB(255, 188, 0);

    [self.view addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(AdaptationWidth(28));
    
    }];
    
    UIImageView *headerImage2 = [[UIImageView alloc]init];
    [headerImage2 setImage:[UIImage imageNamed:@"icon_myOrder_noti"]];
    [view1 addSubview:headerImage2];
    [headerImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view1).offset(AdaptationWidth(10));
        make.centerY.mas_equalTo(view1);
        make.width.height.mas_equalTo(AdaptationWidth(20));
    }];
    
    
    
    UILabel *loginLab = [[UILabel alloc]init];
    [loginLab setText:[NSString stringWithFormat:@"分享预估收益 ¥%.2f",[self.hiBuyShareInfoModel.commissionAmount doubleValue]]];
    [loginLab setFont:[UIFont systemFontOfSize:AdaptationWidth(12)]];
    [loginLab setTextColor:XColorWithRGB(255, 162, 0)];
    [view1 addSubview:loginLab];
    [loginLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view1);
        make.left.mas_equalTo(headerImage2.mas_right).offset(AdaptationWidth(4));
    }];
    
    
    
    UIView *view2 = [[UIView alloc]init];
    view2.backgroundColor = [UIColor whiteColor];
    [view2 setCornerValue:8];
    [self.view addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view1.mas_bottom).offset(AdaptationWidth(6));
        make.left.mas_equalTo(self.view).offset(AdaptationWidth(10));
        make.right.mas_equalTo(self.view).offset(AdaptationWidth(-10));
        make.height.mas_equalTo(AdaptationWidth(162));
    }];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.numberOfLines = 0;
    [titleLab setText:self.hiBuyShareInfoModel.title];
    [titleLab setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
    [titleLab setTextColor:LabelMainColor];
    [view2 addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view2).offset(AdaptationWidth(10));
        make.left.mas_equalTo(view2).offset(AdaptationWidth(16));
        make.right.mas_equalTo(view2).offset(AdaptationWidth(-16));
    }];
    UILabel *oldLab = [[UILabel alloc]init];
    [oldLab setText:[NSString stringWithFormat:@"【原价】%.2f",[self.hiBuyShareInfoModel.zkFinalPrice doubleValue]]];
    [oldLab setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
    [oldLab setTextColor:LabelMainColor];
    [view2 addSubview:oldLab];
    [oldLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLab.mas_bottom).offset(AdaptationWidth(8));
        make.left.mas_equalTo(view2).offset(AdaptationWidth(18));
        
    }];
    
    UILabel *newLab = [[UILabel alloc]init];
    [newLab setText:[NSString stringWithFormat:@"【卷后价】%.2f",[self.hiBuyShareInfoModel.afterCouplePrice doubleValue]]];
    [newLab setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
    [newLab setTextColor:LabelMainColor];
    [view2 addSubview:newLab];
    [newLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(oldLab.mas_bottom).offset(AdaptationWidth(8));
        make.left.mas_equalTo(view2).offset(AdaptationWidth(18));
        
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = LineColor;
    [line setCornerValue:8];
    [view2 addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(newLab.mas_bottom).offset(AdaptationWidth(12));
        make.left.mas_equalTo(view2).offset(AdaptationWidth(15));
        make.right.mas_equalTo(view2).offset(AdaptationWidth(-25));
        make.height.mas_equalTo(AdaptationWidth(1));
    }];
    
    UILabel *copyLab = [[UILabel alloc]init];
    [copyLab setText:[NSString stringWithFormat:@"%@",self.hiBuyShareInfoModel.tpwdTextDesc]];
    [copyLab setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
    [copyLab setTextColor:LabelMainColor];
    [view2 addSubview:copyLab];
    [copyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom).offset(AdaptationWidth(12));
        make.left.mas_equalTo(view2).offset(AdaptationWidth(18));
        
    }];
    
    
    
    
    
    
    
    
    NSInteger row = self.hiBuyShareInfoModel.smallPicUrl.count;
    CGFloat heightView = ((row / 3)+1) * 110 + 50;
    
    self.view3 = [[UIView alloc]init];
    self.view3.backgroundColor = [UIColor whiteColor];
    [self.view3 setCornerValue:8];
    [self.view addSubview:self.view3];
    [self.view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view2.mas_bottom).offset(AdaptationWidth(10));
        make.left.mas_equalTo(self.view).offset(AdaptationWidth(10));
        make.right.mas_equalTo(self.view).offset(AdaptationWidth(-10));
        make.height.mas_equalTo(AdaptationWidth(heightView));
    }];
    
    UILabel *viewLab3 = [[UILabel alloc]init];
    [viewLab3 setText:@"商品主图"];
    [viewLab3 setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
    [viewLab3 setTextColor:LabelMainColor];
    [_view3 addSubview:viewLab3];
    [viewLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view3).offset(AdaptationWidth(10));
        make.left.mas_equalTo(self.view3).offset(AdaptationWidth(16));
    }];
    
    [self.view3 addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(viewLab3.mas_bottom).offset(8);
        make.left.right.bottom.mas_equalTo(self.view3);
    }];
    
    
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(AdaptationWidth(58));
    }];
    
    UIButton *shareBtn = [[UIButton alloc]init];
    shareBtn.tag = 5031;
    [shareBtn setCornerValue:AdaptationWidth(4)];
    [shareBtn setTitle:@"分享口令" forState:UIControlStateNormal];
    [shareBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(17)]];
    shareBtn.backgroundColor = blueColor;
    [shareBtn setImage:[UIImage imageNamed:@"icon_laxin_share"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:shareBtn];
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView).offset(AdaptationWidth(7));
        make.left.mas_equalTo(bottomView).offset(AdaptationWidth(10));
        make.bottom.mas_equalTo(bottomView).offset(AdaptationWidth(-7));
        make.width.mas_equalTo(AdaptationWidth(170));
    }];
    
    UIButton *getBtn = [[UIButton alloc]init];
    getBtn.tag = 5032;
    [getBtn setCornerValue:AdaptationWidth(4)];
    [getBtn setTitle:@"分享图片" forState:UIControlStateNormal];
    [getBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(17)]];
    getBtn.backgroundColor = RedColor;
    [getBtn setImage:[UIImage imageNamed:@"icon_laxin_buy"] forState:UIControlStateNormal];
    [getBtn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:getBtn];
    [getBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView).offset(AdaptationWidth(7));
        make.right.mas_equalTo(bottomView).offset(AdaptationWidth(-10));
        make.bottom.mas_equalTo(bottomView).offset(AdaptationWidth(-7));
        make.width.mas_equalTo(AdaptationWidth(170));
    }];
    
}
- (void)btnOnClick:(UIButton *)btn{
    switch (btn.tag) {
        case 5031:
        {
            NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
            [shareParams SSDKSetupShareParamsByText:[NSString stringWithFormat:@"%@\n\n%@",self.hiBuyShareInfoModel.title,self.hiBuyShareInfoModel.tpwdTextDesc]
                                             images:nil
                                                url:nil
                                              title:self.hiBuyShareInfoModel.title
                                               type:SSDKContentTypeAuto];
            [ShareSDK share:SSDKPlatformSubTypeWechatSession parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                
            }];
        }
            break;
        case 5032:
        {
            NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
            [shareParams SSDKSetupShareParamsByText:[NSString stringWithFormat:@"%@\n\n%@",self.hiBuyShareInfoModel.title,self.hiBuyShareInfoModel.tpwdTextDesc]
                                             images:nil
                                                url:nil
                                              title:self.hiBuyShareInfoModel.title
                                               type:SSDKContentTypeAuto];
            [ShareSDK share:SSDKPlatformSubTypeWechatSession parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                
            }];
           
        }
            break;
            
        default:
            break;
    }
}
#pragma mark -UICollectionView
//有多少的分组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    
    return CGSizeMake(0, 0);
}
//每个分组里有多少个item
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.hiBuyShareInfoModel.smallPicUrl.count;
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(AdaptationWidth(99), AdaptationWidth(99));
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(AdaptationWidth(10), AdaptationWidth(10), AdaptationWidth(10), AdaptationWidth(10));
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //根据identifier从缓冲池里去出cell
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HiBuyShareCell" forIndexPath:indexPath];
    UIImageView *imageCell = [[UIImageView alloc]init];
    [imageCell setCornerValue:4];
//    imageCell.backgroundColor = blueColor;
    [imageCell sd_setImageWithURL:[NSURL URLWithString:self.hiBuyShareInfoModel.smallPicUrl[indexPath.row]]];
    [cell.contentView addSubview:imageCell];
    [imageCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(cell);

    }];
    UIButton *cellBtn = [[UIButton alloc]init];
    [cellBtn addTarget:self action:@selector(cellBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cellBtn setImage:[UIImage imageNamed:@"icon_image_unselect"] forState:UIControlStateNormal];
    [cellBtn setImage:[UIImage imageNamed:@"icon_image_select"] forState:UIControlStateSelected];
    [cell.contentView addSubview:cellBtn];
    [cellBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(cell);
        make.height.with.mas_equalTo(20);
    }];
    if (indexPath.row == 0) {
        cellBtn.selected = YES;
        
        UILabel *cellLab = [[UILabel alloc]init];
        [cellLab setText:@"二维码推广图"];
        cellLab.alpha = 0.8;
        [cellLab setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
        [cellLab setTextColor:LabelMainColor];
        [cell.contentView addSubview:cellLab];
        [cellLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(cell);
            make.height.mas_equalTo(AdaptationWidth(30));
        }];
    }
    
//    [cell.profilePhoto sd_setImageWithURL:[NSURL URLWithString:self.hiBuyShareInfoModel.smallPicUrl[indexPath.row]]];
    
    
    
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        self.hiBuyShareCodeView.hidden = NO;
        self.hiBuyShareCodeView.titleLab.text = self.hiBuyShareInfoModel.title;
        [self.hiBuyShareCodeView.proImage sd_setImageWithURL:[NSURL URLWithString:self.hiBuyShareInfoModel.smallPicUrl[0]]];
        self.hiBuyShareCodeView.moneyLab.text = [NSString stringWithFormat:@"%.2f",[self.hiBuyShareInfoModel.afterCouplePrice doubleValue]];
        [self.hiBuyShareCodeView.juanBtn setTitle:[NSString stringWithFormat:@"卷   ￥%.2f",[self.hiBuyShareInfoModel.couponAmount doubleValue]] forState:UIControlStateNormal];
        self.hiBuyShareCodeView.codeImage.image = [UIImage qrCodeImageWithInfo:self.hiBuyShareInfoModel.tpwd width:90];
        [[UIApplication sharedApplication].keyWindow addSubview: self.hiBuyShareCodeView];
        WEAKSELF
        [_hiBuyShareCodeView setTapActionWithBlock:^{
            weakSelf.hiBuyShareCodeView.hidden = YES;
        }];
    }else{
        
    }
    
}
- (void)cellBtnOnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"HiBuyShareCell"];
    }
    return _collectionView;
}
- (HiBuyShareCodeView *)hiBuyShareCodeView{
    if (!_hiBuyShareCodeView) {
        _hiBuyShareCodeView = [[[NSBundle mainBundle]loadNibNamed:@"HiBuyShareCodeView" owner:nil options:nil]lastObject];
        _hiBuyShareCodeView.frame = [UIScreen mainScreen].bounds;
        
        
    }
    return _hiBuyShareCodeView;
}
@end
