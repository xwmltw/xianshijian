//
//  TaskDetailModel.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/28.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TaskDetailModel : NSObject
@property (nonatomic ,copy) NSString *ctmSubmitTimeStr;
@property (nonatomic ,copy) NSString *prodTradeAuditRemark;
@property (nonatomic ,copy) NSString *prodSubmitContent;
@property (nonatomic ,strong) NSArray *prodSubmitPicUrl;
//ctmSubmitTimeStr (string, optional): 提交时间说明(字符串：2019-3-12 17:17:17) ,
//entAuditDeadTimeStr (string, optional): 审核截止时间说明 ,
//prodSubmitContent (string, optional): 文本提交内容 ,
//prodSubmitPicUrl (Array[Inline Model 1], optional): 截图提交内容,图片地址 json串
@end

NS_ASSUME_NONNULL_END
