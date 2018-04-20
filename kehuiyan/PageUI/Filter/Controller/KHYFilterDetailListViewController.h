//
//  KHYFilterDetailListViewController.h
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/20.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "BaseTableViewController.h"
#import "KHYOrganizationModel.h"

@interface KHYFilterDetailListViewController : BaseTableViewController

@property (nonatomic, strong) KHYOrganizationModel *model;

// 1.咨询列表 2.专家提问  1和2统一传 “10”      3.患教活动 4.销售管理 5.患者管理 6.任务管理 7.客户管理
@property (nonatomic, strong) NSString *filterType;

@end
