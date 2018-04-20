//
//  KHYOrderUnpayViewController.h
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/12.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "BaseTableViewController.h"
#import "KHYOrderModel.h"

@interface KHYOrderDetailViewController : BaseTableViewController

/**
 订单类型 (0全部 1待付款 2待发货 3已发货 4已完成 5已取消)
 */
@property (nonatomic, strong) NSString *orderType;

@property (nonatomic, strong) KHYOrderModel *model;

@end
