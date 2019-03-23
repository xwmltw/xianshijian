//
//  SearchCollectionView.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/23.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchVieModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SearchCollectionView : UICollectionView
@property (nonatomic ,copy) XIntegerBlock  collectionSelectBlock;
@property (nonatomic ,strong) SearchVieModel *searchVieModel;

@end

NS_ASSUME_NONNULL_END
