//
//  AppDelegate+UMSoc.m
//  Kivii
//
//  Created by 相约在冬季 on 2017/9/26.
//  Copyright © 2017年 Kivii. All rights reserved.
//

#import "AppDelegate+UMSoc.h"
#import "UMMobClick/MobClick.h"

@implementation AppDelegate (UMSoc)

/**
 *  初始化友盟
 */
- (void)setupUMSocial {
    
    //友盟统计
    [MobClick setLogEnabled:NO];
    UMConfigInstance.appKey = @"59dec64ee88bad3d8e000025";
    UMConfigInstance.secret = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];
    
    
//    //打开日志
//    [[UMSocialManager defaultManager] openLog:YES];
//    
//    //注册友盟AppKey
//    [[UMSocialManager defaultManager] setUmSocialAppkey:@"59dec64ee88bad3d8e000025"];
//    
//    //设置QQAppId,appSecret,分享url
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106105002" appSecret:@"oPLttRbElrHEghA6" redirectURL:@"http://mobile.umeng.com/social"];
//    
//    //设置微信的appKey和appSecret
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx0103fc7565e7069c" appSecret:@"1ca7aeff27eafd534c8c3d5e1d1034df" redirectURL:@"http://mobile.umeng.com/social"];
//    
//    //设置新浪的appKey和appSecret
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"1521880094"  appSecret:@"82447cc0109e97c27da1c21bd2a7df69" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
}

@end
