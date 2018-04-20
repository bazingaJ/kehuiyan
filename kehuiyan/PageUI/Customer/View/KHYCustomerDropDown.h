//
//  KHYCustomerDropDown.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/3/14.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KHYCustomerDropDown : UIView

/**
 *  初始化
 */
- (id)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr;
/**
 *  隐藏
 */
- (void)dismiss;
/**
 *  选择地区类型
 */
@property (nonatomic, copy) void(^callAreaBack)(NSString *district_id,NSString *district_name);
/**
 *  选择医院
 */
@property (nonatomic, copy) void(^callHospitalBack)(NSString *hospital_id,NSString *hospital_name);
/**
 *  选择科室
 */
@property (nonatomic, copy) void(^callKeshiBack)(NSString *keshi_id,NSString *keshi_name);

- (void)getKeshiList;

@end
