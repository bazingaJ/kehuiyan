//
//  AppDelegate+JPUSH.h
//  jiaxiaopingtai
//
//  Created by 相约在冬季 on 2017/9/28.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "AppDelegate.h"

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>

@interface AppDelegate (JPUSH)<JPUSHRegisterDelegate>

/**
 *  创建JPUSH推送
 */
- (void)setupJPUSH:(NSDictionary *)launchOptions;

@end
