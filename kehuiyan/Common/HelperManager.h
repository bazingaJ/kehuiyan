//
//  HelperManager.h
//  YiJiaMao_S
//
//  Created by 相约在冬季 on 2016/12/16.
//  Copyright © 2016年 e-yoga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelperManager : NSObject

@property (strong, nonatomic) KLCPopup *popup;

@property (nonatomic, weak) UIViewController *currentVC;
/**
 *  创建单例模式
 *
 *  @author zongjl
 *  @date 2016-12-16
 */
+(HelperManager *)CreateInstance;

/**
 *  是否已登录
 */
@property (nonatomic, assign) BOOL isLogin;

/**
 *  验证是否登录及认证
 */
- (BOOL)isLogin:(BOOL)isAuth completion:(void (^)(NSInteger tIndex))completion;
/**
 *  用户本地信息
 */
- (NSDictionary *)getUserDefaultInfo;
/**
 *  用户ID
 */
@property (nonatomic, strong) NSString *user_id;
/**
 *  用户姓名
 */
@property (nonatomic, strong) NSString *realname;
/**
 *  组织部门
 */
@property (nonatomic, strong) NSString *org_departmentName;
/**
 *  用户头像
 */
@property (nonatomic, strong) NSString *avatar;
/**
 *  手机号码
 */
@property (nonatomic, strong) NSString *mobile;
/**
 *  Token验证
 */
@property (nonatomic, strong) NSString *token;

/**
 *  角色ID
 */
@property (nonatomic, strong) NSString *position_id;

/**
 *  级别ID
 */
@property (nonatomic, strong) NSString *level_id;

/**
 *  级别名称
 */
@property (nonatomic, strong) NSString *level_name;

/**
 *  类别 1.普通 2.专家 3.营养师
 */
@property (nonatomic, strong) NSString *type;

/**
 *  是否可以发布活动
 */
@property (nonatomic, strong) NSString *is_send_activity;
/**
 *  清除账号
 */
- (void)clearAcc;
/**
 *  获取APP版本号
 */
- (NSString *)getAppVersion;
/**
 *  获取APP名称
 */
- (NSString *)getAppName;
/**
 *  获取广告ID
 */
- (NSString *)getIDFA;
/**
 *  支付支付穿处理
 */
- (NSDictionary *)dictionaryFromURLParameters:(NSString *)str;

@end
