//
//  URLManager.h
//  ethereum
//
//  Created by 相约在冬季 on 2017/12/12.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLManager : NSObject

/**
 *  创建单例模式
 */
+ (instancetype)manager;
/**
 *  开机图
 */
@property (nonatomic, strong) NSString *open_img;
/**
 *  关于我们
 */
@property (nonatomic, strong) NSString *about;
/**
 *  帮助
 */
@property (nonatomic, strong) NSString *help;
/**
 *  审核版本
 */
@property (nonatomic, strong) NSString *audit_version;


@end
