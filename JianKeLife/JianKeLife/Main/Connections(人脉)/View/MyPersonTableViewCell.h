//
//  MyPersonTableViewCell.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/19.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyPersonTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *LabTitle;
@property (weak, nonatomic) IBOutlet UILabel *labMoney;
@property (weak, nonatomic) IBOutlet UILabel *labNum;
@property (nonatomic ,strong) ConnectionFirstModel *connectionFirstModel;
@end

NS_ASSUME_NONNULL_END
