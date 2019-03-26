//
//  QRcodeView.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/25.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QRcodeView : UIView
@property (weak, nonatomic) IBOutlet UIView *QRcodeMainView;
@property (weak, nonatomic) IBOutlet UIView *QRcodeDownView;
@property (weak, nonatomic) IBOutlet UIImageView *QRimageView;
@property (weak, nonatomic) IBOutlet UIImageView *QRcodeImageView;
@property (weak, nonatomic) IBOutlet UILabel *QRtitle;
@property (weak, nonatomic) IBOutlet UILabel *QRmoney;
@property (nonatomic ,copy) XBlock btnBlock;
@end

NS_ASSUME_NONNULL_END
