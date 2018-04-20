//
//  KHYOrderModel.h
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/16.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KHYOrderModel : NSObject

/**
 订单号
 */
@property (nonatomic, strong) NSString *order_num;

/**
 接收人姓名
 */
@property (nonatomic, strong) NSString *receiver_name;

/**
 接收人号码
 */
@property (nonatomic, strong) NSString *receiver_mobile;

/**
 接收人省市区
 */
@property (nonatomic, strong) NSString *receiver_city_name;

/**
 接收人详细地址
 */
@property (nonatomic, strong) NSString *receiver_address;

/**
 套餐名
 */
@property (nonatomic, strong) NSString *package_name;

/**
 封面
 */
@property (nonatomic, strong) NSString *package_cover;
/**
 套餐说明
 */
@property (nonatomic, strong) NSString *package_note;

/**
 接收人省市区
 */
@property (nonatomic, strong) NSArray *product_list;

/**
 总价
 */
@property (nonatomic, strong) NSString *total_price;

/**
 总数
 */
@property (nonatomic, strong) NSString *total_num;

/**
 是否包邮 1.是 2.否
 */
@property (nonatomic, strong) NSString *is_baoyou;

/**
 运费
 */
@property (nonatomic, strong) NSString *yun_fee;

/**
 积分数
 */
@property (nonatomic, strong) NSString *score_num;

/**
 实际支付价格
 */
@property (nonatomic, strong) NSString *actual_price;

/**
 状态 (0全部 1待付款 2待发货 3已发货 4已完成 5已取消)
 */
@property (nonatomic, strong) NSString *status;

/**
 状态名
 */
@property (nonatomic, strong) NSString *status_name;

/**
 添加时间
 */
@property (nonatomic, strong) NSString *add_date;

/**
 支付时间
 */
@property (nonatomic, strong) NSString *pay_date;

/**
 顾问名
 */
@property (nonatomic, strong) NSString *member_name;

/**
 货运名称
 */
@property (nonatomic , copy) NSString *deliver_type_name;

/**
 患者名字
 */
@property (nonatomic , copy) NSString *patient_name;

/**
 发货时间
 */
@property (nonatomic , copy) NSString *delivery_date;

/**
 发货号
 */
@property (nonatomic , copy) NSString *deliver_no;


@end
