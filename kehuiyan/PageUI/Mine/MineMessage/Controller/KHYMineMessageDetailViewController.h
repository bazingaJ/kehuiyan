//
//  KHYMineMessageDetailViewController.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/24.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHYMessageModel.h"

@interface KHYMineMessageDetailViewController : BaseViewController<UIWebViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, assign) CGFloat webHeight;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) KHYMessageModel *messageInfo;
@property (nonatomic, copy) void(^callBack)();

@end
