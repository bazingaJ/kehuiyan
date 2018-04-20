//
//  KHYKeshiModel.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/23.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  科室-模型
 */
@interface KHYKeshiModel : NSObject

/**
 *  科室ID
 */
@property (nonatomic, strong) NSString *keshi_id;
/**
 *  科室名称
 */
@property (nonatomic, strong) NSString *name;
/**
 *  医院名称
 */
@property (nonatomic, strong) NSString *hospital_name;
/**
 *  二级科室列表
 */
@property (nonatomic, strong) NSMutableArray *child_list;



@end
