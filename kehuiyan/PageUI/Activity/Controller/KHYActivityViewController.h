//
//  KHYActivityViewController.h
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/10.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "WMPageController.h"

@interface KHYActivityViewController : WMPageController

@property (nonatomic, strong) NSString *member_id;

/**
 是否允许显示发布活动按钮
 */
@property (nonatomic, strong) NSString *isShowBtn;

@end
