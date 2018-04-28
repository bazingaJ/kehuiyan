//
//  KHYChatCell.h
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/23.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHYChatInfoModel.h"

@interface KHYChatCell : UITableViewCell

@property (nonatomic,strong) KHYChatInfoModel *model;

+ (instancetype)cellWithTableView:(UITableView*)tableView cellIdentifier:(NSString *)identifier;

-(CGFloat)getH1;

@end
