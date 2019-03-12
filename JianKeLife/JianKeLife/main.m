//
//  main.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/4.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @try {
        @autoreleasepool
        {
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        }
    }
    @catch (NSException* exception)
    {
        NSLog(@"崩溃：Exception=%@\nStack Trace:%@", exception, [exception callStackSymbols]);
    }
}
