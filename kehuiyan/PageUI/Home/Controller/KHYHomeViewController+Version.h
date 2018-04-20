//
//  KHYHomeViewController+Version.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/3/3.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYHomeViewController.h"
#import "KHYVersionPopupView.h"

@interface KHYHomeViewController (Version)<KHYVersionPopupViewDelegate>

/**
 *  版本检测
 */
@property (nonatomic, copy) KLCPopup *popup;
/**
 *  苹果应用下载地址
 */
@property (nonatomic, copy) NSString *trackViewUrl;

/**
 * 检测系统版本
 */
- (void)checkSystemVersion;

@end
