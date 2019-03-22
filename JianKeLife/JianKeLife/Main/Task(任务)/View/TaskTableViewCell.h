//
//  TaskTableViewCell.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/19.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger ,TaskTableView) {
    TaskTableViewStay,
    TaskTableViewIng,
    TaskTableViewOver,
};

@interface TaskTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;
@property (weak, nonatomic) IBOutlet UILabel *celltitle;
@property (weak, nonatomic) IBOutlet UILabel *cellMoney;
@property (weak, nonatomic) IBOutlet UILabel *cellDate;
@property (weak, nonatomic) IBOutlet UIButton *cellGiveBtn;
@property (weak, nonatomic) IBOutlet UIButton *cellGoBtn;
@property (weak, nonatomic) IBOutlet UIButton *cellLookBtn;
@property (weak, nonatomic) IBOutlet UIButton *cellVerifyBtn;

@property (nonatomic ,assign) TaskTableView taskTableView;
@property (nonatomic ,strong) id model;//数据模型
@end

NS_ASSUME_NONNULL_END
