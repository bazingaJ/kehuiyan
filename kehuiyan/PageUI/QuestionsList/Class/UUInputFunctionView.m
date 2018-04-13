//
//  UUInputFunctionView.m
//  UUChatDemoForTextVoicePicture
//
//  Created by shake on 14-8-27.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import "UUInputFunctionView.h"
#import "UUProgressHUD.h"
#import <AVFoundation/AVFoundation.h>
#import "UUChatCategory.h"
#import "KHYChatViewController.h"
#import "KHYComboViewController.h"

@interface UUInputFunctionView () <UITextViewDelegate, AVAudioRecorderDelegate>
{
    BOOL isbeginVoiceRecord;
    NSInteger playTime;
	NSString *_docmentFilePath;
}

@property (nonatomic, strong) NSTimer *playTimer;
@property (nonatomic, strong) UILabel *placeHold;

@property (nonatomic, weak, readonly) UIViewController *superVC;

@end

@implementation UUInputFunctionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
	
    if (self) {
		self.backgroundColor = [UIColor whiteColor];
		self.isAbleToSendTextMessage = NO;
        
        //发送消息
        self.btnSendMessage = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.btnSendMessage setTitle:@"" forState:UIControlStateNormal];
        [self.btnSendMessage setImage:[UIImage imageNamed:@"addImage"] forState:UIControlStateNormal];
        self.btnSendMessage.titleLabel.font = FONT14;
        [self.btnSendMessage addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btnSendMessage];
        
        //输入框
		self.inputView = [[UITextView alloc] init];
        self.inputView.font = FONT17;
        self.inputView.delegate = self;
        self.inputView.layer.cornerRadius = 4;
        self.inputView.layer.masksToBounds = YES;
        self.inputView.layer.borderWidth = 1;
        self.inputView.layer.borderColor = [[[UIColor lightGrayColor] colorWithAlphaComponent:0.4] CGColor];
        [self addSubview:self.inputView];
        
        //分割线
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
        
        //添加通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewDidEndEditing:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	self.btnSendMessage.frame = CGRectMake(self.uu_width-40, 10, 30, ChatViewInputViewHeight - 20);
	self.inputView.frame = CGRectMake(5, 5, self.uu_width - 5 - 60, ChatViewInputViewHeight - 10);
    
}

- (UIViewController *)superVC
{
	return [self uu_findNextResonderInClass:[UIViewController class]];
}

//发送消息（文字图片）
- (void)sendMessage:(UIButton *)sender
{
    if (self.isAbleToSendTextMessage) {
        NSString *resultStr = [self.inputView.text stringByReplacingOccurrencesOfString:@"   " withString:@""];
        [self.delegate UUInputFunctionView:self sendMessage:resultStr];
    }
    else{
        [self.inputView resignFirstResponder];
        UIViewController *vc = [JXAppTool currentViewController];
        KHYComboViewController *comboVC = [KHYComboViewController new];
        [vc.navigationController pushViewController:comboVC animated:YES];
    }
}

#pragma mark - TextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    [self changeSendBtnWithPhoto:textView.text.length > 0 ? NO : YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    
}

- (void)changeSendBtnWithPhoto:(BOOL)isPhoto
{
    self.isAbleToSendTextMessage = !isPhoto;
    if (self.isAbleToSendTextMessage)
    {
        [self.btnSendMessage setTitle:@"发送" forState:UIControlStateNormal];
        [self.btnSendMessage setBackgroundColor:kRGB(89, 189, 237)];
        CGRect sendFrame = self.btnSendMessage.frame;
        sendFrame.size.width = 100;
        NSLog(@"---%@",NSStringFromCGRect(sendFrame));
        self.btnSendMessage.frame = sendFrame;
        [self.btnSendMessage setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    else
    {
        [self.btnSendMessage setTitle:@"" forState:UIControlStateNormal];
        [self.btnSendMessage setBackgroundColor:[UIColor clearColor]];
        CGRect sendFrame = self.btnSendMessage.frame;
        sendFrame.size.width = 30;
        NSLog(@"===%@",NSStringFromCGRect(sendFrame));
        self.btnSendMessage.frame = sendFrame;
        [self.btnSendMessage setImage:[UIImage imageNamed:@"addImage"] forState:UIControlStateNormal];
    }
    
	
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}



@end
