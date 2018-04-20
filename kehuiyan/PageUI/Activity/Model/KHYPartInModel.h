//
//  KHYPartInModel.h
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/17.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KHYPartInModel : NSObject

/**
 用户id
 */
@property (nonatomic, strong) NSString *user_id;

/**
 用户姓名
 */
@property (nonatomic, strong) NSString *realname;

/**
 用户头像
 */
@property (nonatomic, strong) NSString *avatar;

/**
 是否签到 1.是 2.否
 */
@property (nonatomic, strong) NSString *is_sign;

/**
 是否签到 1.是 2.否
 */
@property (nonatomic, strong) NSString *is_sign_name;

@end
