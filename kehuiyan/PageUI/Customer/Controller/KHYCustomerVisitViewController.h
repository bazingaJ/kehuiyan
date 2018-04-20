//
//  KHYCustomerVisitViewController.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/24.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHYCustomerModel.h"

@interface KHYCustomerVisitViewController : BaseTableViewController

/**
 *  客户对象
 */
@property (nonatomic, strong) KHYCustomerModel *customerModel;

// 1.是我自己要看的  2.我要看别人的
@property (nonatomic, strong) NSString *isMyself;

@end
