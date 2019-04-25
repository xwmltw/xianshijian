//
//  LaXinView.h
//  JianKeLife
//
//  Created by 肖伟民 on 2019/4/22.
//  Copyright © 2019 xwm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJProgressView.h"
NS_ASSUME_NONNULL_BEGIN

@interface LaXinView : UIView
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UILabel *proDetailLab;
@property (weak, nonatomic) IBOutlet UILabel *titleLab2;
@property (nonatomic ,assign) double progressNum;
@property (nonatomic ,assign) BOOL isProView;
@property (nonatomic ,strong) WJProgressView *progressView;
@property (nonatomic ,copy) XBlock laXinBlock;
@end

NS_ASSUME_NONNULL_END
