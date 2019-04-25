//
//  WJProgressView.h
//  JianKeLife
//
//  Created by yanqb on 2019/4/25.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WJProgressView : UIView
@property (nonatomic,assign)CGFloat progress;//进度参数取值范围0~100
@property (nonatomic,strong)UIColor *progressColor;//颜色
@end

NS_ASSUME_NONNULL_END
