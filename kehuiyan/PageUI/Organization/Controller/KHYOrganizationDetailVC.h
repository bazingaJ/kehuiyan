//
//  KHYOrganizationDetailVC.h
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/3/12.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "BaseViewController.h"

@interface KHYOrganizationDetailVC : BaseViewController

@property (nonatomic, strong) NSDictionary *dataDict;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *realNameLab;
@property (weak, nonatomic) IBOutlet UILabel *jobLab;


@end
