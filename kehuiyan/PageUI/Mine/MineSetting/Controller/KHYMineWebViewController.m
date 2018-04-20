//
//  KHYMineWebViewController.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/24.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYMineWebViewController.h"

@interface KHYMineWebViewController ()

@end

@implementation KHYMineWebViewController

//创建webView
- (UIWebView *)webView {
    if(_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT)];
        _webView.delegate = self;
        _webView.scrollView.delegate = self;
        //_webView.scrollView.scrollEnabled = NO;
        _webView.backgroundColor = BACK_COLOR;
        //[_webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#23262E'"];
        [self.view addSubview:_webView];
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self webView];
    
    [self showInWebView];
    
}

- (void)showInWebView {
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"kehuiyan.css" withExtension:nil]];
    [html appendString:@"</head>"];
    [html appendString:@"<body>"];
    [html appendString:[self touchBody]];
    [html appendString:@"</body>"];
    [html appendString:@"</html>"];
    [self.webView loadHTMLString:html baseURL:nil];
}

- (NSString *)touchBody {
    
    NSMutableString *body = [NSMutableString string];
    if(!IsStringEmpty(self.contentStr)) {
        [body appendString:self.contentStr];
    }
    
    /*for (IArtNewsImageModel *imgModel in _model.imageArr) {
     NSMutableString *imgHtml = [NSMutableString string];
     //设置img的div
     [imgHtml appendString:@"<div class=\"img-parent\">"];
     
     // 数组存放被切割的像素
     NSArray *pixel = [imgModel.pixel componentsSeparatedByString:@"*"];
     CGFloat width = [[pixel firstObject]floatValue];
     CGFloat height = [[pixel lastObject]floatValue];
     //判断是否超过最大宽度
     CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width * 0.95;
     if (width > maxWidth) {
     height = maxWidth / width * height;
     width = maxWidth;
     }
     
     NSString *onload = @"this.onclick = function() {"
     "  window.location.href = 'sx:src=' +this.src;"
     "};";
     [imgHtml appendFormat:@"<img onload=\"%@\" width=\"%f\" height=\"%f\" src=\"%@\">",onload,width,height,imgModel.src];
     //结束标记
     [imgHtml appendString:@"</div>"];
     // 替换标记
     [body replaceOccurrencesOfString:imgModel.ref withString:imgHtml options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];
     }*/
    return body;
}

//将发出通知时调用
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *url = request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"sx:src="];
    if (range.location != NSNotFound) {
        NSInteger begin = range.location + range.length;
        NSString *src = [url substringFromIndex:begin];
        [self savePictureToAlbum:src];
        return NO;
    }
    return YES;
}

//保存到相册方法
- (void)savePictureToAlbum:(NSString *)src {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要保存到相册吗？" preferredStyle: UIAlertControllerStyleActionSheet];
    //UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    //UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSURLCache *cache =[NSURLCache sharedURLCache];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:src]];
        NSData *imgData = [cache cachedResponseForRequest:request].data;
        UIImage *image = [UIImage imageWithData:imgData];
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 3)];
    _lineView.backgroundColor = MAIN_COLOR;
    [_webView addSubview:_lineView];
    [UIView animateWithDuration:0.8 animations:^{
        CGRect frame = _lineView.frame;
        frame.size.width = [UIScreen mainScreen].bounds.size.width * 0.7;
        _lineView.frame = frame;
    }];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
