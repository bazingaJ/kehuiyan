//
//  KHYPositionSelectedViewController.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/23.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KHYPositionSelectedViewController : BaseTableViewController

/**
 *  回调函数
 */
@property (nonatomic, copy) void(^callBack)(NSString *position_id, NSString *position_name);

@end
