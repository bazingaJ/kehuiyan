//
//  KHYTaskDetailViewController.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/3/8.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KHYTaskDetailViewController : BaseTableViewController

/**
 *  任务ID
 */
@property (nonatomic, strong) NSString *task_id;

// 1.是我看我自己 2.是我看别人
@property (nonatomic, strong) NSString *isMe;

@end
