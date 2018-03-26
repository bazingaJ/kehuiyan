//
//  KHYCustomerEditViewController.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/23.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHYCustomerModel.h"

@interface KHYCustomerEditViewController : BaseTableViewController

/**
 *  客户对象
 */
@property (nonatomic, strong) KHYCustomerModel *customerModel;
/**
 *  回调函数
 */
@property (nonatomic, copy) void(^callBack)(KHYCustomerModel *customerModel);

@end
