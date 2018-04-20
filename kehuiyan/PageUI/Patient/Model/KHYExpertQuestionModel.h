//
//  KHYExpertQuestionModel.h
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/18.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KHYExpertQuestionModel : NSObject

@property (nonatomic , copy) NSString              * honor;
@property (nonatomic , copy) NSString              * cate_id;
@property (nonatomic , copy) NSString              * intro;
@property (nonatomic , copy) NSString              * zixun_num;
@property (nonatomic , copy) NSString              * question_id;
@property (nonatomic , copy) NSString              * expert_id;
@property (nonatomic , copy) NSString              * cate_name;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , strong) NSArray             * tag_list;
@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , copy) NSString              * total_score;
@property (nonatomic , copy) NSString              * score_num;
@end
