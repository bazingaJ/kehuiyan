//
//  HelperManager.m
//  YiJiaMao_S
//
//  Created by 相约在冬季 on 2016/12/16.
//  Copyright © 2016年 e-yoga. All rights reserved.
//

#import "HelperManager.h"

@implementation HelperManager

/**
 *  创建单例模式
 */
static HelperManager *_createInstance;
+ (HelperManager *)CreateInstance{
    if (!_createInstance){
        _createInstance = [[super allocWithZone:NULL] init];
    }
    return _createInstance;
}
/**
 *  是否已登录
 */
- (BOOL)isLogin {
    if(IsStringEmpty(self.user_id)) {
        return NO;
    }
    return YES;
}
/**
 *  是否登录
 */
- (BOOL)isLogin:(BOOL)isAuth completion:(void (^)(NSInteger tIndex))completion {
    if(![self isLogin]) {
        
        //用户登录
        [APP_DELEGATE userLogin:^(BOOL isLogin)
        {
            if(completion) {
                completion(isLogin);
            }
            
        }];
        
        return NO;
    }
    if(isAuth) {
        //认证处理
        
        return YES;
    }
    return YES;
}
/**
 *  获取用户信息
 */
- (NSDictionary *)getUserDefaultInfo {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userDic = [userDefaults objectForKey:@"userInfo"];
    return userDic;
}
/**
 *  用户ID
 */
- (NSString *)user_id {
    NSDictionary *userDic = [self getUserDefaultInfo];
    NSString *user_id = [userDic objectForKey:@"user_id"];
    return user_id;
}
/**
 *  用户昵称
 */
- (NSString *)realname {
    NSDictionary *userDic = [self getUserDefaultInfo];
    NSString *realname = [userDic objectForKey:@"realname"];
    return realname;
}
/**
 *  用户昵称
 */
- (NSString *)org_departmentName {
    NSDictionary *userDic = [self getUserDefaultInfo];
    NSString *department = [userDic objectForKey:@"department"];
    NSString *position = [userDic objectForKey:@"position"];
    
    return [NSString stringWithFormat:@"%@  %@",department,position];
}
/**
 *  用户头像
 */
- (NSString *)avatar {
    NSDictionary *userDic = [self getUserDefaultInfo];
    NSString *icon_src = [userDic objectForKey:@"avatar"];
    return icon_src;
}
/**
 *  手机号码
 */
- (NSString *)mobile {
    NSDictionary *userDic = [self getUserDefaultInfo];
    NSString *mobile = [userDic objectForKey:@"mobile"];
    return mobile;
}
/**
 *  Token验证
 */
- (NSString *)token {
    NSDictionary *userDic = [self getUserDefaultInfo];
    NSString *token = [userDic objectForKey:@"token"];
    return token;
}
/**
 *  清除账号
 */
- (void)clearAcc {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:@"userInfo"];
    [userDefault synchronize];
}
/**
 *  获取APP版本号
 */
- (NSString *)getAppVersion {
    //获取当前版本号
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    return appVersion;
}
/**
 *  获取APP名称
 */
- (NSString *)getAppName {
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = [infoDic objectForKey:@"CFBundleDisplayName"];
    return appName;
}

/**
 *  获取IDFA
 */
- (NSString *)getIDFA {
    //广告表示ID
    NSString *idfaStr = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
    idfaStr = [idfaStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return idfaStr;
}

/**
 *  支付支付穿处理
 */
- (NSDictionary *)dictionaryFromURLParameters:(NSString *)str {
    NSArray *pairs = [str componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val = [[kv objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        val = [val stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        [params setObject:val forKey:[kv objectAtIndex:0]];
    }
    return params;
}

/**
 *  获取BTC总数
 */
- (NSString *)btcNum {
    NSDictionary *dataDic = [self getTotalNum];
    NSString *btc_total_num = [dataDic objectForKey:@"btc_total_num"];
    return IsStringEmpty(btc_total_num) ? @"0" : btc_total_num;
}

/**
 *  获取ETH总数
 */
- (NSString *)ethNum {
    NSDictionary *dataDic = [self getTotalNum];
    NSString *eth_total_num = [dataDic objectForKey:@"eth_total_num"];
    return IsStringEmpty(eth_total_num) ? @"0" : eth_total_num;
}

/**
 *  获取BCH总数
 */
- (NSString *)bchNum {
    NSDictionary *dataDic = [self getTotalNum];
    NSString *bch_total_num = [dataDic objectForKey:@"bch_total_num"];
    return IsStringEmpty(bch_total_num) ? @"0" : bch_total_num;
}

/**
 *  获取各币种的数量
 */
- (NSDictionary *)getTotalNum {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"getMyInfo" forKey:@"act"];
    NSDictionary *json = [HttpRequestEx getSyncWidthURL:SERVICE_URL param:param];
    NSString *code = [json objectForKey:@"code"];
    if([code isEqualToString:SUCCESS]) {
        NSDictionary *dataDic = [json objectForKey:@"data"];
        return dataDic;
    }
    return nil;
}

@end
