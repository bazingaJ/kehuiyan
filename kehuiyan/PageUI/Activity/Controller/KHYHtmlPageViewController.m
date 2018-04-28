//
//  KHYHtmlPageViewController.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/10.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYHtmlPageViewController.h"

@interface KHYHtmlPageViewController ()

@end

@implementation KHYHtmlPageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT)];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    _webView.scrollView.delegate = self;
    _webView.backgroundColor = BACK_COLOR;
    [self.view addSubview:_webView];
    
    [self openWKURL:[NSURL URLWithString:_url]];
    
}

- (void)openWKURL:(NSURL *)url {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20];
    [_webView loadRequest:request];
    
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    _webView.hidden = NO;
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 3)];
    _lineView.backgroundColor = MAIN_COLOR;
    [self.view addSubview:_lineView];
    [UIView animateWithDuration:0.8 animations:^{
        CGRect frame = _lineView.frame;
        frame.size.width = [UIScreen mainScreen].bounds.size.width * 0.7;
        _lineView.frame = frame;
    }];
    
}

/// 5 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    webView.userInteractionEnabled = YES;
    
    [NSThread sleepForTimeInterval:0.5];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = _lineView.frame;
        frame.size.width = [UIScreen mainScreen].bounds.size.width;
        _lineView.frame = frame;
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_lineView removeFromSuperview];
    });
    
}

/// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(nonnull NSError *)error
{
    if (error.code == 101 || error.code == 102 || error.code == -999) return;
    
    _webView.hidden = YES;
    
    self.title = @"出错了";
    
    webView.userInteractionEnabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
