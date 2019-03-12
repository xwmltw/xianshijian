//
//  BaseWebVC.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/5.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "BaseMainNC.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseWebVC : BaseMainNC
@property(nonatomic,assign)CGRect viewFrame;

- (void)reloadForGetWebView:(NSString *)htmlStr;
- (void)reloadForPostWebView:(NSString *)htmlStr parameters:(NSDictionary *)parameters;
@end

NS_ASSUME_NONNULL_END
