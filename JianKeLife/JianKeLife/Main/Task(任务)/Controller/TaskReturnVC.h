//
//  TaskReturnVC.h
//  JianKeLife
//
//  Created by yanqb on 2019/4/1.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "BaseMainVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface TaskReturnVC : BaseMainVC
@property (nonatomic ,copy) NSNumber *productApplyId;
@property (nonatomic ,copy) NSString *productSubmitType;
//初始化collectionView
- (void)initPickerView;
//修改collectionView的位置
- (void)updatePickerViewFrameY:(CGFloat)Y;
//获得collectionView 的 Frame
- (CGRect)getPickerViewFrame;

//获得collectionView 的 Frame
- (CGRect)getPickerViewFrame;

//获取选中的所有图片信息
- (NSArray*)getSmallImageArray;
- (NSArray*)getBigImageArray;
- (NSArray*)getALAssetArray;
@end

NS_ASSUME_NONNULL_END
