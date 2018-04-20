//
//  URLManager.m
//  ethereum
//
//  Created by 相约在冬季 on 2017/12/12.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "URLManager.h"

@implementation URLManager

/**
 *  创建单例模式
 */
+ (instancetype)manager {
    //单例
    static URLManager *_manager = nil;
    static dispatch_once_t dispatch;
    dispatch_once(&dispatch, ^{
        _manager = [[URLManager alloc] init];
    });
    return _manager;
}

@end
