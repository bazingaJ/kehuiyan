//
//  KHYAnswerDetailVC.h
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/17.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "BaseViewController.h"
#import "KHYComboModel.h"

@interface KHYAnswerDetailVC : BaseViewController

// 接收到模型 
@property (nonatomic, strong) KHYComboModel *model;

// 问题ID
@property (nonatomic, strong) NSString *question_id;

@end
