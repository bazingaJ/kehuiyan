//
//  KHYAnnounceModel.h
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/16.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KHYAnnounceModel : NSObject
// 分类
@property (nonatomic, strong) NSString *cate_name;
// 分类id
@property (nonatomic, strong) NSString *cate_id;
// 活动名称
@property (nonatomic, strong) NSString *title;
// 主办机构
@property (nonatomic, strong) NSString *zhuzhi_mech;
// 承办单位
@property (nonatomic, strong) NSString *chengban_mech;
// 活动开始时间
@property (nonatomic, strong) NSString *start_time;
// 活动结束时间
@property (nonatomic, strong) NSString *end_time;
// 报名开始时间
@property (nonatomic, strong) NSString *sign_start_time;
// 报名结束时间
@property (nonatomic, strong) NSString *sign_end_time;
// 报名人数
@property (nonatomic, strong) NSString *limit_num;
// 活动地址省 - 选的
@property (nonatomic, strong) NSString *province_id;
// 活动地址市 - 选的
@property (nonatomic, strong) NSString *city_id;
// 活动地址区 - 选的
@property (nonatomic, strong) NSString *district_id;
// 活动详细地址
@property (nonatomic, strong) NSString *address;
// 活动简介
@property (nonatomic, strong) NSString *intro;
// 活动封面
@property (nonatomic, strong) NSString *cover;


// 活动地址 - 选
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) UIImage *img;

@end
