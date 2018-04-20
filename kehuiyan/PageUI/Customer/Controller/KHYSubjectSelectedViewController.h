//
//  KHYSubjectSelectedViewController.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/3/6.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KHYSubjectSelectedViewController : BaseTableViewController

/**
 *  医院ID
 */
@property (nonatomic, strong) NSString *hospital_id;

/**
 *  回调函数
 */
@property (nonatomic, copy) void(^callBack)(NSString *keshi_id, NSString *keshi_name,NSArray *keshiArr);

@end