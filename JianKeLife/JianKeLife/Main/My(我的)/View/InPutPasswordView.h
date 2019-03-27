//
//  InPutPasswordView.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/27.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InPutPasswordView : UIView
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *labMoney;
@property (weak, nonatomic) IBOutlet UILabel *labDetail;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (nonatomic ,copy) XBlock inPutPasswordBtnBlock;
@end

NS_ASSUME_NONNULL_END
