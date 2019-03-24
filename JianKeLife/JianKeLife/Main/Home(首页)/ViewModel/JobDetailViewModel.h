//
//  JobDetailViewModel.h
//  JianKeLife
//
//  Created by 肖伟民 on 2019/3/24.
//  Copyright © 2019 xwm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobDetailViewModel : NSObject
@property (nonatomic ,strong) ProductModel *productModel;
@property (nonatomic ,copy) XBlock productDetailBlock;
@property (nonatomic ,copy) XBlock productStateBlock;
- (void)requestDetialData;
@end

NS_ASSUME_NONNULL_END
