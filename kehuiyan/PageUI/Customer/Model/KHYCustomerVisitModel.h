//
//  KHYCustomerVisitModel.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/24.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  客户拜访记录-模型
 */
@interface KHYCustomerVisitModel : NSObject

/**
 *  拜访记录ID
 */
@property (nonatomic, strong) NSString *visit_id;
/**
 *  用户ID
 */
@property (nonatomic, strong) NSString *user_id;
/**
 *  用户名称
 */
@property (nonatomic, strong) NSString *user_name;
/**
 *  省市区
 */
@property (nonatomic, strong) NSString *city_name;
/**
 *  详细地址
 */
@property (nonatomic, strong) NSString *address;
/**
 *  医院名称
 */
@property (nonatomic, strong) NSString *hospital_name;
/**
 *  科室名称
 */
@property (nonatomic, strong) NSString *keshi_name;
/**
 *  医生ID(自定义)
 */
@property (nonatomic, strong) NSString *doctor_id;
/**
 *  医生名称
 */
@property (nonatomic, strong) NSString *doctor_name;
/**
 *  拜访时间
 */
@property (nonatomic, strong) NSString *visit_date;
/**
 *  拜访内容
 */
@property (nonatomic, strong) NSString *note;

@end
