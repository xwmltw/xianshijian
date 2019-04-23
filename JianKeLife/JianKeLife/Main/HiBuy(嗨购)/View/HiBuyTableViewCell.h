//
//  HiBuyTableViewCell.h
//  JianKeLife
//
//  Created by yanqb on 2019/4/22.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HiBuyProductModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HiBuyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *proImage;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UIImageView *typeImage;
@property (weak, nonatomic) IBOutlet UILabel *proNameLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UILabel *numLab;
@property (weak, nonatomic) IBOutlet UILabel *expcetLab;
@property (weak, nonatomic) IBOutlet UILabel *juanLab;
@property (weak, nonatomic) IBOutlet UILabel *juanAffter;
@property (nonatomic, strong) HiBuyProductModel *model;
@end

NS_ASSUME_NONNULL_END
