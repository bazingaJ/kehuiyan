//
//  KHYDoctorModel.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/3/5.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  医生-模型
 */
@interface KHYDoctorModel : NSObject

/**
 *  医生ID
 */
@property (nonatomic, strong) NSString *doctor_id;
/**
 *  医生姓名
 */
@property (nonatomic, strong) NSString *realname;
/**
 *  医生头像
 */
@property (nonatomic, strong) NSString *avatar_src;
/**
 *  治疗组
 */
@property (nonatomic, strong) NSString *treat_group;
/**
 *  类型 (医生级别:1专家 2专科)
 */
@property (nonatomic, strong) NSString *type;
/**
 *  类型名称
 */
@property (nonatomic, strong) NSString *type_name;
/**
 *  医院ID
 */
@property (nonatomic, strong) NSString *hospital_id;
/**
 *  医院名称
 */
@property (nonatomic, strong) NSString *hospital_name;
/**
 *  科室ID
 */
@property (nonatomic, strong) NSString *keshi_id;
/**
 *  科室名称
 */
@property (nonatomic, strong) NSString *keshi_name;
/**
 *  职称ID
 */
@property (nonatomic, strong) NSString *position_id;
/**
 *  职称名称
 */
@property (nonatomic, strong) NSString *position_name;
/**
 *  城市名称
 */
@property (nonatomic, strong) NSString *city_name;
/**
 *  省份ID
 */
@property (nonatomic, strong) NSString *province_id;
/**
 *  城市ID
 */
@property (nonatomic, strong) NSString *city_id;
/**
 *  县区ID
 */
@property (nonatomic, strong) NSString *area_id;
/**
 *  性别:1男 2女 3未知
 */
@property (nonatomic, strong) NSString *gender;
/**
 *  出生年月
 */
@property (nonatomic, strong) NSString *birthday;
/**
 *  邮箱
 */
@property (nonatomic, strong) NSString *email;
/**
 *  微信
 */
@property (nonatomic, strong) NSString *weixin;
/**
 *  手机号
 */
@property (nonatomic, strong) NSString *mobile;
/**
 *  QQ号
 */
@property (nonatomic, strong) NSString *qq;
/**
 *  简介
 */
@property (nonatomic, strong) NSString *intro;
/**
 *  备注
 */
@property (nonatomic, strong) NSString *note;

@end
