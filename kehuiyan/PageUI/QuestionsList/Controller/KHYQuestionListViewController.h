//
//  KHYQuestionListViewController.h
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/10.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "BaseTableViewController.h"

@interface KHYQuestionListViewController : BaseTableViewController


/**
 角色类别 1.专家(营养专家) 2.顾问(营养顾问)
 */
@property (nonatomic, assign) NSInteger characterType;

@property (nonatomic, strong) NSString *memberID;

@end
