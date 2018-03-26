//
//  KHYOrganizationModel.h
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/3/13.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KHYOrganizationModel : NSObject

@property (nonatomic, strong) NSString *add_time;
@property (nonatomic, strong) NSString *add_user;
@property (nonatomic, assign) NSInteger dep_id;
@property (nonatomic, strong) NSString *format_add_time;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, assign) NSInteger mark;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *organization;
@property (nonatomic, assign) NSInteger organization_id;
@property (nonatomic, assign) NSInteger parent_id;
@property (nonatomic, strong) NSString *sort_order;
@property (nonatomic, strong) NSString *upd_time;
@property (nonatomic, strong) NSString *upd_user;

@end
