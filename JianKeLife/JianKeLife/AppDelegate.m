//
//  AppDelegate.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/4.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "AppDelegate.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "UserLocation.h"
#import "BaseMainTBVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //第三方配置
    [self addThreeConfig:launchOptions];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    BaseMainTBVC * tbVC = [[BaseMainTBVC alloc]init];
    //    [tbVC.tabBar setBackgroundImage:[UIImage imageNamed:@"ele_night_back_sky"]];
    //    [tbVC.tabBar setBackgroundColor:[UIColor blueColor]];
    self.window.rootViewController =tbVC;
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)addThreeConfig:(NSDictionary *)launchOptions{
    //键盘
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = @"完成";
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    
    [TalkingData setExceptionReportEnabled:YES];
    [TalkingData sessionStarted:TalkingData_AppID withChannelId:TalkingData_ChannelId];
    
    //高德
    [AMapServices sharedServices].apiKey = AMapKey;
    [[UserLocation sharedInstance]UserLocation];
    
//    // 极光推送
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];//清楚badage
//    //Required
//    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
//    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
//    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
//        // 可以添加自定义categories
//        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
//        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
//    }
//    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
//
//    // Optional
//    // 获取IDFA
//    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
//    //    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
//
//    // Required
//    // init Push
//    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
//    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
//    [JPUSHService setupWithOption:launchOptions appKey:JPAppKey
//                          channel:@"AppStore"
//                 apsForProduction:YES
//            advertisingIdentifier:nil];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
