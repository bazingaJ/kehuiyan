//
//  KHYTaskDropDownMenu.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/3/2.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KHYTaskDropDownMenu : UIView

/**
 *  初始化
 */
- (id)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr;

/**
 *  选择任务类型
 */
@property (nonatomic, copy) void(^callTypeBack)(NSString *type_id,NSString *type_name);
/**
 *  选择任务周期
 */
@property (nonatomic, copy) void(^callCycleBack)(NSString *cycle_id,NSString *cycle_name);
/**
 *  选择任务状态
 */
@property (nonatomic, copy) void(^callStatusBack)(NSString *status_id,NSString *status_name);

/**
 *  隐藏
 */
- (void)dismiss;

@end
