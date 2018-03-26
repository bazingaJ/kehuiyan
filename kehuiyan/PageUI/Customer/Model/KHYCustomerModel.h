//
//  KHYCustomerModel.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/23.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  客户-模型
 */
@interface KHYCustomerModel : NSObject

/**
 *  客户ID
 */
@property (nonatomic, strong) NSString *doctor_id;
/**
 *  客户姓名
 */
@property (nonatomic, strong) NSString *realname;
/**
 *  性别：1男 2女 3未知
 */
@property (nonatomic, strong) NSString *gender;
/**
 *  性别名称
 */
@property (nonatomic, strong) NSString *gender_name;
/**
 *  头像
 */
@property (nonatomic, strong) NSString *avatar_src;
/**
 *  头像(新增)
 */
@property (nonatomic, strong) NSString *avatar;
/**
 *  出生年月
 */
@property (nonatomic, strong) NSString *birthday;
/**
 *  医院级别ID
 */
@property (nonatomic, strong) NSString *hospitalLevel_id;
/**
 *  医院级别
 */
@property (nonatomic, strong) NSString *hospitalLevel_name;
/**
 *  医院ID
 */
@property (nonatomic, strong) NSString *hospital_id;
/**
 *  医院名称
 */
@property (nonatomic, strong) NSString *hospital_name;
/**
 *  一级学科ID
 */
@property (nonatomic, strong) NSString *subject_id;
/**
 *  一级学科名称
 */
@property (nonatomic, strong) NSString *subject_name;
///**
// *  一级科室ID
// */
//@property (nonatomic, strong) NSString *first_keshi_id;
///**
// *  一级科室名称
// */
//@property (nonatomic, strong) NSString *first_keshi_name;
/**
 *  二级科室ID
 */
@property (nonatomic, strong) NSString *keshi_id;
/**
 *  二级科室名称
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
 *  拜访时间
 */
@property (nonatomic, strong) NSString *visit_time;
/**
 *  拜访内容
 */
@property (nonatomic, strong) NSString *visit_note;
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
 *  地区名称
 */
@property (nonatomic, strong) NSString *city_name;
/**
 *  治疗组
 */
@property (nonatomic, strong) NSString *treat_group;
/**
 *  手机号
 */
@property (nonatomic, strong) NSString *mobile;
/**
 *  电子邮箱
 */
@property (nonatomic, strong) NSString *email;
/**
 *  微信号
 */
@property (nonatomic, strong) NSString *weixin;
/**
 *  QQ号
 */
@property (nonatomic, strong) NSString *qq;
/**
 *  医生简介
 */
@property (nonatomic, strong) NSString *intro;
/**
 *  备注信息
 */
@property (nonatomic, strong) NSString *note;
/**
 *  简介高度
 */
@property (nonatomic, assign) CGFloat cellH;
/**
 *  备注高度
 */
@property (nonatomic, assign) CGFloat cellH2;

@end
