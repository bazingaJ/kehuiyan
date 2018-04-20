//
//  KHYOrganizationMamberVC.h
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/3/13.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "BaseViewController.h"

@interface KHYOrganizationMamberVC : BaseViewController
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSString *dep_id;
@property (nonatomic, strong) NSString *titleName;
@property (nonatomic, assign) BOOL isTask;
@end
