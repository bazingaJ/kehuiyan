//
//  KHYTaskSubmitViewController.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/3/9.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHYTaskModel.h"

@interface KHYTaskSubmitViewController : BaseTableViewController

/**
 *  任务对象
 */
@property (nonatomic, strong) KHYTaskModel *taskModel;
/**
 *  回调
 */
@property (nonatomic, copy) void(^callBack)();

@end
