//
//  TaskTableViewCell.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/19.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "TaskModel.h"
#import "TaskViewModel.h"
NS_ASSUME_NONNULL_BEGIN


@interface TaskTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;
@property (weak, nonatomic) IBOutlet UILabel *celltitle;
@property (weak, nonatomic) IBOutlet UILabel *cellMoney;
@property (weak, nonatomic) IBOutlet UILabel *cellDate;
@property (weak, nonatomic) IBOutlet UILabel *cellTitelDate;
@property (weak, nonatomic) IBOutlet UIButton *cellGiveBtn;
@property (weak, nonatomic) IBOutlet UIButton *cellGoBtn;
@property (weak, nonatomic) IBOutlet UIButton *cellLookBtn;
@property (weak, nonatomic) IBOutlet UIButton *cellVerifyBtn;
@property (nonatomic ,assign) TaskTableViewType taskTableView;
@property (nonatomic ,copy) XBlock taskCellBlock;
@property (nonatomic ,copy) XBlock taskCellCancelBlock;
@property (nonatomic ,strong) TaskModel *model;//数据模型
@end

NS_ASSUME_NONNULL_END
