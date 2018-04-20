//
//  KHYTaskViewController.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/10.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KHYTaskViewController : BaseTableViewController

@property (nonatomic, strong) NSString *memberID;

// 是否是自己点进来 1.先来看自己信息 2.我是领导看别人信息
@property (nonatomic, strong) NSString *isMine;

@end
