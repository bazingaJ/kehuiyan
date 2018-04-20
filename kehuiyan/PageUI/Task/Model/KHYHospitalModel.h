//
//  KHYHospitalModel.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/23.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  医院-模型
 */
@interface KHYHospitalModel : NSObject

/**
 *  医院ID
 */
@property (nonatomic, strong) NSString *hospital_id;
/**
 *  医院名称
 */
@property (nonatomic, strong) NSString *name;
/**
 *  医院等级ID
 */
@property (nonatomic, strong) NSString *level;
/**
 *  医院等级名称
 */
@property (nonatomic, strong) NSString *level_name;
/**
 *  医院类型名称
 */
@property (nonatomic, strong) NSString *type_name;
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
 *  城市名称
 */
@property (nonatomic, strong) NSString *city_name;

@end
