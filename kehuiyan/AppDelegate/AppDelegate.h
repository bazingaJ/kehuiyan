//
//  AppDelegate.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/8.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/**
 *  用户登录
 */
- (void)userLogin:(void (^)(BOOL isLogin))completion;


@end

