//
//  KHYHospitalSelectedViewController.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/23.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KHYHospitalSelectedViewController : BaseTableViewController

/**
 *  城市ID
 */
@property (nonatomic, strong) NSString *city_id;
/**
 *  地区ID
 */
@property (nonatomic, strong) NSString *area_id;
/**
 *  医院级别
 */
@property (nonatomic, strong) NSString *hospitalLevel_id;
/**
 *  回调函数
 */
@property (nonatomic, copy) void(^callBack)(NSString *hospital_id, NSString *hospital_name);

@end
