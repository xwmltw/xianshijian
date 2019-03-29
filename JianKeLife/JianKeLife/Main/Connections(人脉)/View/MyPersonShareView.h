//
//  MyPersonShareView.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/29.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyPersonShareView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *QRImageView;
@property (weak, nonatomic) IBOutlet UIView *QRDownBGView;
@property (weak, nonatomic) IBOutlet UIView *QRMainBGView;
@property (weak, nonatomic) IBOutlet UIView *QRBGView;
@property (nonatomic ,copy) XBlock btnBlock;
@end

NS_ASSUME_NONNULL_END
