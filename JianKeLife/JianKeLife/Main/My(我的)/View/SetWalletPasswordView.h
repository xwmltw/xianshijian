//
//  SetWalletPasswordView.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/27.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SetWalletPasswordView : UIView
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic ,copy) XBlock setPasswordBtnBlock;
@end

NS_ASSUME_NONNULL_END
