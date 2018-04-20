//
//  KHYActivityModel.h
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/16.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KHYActivityModel : NSObject

/**
 活动id
 */
@property (nonatomic, strong) NSString *activity_id;

/**
 标题
 */
@property (nonatomic, strong) NSString *title;

/**
 主办机构
 */
@property (nonatomic, strong) NSString *zhuzhi_mech;

/**
 可用积分数
 */
@property (nonatomic, strong) NSString *score_num;

/**
 承办机构
 */
@property (nonatomic, strong) NSString *chengban_mech;

/**
 省市区
 */
@property (nonatomic, strong) NSString *city_name;

/**
 具体地址
 */
@property (nonatomic, strong) NSString *address;

/**
 已报名数
 */
@property (nonatomic, strong) NSString *sign_num;

/**
 总人数
 */
@property (nonatomic, strong) NSString *limit_num;

/**
 添加时间
 */
@property (nonatomic, strong) NSString *add_date;

/**
 封面图
 */
@property (nonatomic, strong) NSString *cover_url;
// 详情url
@property (nonatomic , copy) NSString              * url;

@end
