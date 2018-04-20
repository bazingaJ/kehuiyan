//
//  CommonDefine.h
//  liangmaitong
//
//  Created by 相约在冬季 on 2017/1/14.
//  Copyright © 2017年 liangmaitong. All rights reserved.
//

#ifndef CommonDefine_h
#define CommonDefine_h

//获取设备宽、高
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds

//宏定义
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define STATUS_BAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
#define NAV_BAR_HEIGHT 44
#define NAVIGATION_BAR_HEIGHT (NAV_BAR_HEIGHT+STATUS_BAR_HEIGHT)
#define TAB_BAR_HEIGHT (iPhoneX ? (49.f+34.f) : 49.f)
#define HOME_INDICATOR_HEIGHT (iPhoneX ? 34.f : 0.f)

#define IOS7 [[UIDevice currentDevice].systemVersion floatValue] >= 7.0
#define IOS8 [[UIDevice currentDevice].systemVersion floatValue] >= 8.0
#define IOS9 [[UIDevice currentDevice].systemVersion floatValue] >= 9.0

/**
 *  获取系统版本号
 */
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
/**
 *  iPhone or iPad
 */
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_PAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/**
 *  获取Window
 */
#define kWindow [UIApplication sharedApplication].keyWindow
/**
 *  获取AppDelegate
 */
#define APP_DELEGATE ((AppDelegate *)[[UIApplication sharedApplication] delegate])
/**
 *  版本号1.0.0
 */
#define APP_Version [NSString stringWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]]
/**
 *  获取APP名称
 */
#define APP_Name [NSString stringWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]]
/**
 *  系统通知宏定义
 */
#define POST_NOTIFICATION(name) [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil];

#define REGISTER_NOTIFICATION(obj,notif_name,sel)                    \
if([obj respondsToSelector:sel])                            \
[[NSNotificationCenter defaultCenter]    addObserver:obj    \
selector:sel    \
name:notif_name    \
object:nil        \
];

#pragma mark - GCD
//GCD - 在Main线程上运行
#define kDISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(),mainQueueBlock);
//GCD - 开启异步线程
#define kDISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);
//GCD - 一次性执行
#define kDISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);
//GCD - 延迟执行
#define kDISPATCH_MAIN_AFTER(second,mainQueueBlock) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC)), dispatch_get_main_queue(), mainQueueBlock);

//SELF宏定义
#define WS(weakSelf) __unsafe_unretained __typeof(&*self)weakSelf = self;

/**
 *  判断字符串是否为空
 */
#define IsStringEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]) || [(_ref)isEqualToString:@"<null>"] || [(_ref)isEqualToString:@"(null)"]|| [(_ref)isEqualToString:@"null"]||(_ref.length == 0))

/**
 *  NSLog
 */
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

//NSCoding协议遵循
#define kObjectCodingAction  -(id)initWithCoder:(NSCoder *)aDecoder\
{\
self = [super init];\
if (self) {\
[self autoDecode:aDecoder];\
\
}\
return self;\
}\
-(void)encodeWithCoder:(NSCoder *)aCoder\
{\
[self autoEncodeWithCoder:aCoder];\
}\
-(void)setValue:(id)value forUndefinedKey:(NSString *)key\
{\
\
}



#endif /* CommonDefine_h */
