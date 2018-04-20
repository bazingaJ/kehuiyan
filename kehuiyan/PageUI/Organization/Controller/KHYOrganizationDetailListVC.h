//
//  KHYOrganizationDetailListVC.h
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/3/13.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "BaseViewController.h"
#import "KHYOrganizationModel.h"

@interface KHYOrganizationDetailListVC : BaseViewController
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) KHYOrganizationModel *model;
@property (nonatomic, assign) BOOL isTask;
@end
