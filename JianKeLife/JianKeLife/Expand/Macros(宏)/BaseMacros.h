 //
//  BaseMacros.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/4.
//  Copyright © 2019年 xwm. All rights reserved.
//

#ifndef BaseMacros_h
#define BaseMacros_h


//-------------------DEBUG模式下输出-------------------------
#ifdef DEBUG
//#define MyLog(...)  NSLog(__VA_ARGS__)
#define MyLog(s, ... ) NSLog( @"[%@ in line %d] ===============>%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define MyLog(...)
#endif

/**
 *  尺寸设置宏定义区
 */
//屏幕宽高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

// 根据屏幕宽度适配宽度,参数a是在iphone 6(即375宽度)情况下的宽
#define AdaptationWidth(a) ceilf(a * (ScreenWidth/375))
#define AdaptationHeight(a) ceilf(a * (ScreenHeight/667))
/** 颜色*/
#define XColorWithRBBA(r,g,b,a) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:(a)]//通过R,G,B,A设置颜色
#define XCGColorWithRGBA(r,g,b,a) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:(a)].CGcolor//通过R,G,B,A设置边框颜色
#define XColorWithRGB(r,g,b)  [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1]//通过R,G,B
#define AppMainColor  [UIColor colorWithRed:(56.0/255.0) green:(123.0/255.0) blue:(230.0/255.0) alpha:1]//通过R,G,B
#define LabelMainColor  [UIColor colorWithRed:(58.0/255.0) green:(58.0/255.0) blue:(58.0/255.0) alpha:1]//通过R,G,B
#define RedColor  [UIColor colorWithRed:(255.0/255.0) green:(103.0/255.0) blue:(103.0/255.0) alpha:1]//通过R,G,B
#define blueColor  [UIColor colorWithRed:(146.0/255.0) green:(206.0/255.0) blue:(252.0/255.0) alpha:1]//通过R,G,B
#define LabelAssistantColor  [UIColor colorWithRed:(171.0/255.0) green:(171.0/255.0) blue:(171.0/255.0) alpha:1]//通过R,G,B
#define LabelShallowColor  [UIColor colorWithRed:(157.0/255.0) green:(157.0/255.0) blue:(157.0/255.0) alpha:1]//通过R,G,B
#define LineColor  [UIColor colorWithRed:(238.0/255.0) green:(238.0/255.0) blue:(238.0/255.0) alpha:1]//通过R,G,B
#define BackgroundColor  [UIColor colorWithRed:(248.0/255.0) green:(248.0/255.0) blue:(248.0/255.0) alpha:1]//通过R,G,B
/** 通知 */
#define XNotificationCenter [NSNotificationCenter defaultCenter]
#define WDUserDefaults       [NSUserDefaults standardUserDefaults]

/** 单例*/
#define XSharedInstance(name)\
static id _instance;\
+(instancetype)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
\
+(instancetype)sharedInstance\
{\
return [[self alloc]init];\
}\
-(id)copyWithZone:(NSZone *)zone\
{\
return _instance;\
}\
\
-(id)mutableCopyWithZone:(NSZone *)zone\
{\
return _instance;\
}

//处理NSNull
#define XNULL_TO_NIL(obj) ({ __typeof__ (obj) __obj = (obj); __obj == [NSNull null] ? nil : obj; })

/** block self*/

#define WEAKSELF typeof(self) __weak weakSelf = self;
#define BLOCKSELF typeof(self) __block blockSelf = self;
#define XBlockExec(block, ...) if (block) { block(__VA_ARGS__); };
typedef void (^XBlock)(id result);
typedef void (^XIntegerBlock)(NSInteger result);
typedef void (^XBoolBlock)(BOOL bRet);
typedef void (^XDoubleBlock)(id result1, id result2);
#endif /* BaseMacros_h */
