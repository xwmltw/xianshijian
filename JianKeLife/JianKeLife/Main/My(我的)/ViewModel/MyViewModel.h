//
//  MyViewModel.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/18.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyViewModel : NSObject
@property (nonatomic ,strong) NSMutableArray *dataSource;
@property (nonatomic ,strong) MyModel *myModel;
@property (nonatomic ,copy) XBlock requestMyInfoBlock;
- (void)requestUserInfo;
@end

NS_ASSUME_NONNULL_END
