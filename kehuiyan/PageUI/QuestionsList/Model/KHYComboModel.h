//
//  KHYComboModel.h
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/17.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KHYComboModel : NSObject

/**
 套餐编码
 */
@property (nonatomic, strong) NSString *package_num;

/**
 总价格
 */
@property (nonatomic, strong) NSString *total_price;

/**
 总数量
 */
@property (nonatomic, strong) NSString *total_num;

/**
 可用积分数
 */
@property (nonatomic, strong) NSString *score_num;

/**
 运费
 */
@property (nonatomic, strong) NSString *yun_fee;

/**
 是否免运费 1是 2否
 */
@property (nonatomic, strong) NSString *is_baoyou;

/**
 封面
 */
@property (nonatomic, strong) NSString *cover_url;

/**
 套餐名
 */
@property (nonatomic, strong) NSString *name;

/**
 产品列表
 */
@property (nonatomic, strong) NSArray *product_list;

/**
 描述
 */
@property (nonatomic, strong) NSString *note;

@end
