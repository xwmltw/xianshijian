//
//  MessageDetailVC.h
//  JianKeLife
//
//  Created by yanqb on 2019/5/10.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "BaseMainVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageDetailVC : BaseMainVC
@property (nonatomic ,strong) NSNumber *messageType;//消息类型: 1 通知 2收益 3互动 ,
@end

NS_ASSUME_NONNULL_END
