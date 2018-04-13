//
//  KHYPatientModel.h
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/11.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KHYPatientModel : NSObject

/**
 患者描述
 */
@property (nonatomic, strong) NSString *descriptionString;

/**
 性别 1.男 2.女
 */
@property (nonatomic, strong) NSString *gender;

/**
 年龄
 */
@property (nonatomic, strong) NSString *age;

/**
 提问时间
 */
@property (nonatomic, strong) NSString *askDate;

/**
 病情分析
 */
@property (nonatomic, strong) NSString *answerString;

/**
 回复时间
 */
@property (nonatomic, strong) NSString *answerTime;
@end
