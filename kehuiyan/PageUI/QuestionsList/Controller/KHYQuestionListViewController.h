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
 角色类别 1.专家(营养专家) 2.营养师(营养师)
 */
@property (nonatomic, assign) NSInteger characterType;

@property (nonatomic, strong) NSString *memberID;

/**
 1. 是从患者管理信息过来 2.是从首页咨询列表过来
 */
@property (nonatomic, strong) NSString *isFromInfo;

@end
