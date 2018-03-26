//
//  KHYHomeLeftView.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/8.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KHYHomeLeftView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

/**
 *  数据回调函数
 */
@property (nonatomic, copy) void(^didClickItem)(KHYHomeLeftView *view,NSInteger index);

@end
