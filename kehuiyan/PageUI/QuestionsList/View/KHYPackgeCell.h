//
//  KHYPackgeCell.h
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/23.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHYChatInfoModel.h"

@interface KHYPackgeCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView*)tableView;

@property (nonatomic, strong) KHYChatInfoModel *model;

@end
