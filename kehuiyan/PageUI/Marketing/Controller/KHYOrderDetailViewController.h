//
//  KHYOrderUnpayViewController.h
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/12.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "BaseTableViewController.h"

@interface KHYOrderDetailViewController : BaseTableViewController

/**
 订单类型 1. 待支付 2.待发货 3.已取消
 */
@property (nonatomic, strong) NSString *orderType;

@end
