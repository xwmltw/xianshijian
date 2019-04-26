//
//  MyOrderTableViewCell.h
//  JianKeLife
//
//  Created by yanqb on 2019/4/18.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyOrderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UILabel *payMoney;
@property (weak, nonatomic) IBOutlet UILabel *expectLab;
@property (weak, nonatomic) IBOutlet UILabel *productNo;
@property (weak, nonatomic) IBOutlet UIButton *copybtn;
@property (weak, nonatomic) IBOutlet UILabel *stautsLab;
@property (nonatomic ,strong) MyOrderModel *model;
@property (nonatomic ,strong) NSString *tradeId;
//- (void)
@end

NS_ASSUME_NONNULL_END
