//
//  KHYAskRecordViewController.h
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/11.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "BaseViewController.h"
#import "KHYQuestionListModel.h"

@interface KHYAskRecordViewController : BaseViewController

@property (nonatomic, strong) KHYQuestionListModel *model;

// 1.从患者管理页面条转过来 2.不是从患者管理过来的
@property (nonatomic, strong) NSString *isPatient;

@end
