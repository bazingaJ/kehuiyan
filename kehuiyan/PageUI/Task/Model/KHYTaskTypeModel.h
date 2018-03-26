//
//  KHYTaskTypeModel.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/3/5.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  任务类型-模型
 */
@interface KHYTaskTypeModel : NSObject

/**
 *  任务类型ID
 */
@property (nonatomic, strong) NSString *type_id;
/**
 *  任务类型名称
 */
@property (nonatomic, strong) NSString *type_name;

@end
