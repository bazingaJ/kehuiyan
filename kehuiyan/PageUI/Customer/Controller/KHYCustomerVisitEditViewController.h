//
//  KHYCustomerVisitEditViewController.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/24.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHYCustomerVisitModel.h"

@interface KHYCustomerVisitEditViewController : BaseTableViewController

/**
 *  拜访记录对象
 */
@property (nonatomic, strong) KHYCustomerVisitModel *visitModel;
/**
 *  是否编辑
 */
@property (nonatomic, assign) BOOL isEdit;
/**
 *  客户ID
 */
@property (nonatomic, strong) NSString *doctor_id;
/**
 *  客户名称
 */
@property (nonatomic, strong) NSString *doctor_name;
/**
 *  回调函数
 */
@property (nonatomic, copy) void(^callBack)(KHYCustomerVisitModel *model);

@end
