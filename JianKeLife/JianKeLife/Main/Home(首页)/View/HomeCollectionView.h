//
//  HomeCollectionView.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/20.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeCollectionView : UICollectionView
@property (nonatomic ,copy) XIntegerBlock scrollSelectBlock;
@property (nonatomic ,copy) XBlock  collectionSelectBlock;

@property (nonatomic ,strong) HomeViewModel *homeViewModel;
@end

NS_ASSUME_NONNULL_END
