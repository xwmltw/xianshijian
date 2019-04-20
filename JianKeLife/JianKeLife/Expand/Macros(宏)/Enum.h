//
//  Enum.h
//  LaiFengLoan
//
//  Created by yanqb on 2018/11/2.
//  Copyright © 2018年 xwm. All rights reserved.
//

#ifndef Enum_h
#define Enum_h
//订单列表枚举
typedef NS_ENUM(NSInteger ,MyOrderTableViewType) {
    MyOrderTableViewTypeAll     = 0,
    MyOrderTableViewTypePay     = 12,
    MyOrderTableViewTypeOver    = 3,
    MyOrderTableViewTypefail    = 13,
};
//订单任务列表枚举
typedef NS_ENUM(NSInteger ,MyTaskTableViewType) {
    MyTaskTableViewTypeAll     = 0,
    MyTaskTableViewTypeStay    ,
    MyTaskTableViewTypeIng    ,
    MyTaskTableViewTypeOver    ,
};
#endif /* Enum_h */
