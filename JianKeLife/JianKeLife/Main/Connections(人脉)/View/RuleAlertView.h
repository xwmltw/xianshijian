//
//  RuleAlertView.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/29.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RuleAlertView : UIView
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *labContent;
@property (nonatomic ,copy) XBlock ruleBtnBlcok;

@end

NS_ASSUME_NONNULL_END
