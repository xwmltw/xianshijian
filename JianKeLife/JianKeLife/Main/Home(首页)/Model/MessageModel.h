//
//  MessageModel.h
//  JianKeLife
//
//  Created by yanqb on 2019/5/10.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageModel : NSObject
@property (nonatomic ,strong) NSString *messageTitle;
@property (nonatomic ,strong) NSString *messageContent;
@property (nonatomic ,strong) NSString *targetPageType;
@property (nonatomic ,strong) NSNumber *targetPageId;
@property (nonatomic ,strong) NSNumber *modelId;
@property (nonatomic ,strong) NSString *targetUrl;
@property (nonatomic ,strong) NSNumber *isRead;
@property (nonatomic ,strong) NSString *createTime;
@property (nonatomic ,strong) NSString *createTimeDesc;
@end
//messageTitle (string, optional): 消息标题 ,
//messageContent (string, optional): 消息内容 ,
//targetPageType (integer, optional): 目标页面类型: 0无跳转页面 1 app原生页面 2 h5页 ,
//targetPageId (integer, optional): 目标页面(原生页面): 1 到账收益页面 2返佣页面 ,
//modelId (integer, optional): 模型id(原生页面) ,
//targetUrl (string, optional): 目标页面跳转地址(h5页面) ,
//isRead (integer, optional): 是否已读 1已读 0未读 ,
//createTime (string, optional): 创建时间 ,
//createTimeDesc (string, optional): 创建时间描述(格式化之后)
NS_ASSUME_NONNULL_END
