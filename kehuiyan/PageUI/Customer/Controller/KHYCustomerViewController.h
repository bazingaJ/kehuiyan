//
//  KHYCustomerViewController.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/23.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KHYCustomerViewController : BaseTableViewController

@property (nonatomic, strong) NSString *memberID;

// 1.是我自己看看  2.我看别人的客户
@property (nonatomic, strong) NSString *isMine;

@end
