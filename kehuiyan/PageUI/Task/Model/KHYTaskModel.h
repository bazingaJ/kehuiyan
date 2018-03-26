//
//  KHYTaskModel.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/10.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  任务-模型
 */
@interface KHYTaskModel : NSObject

/**
 *  任务ID
 */
@property (nonatomic, strong) NSString *task_id;
/**
 *  任务类型
 */
@property (nonatomic, strong) NSString *task_type;
/**
 *  任务类型名称(自定义)
 */
@property (nonatomic, strong) NSString *task_type_text;
/**
 *  任务周期
 */
@property (nonatomic, strong) NSString *task_cycle;
/**
 *  任务周期名称(自定义)
 */
@property (nonatomic, strong) NSString *task_cycle_text;
/**
 *  任务时间
 */
@property (nonatomic, strong) NSString *task_time;
/**
 *  任务开始时间
 */
@property (nonatomic, strong) NSString *start_date;
/**
 *  任务结束时间
 */
@property (nonatomic, strong) NSString *end_date;
/**
 *  参与人ID
 */
@property (nonatomic, strong) NSString *user_id;
/**
 *  参与人名称
 */
@property (nonatomic, strong) NSString *user_name;
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
 *  县区名称(自定义)
 */
@property (nonatomic, strong) NSString *city_name;
/**
 *  任务责任人ID
 */
@property (nonatomic, strong) NSString *leader;
/**
 *  任务责任人名称
 */
@property (nonatomic, strong) NSString *leader_name;
/**
 *  任务参与人ID
 */
@property (nonatomic, strong) NSString *takeIner;
/**
 *  任务参与人名称(自定义)
 */
@property (nonatomic, strong) NSString *takeIner_name;
/**
 *  医院
 */
@property (nonatomic, strong) NSString *hospital_id;
/**
 *  医院名称(自定义)
 */
@property (nonatomic, strong) NSString *hospital_name;
/**
 *  医院级别id
 */
@property (nonatomic, strong) NSString *hospitalLevel_id;
/**
 *  医院级别名称
 */
@property (nonatomic, strong) NSString *hospitalLevel_name;
/**
 *  学科
 */
@property (nonatomic, strong) NSString *keshi_id;
/**
 *  学科名称(自定义)
 */
@property (nonatomic, strong) NSString *keshi_name;
/**
 *  学科
 */
@property (nonatomic, strong) NSString *subject_id;
/**
 *  学科名称(自定义)
 */
@property (nonatomic, strong) NSString *subject_name;
/**
 *  医生
 */
@property (nonatomic, strong) NSString *doctor_id;
/**
 *  医生名称(自定义)
 */
@property (nonatomic, strong) NSString *doctor_name;
/**
 *  任务数
 */
@property (nonatomic, strong) NSString *task_num;
/**
 *  任务事项
 */
@property (nonatomic, strong) NSString *task_matter;
/**
 *  任务目标
 */
@property (nonatomic, strong) NSString *task_target;
/**
 *  任务计划
 */
@property (nonatomic, strong) NSString *task_plain;
/**
 *  任务小结
 */
@property (nonatomic, strong) NSString *task_summary;
/**
 *  任务完成时间
 */
@property (nonatomic, strong) NSString *finished_date;
/**
 *  任务目标
 */
@property (nonatomic, assign) CGFloat cellH;
/**
 *  行动计划
 */
@property (nonatomic, assign) CGFloat cellH2;
/**
 *  任务小结cellHeight
 */
@property (nonatomic, assign) CGFloat cellH3;
/**
 *  任务状态id
 */
@property (nonatomic, assign) NSInteger status;
/**
 *  任务状态
 */
@property (nonatomic, strong) NSString *status_text;

@end
