//
//  KHYChatViewController.h
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/13.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "BaseViewController.h"
#import "KHYChatModel.h"

extern const CGFloat ChatViewInputViewHeight;

@class ODRefreshControl,NSFetchedResultsController;

@interface KHYChatViewController : BaseViewController

@property (nonatomic, strong) NSString *memberID;

@property(nonatomic, strong) UITableView  *tableView;

@property (nonatomic, strong) KHYChatModel *model;

/**
 是否是从患者管理 咨询详情过来的   1. 是从患者管理过来的  2.不是从患者管理过来的 从首页过来的
 */
@property (nonatomic, strong) NSString *isFromInfo;

@end
