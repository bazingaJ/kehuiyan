//
//  KHYDoctorSelectedViewController.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/3/5.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KHYDoctorSelectedViewController : BaseTableViewController

/**
 *  医院ID
 */
@property (nonatomic, strong) NSString *hospital_id;
/**
 *  科室ID
 */
@property (nonatomic, strong) NSString *keshi_id;
/**
 *  学科ID
 */
@property (nonatomic, strong) NSString *subject_id;
/**
 *  回调函数
 */
@property (nonatomic, copy) void(^callBack)(NSString *doctot_id, NSString *doctot_name);

@end
