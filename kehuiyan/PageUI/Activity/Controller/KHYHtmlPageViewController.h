//
//  KHYHtmlPageViewController.h
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/10.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "BaseViewController.h"
#import <WebKit/WebKit.h>

@interface KHYHtmlPageViewController : BaseViewController<  WKNavigationDelegate,
                                                            WKUIDelegate,
                                                            UIScrollViewDelegate,
                                                            NSURLSessionDelegate,
                                                            NSURLConnectionDelegate>
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIView *lineView;
@end
