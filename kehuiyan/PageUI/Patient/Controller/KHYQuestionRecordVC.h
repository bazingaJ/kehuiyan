//
//  KHYQuestionRecordVC.h
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/17.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "BaseTableViewController.h"
#import "KHYExpertQuestionModel.h"

@interface KHYQuestionRecordVC : BaseTableViewController

@property (nonatomic, strong) KHYExpertQuestionModel *model;

@property (nonatomic, strong) NSString *cate_id;

@property (nonatomic, strong) NSString *patient_id;

@end
