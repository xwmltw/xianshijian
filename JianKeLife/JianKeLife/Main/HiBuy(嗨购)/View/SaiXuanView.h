//
//  SaiXuanView.h
//  JianKeLife
//
//  Created by yanqb on 2019/4/25.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SaiXuanView : UIView
@property (nonatomic ,strong) UITextField *nimText;
@property (nonatomic ,strong) UITextField *maxText;
@property (nonatomic ,copy) XDoubleBlock btnBlock;
@end

NS_ASSUME_NONNULL_END
