//
//  AppDelegate+Data.m
//  Kivii
//
//  Created by 相约在冬季 on 2017/9/26.
//  Copyright © 2017年 Kivii. All rights reserved.
//

#import "AppDelegate+Data.h"

@implementation AppDelegate (Data)

/**
 *  获取系统信息
 */
- (URLManager *)getSystemInfo {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"default" forKey:@"app"];
    [param setValue:@"getAboutInfo" forKey:@"act"];
    NSDictionary *jsonDic = [HttpRequestEx getSyncWidthURL:SERVICE_URL param:param];
    NSString *code = [jsonDic objectForKey:@"code"];
    if([code isEqualToString:SUCCESS]) {
        NSDictionary *dataDic = [jsonDic objectForKey:@"data"];
        URLManager *entity = [URLManager manager];
        entity.open_img = [dataDic objectForKey:@"open_img"];
        entity.about = [dataDic objectForKey:@"about"];
        entity.help = [dataDic objectForKey:@"help"];
        entity.audit_version = [dataDic objectForKey:@"audit_version"];
        
        return entity;
    }
    return [URLManager manager];
}

@end
