//
//  KHYQuestionListModel.h
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/10.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KHYQuestionListModel : NSObject

// 类型 1.待回答 2.已回答 3.已采纳
@property (nonatomic , copy) NSString              * status;
//问题图集
@property (nonatomic , copy) NSArray              * img_list;
//患者性别
@property (nonatomic , copy) NSString              * sex;
//患者年龄
@property (nonatomic , copy) NSString              * age;
//患者名称
@property (nonatomic , copy) NSString              * realname;
//患者头像
@property (nonatomic , copy) NSString              * avatar_url;
//手机号
@property (nonatomic , copy) NSString              * mobile;
//是否支付积分
@property (nonatomic , copy) NSString              * is_pay;
//回答时间
@property (nonatomic , copy) NSString              * reply_date;
//问题内容
@property (nonatomic , copy) NSString              * ask_content;
//问题id
@property (nonatomic , copy) NSString              * question_id;
//提问时间
@property (nonatomic , copy) NSString              * ask_date;
//回答内容
@property (nonatomic , copy) NSString              * reply_content;
// 药品信息
@property (nonatomic, strong) NSDictionary         * package_info;

@end
