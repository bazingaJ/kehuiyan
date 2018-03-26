//
//  UIView+Empty.m
//  wulian_user
//
//  Created by 相约在冬季 on 2017/6/1.
//  Copyright © 2017年 wlqq. All rights reserved.
//

#import "UIView+Empty.h"
#import <objc/runtime.h>

static char WarningViewKey;

@implementation UIView (Empty)

/**
 *  利用runtime给类别添加属性
 */
- (void)setWarningView:(EmptyWarnView *)warningView{
    [self willChangeValueForKey:@"WarningViewKey"];
    objc_setAssociatedObject(self, &WarningViewKey, warningView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"WarningViewKey"];
}

- (EmptyWarnView *)warningView{
    return objc_getAssociatedObject(self, &WarningViewKey);
}

/**
 *  空页面呈现
 */
- (void)emptyViewShowWithDataType:(EmptyViewType)emptyViewType
                          isEmpty:(BOOL)isEmpty
              emptyViewClickBlock:(emptyViewClickBlock)clickBlock {
    
    if (self.warningView) {
        [self.warningView removeFromSuperview];
    }
    if (isEmpty) {
        self.warningView = [EmptyWarnView initWithFrame:self.bounds andType:emptyViewType];
        if (!clickBlock) {
            self.warningView.btnFunc.hidden = YES;
        }
        self.warningView.clickBlock = clickBlock;
        [self addSubview:self.warningView];
    }
    
}

@end

@implementation EmptyWarnView

/**
 *  初始化
 */
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
        //计算顶部高度
        CGFloat totalH = frame.size.height-120-40;
        if(self.warningView.clickBlock) {
            totalH -= 60;
        }
        CGFloat topH = totalH/2;
        
        //创建“空白图片”
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-90)/2, topH, 90, 95)];
        [self addSubview:self.imgView];
        
        //创建“主标题”
        self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, self.imgView.bottom+20, frame.size.width-20, 20)];
        [self.lblTitle setText:@"暂无数据～"];
        [self.lblTitle setTextColor:COLOR9];
        [self.lblTitle setTextAlignment:NSTextAlignmentCenter];
        [self.lblTitle setFont:FONT16];
        [self addSubview:self.lblTitle];
        
        //创建“副标题”
        self.lblSubTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, self.lblTitle.bottom+10, frame.size.width-20, 30)];
        [self.lblSubTitle setText:@""];
        [self.lblSubTitle setTextColor:COLOR9];
        [self.lblSubTitle setTextAlignment:NSTextAlignmentCenter];
        [self.lblSubTitle setFont:FONT11];
        [self addSubview:self.lblSubTitle];
        
        //创建“刷新按钮”
        self.btnFunc = [[UIButton alloc] initWithFrame:CGRectMake((frame.size.width-120)/2, self.lblSubTitle.bottom+10, 120, 40)];
        [self.btnFunc setTitle:@"请登录" forState:UIControlStateNormal];
        [self.btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.btnFunc.titleLabel setFont:FONT17];
        [self.btnFunc.layer setCornerRadius:3.0];
        [self.btnFunc setBackgroundColor:MAIN_COLOR];
        [self.btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btnFunc];
        
    }
    return self;
}

/**
 *  按钮点击事件
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"功能按钮");
    
    if (self.clickBlock) {
        self.clickBlock(1);
    }
    
//    //移除提示、设置动画让空白页面消失
//    [UIView animateWithDuration:0.5 animations:^{
//        //self.alpha = 0;
//    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
//    }];
    
}

/**
 *  设置视图
 */
+ (EmptyWarnView *)initWithFrame:(CGRect)frame andType:(EmptyViewType)type{
    NSString *imageName,*title,*subTitle;
    
    //根据参数设置界面
    EmptyWarnView *warningView = [[EmptyWarnView alloc] initWithFrame:frame];
    switch (type) {
        case EmptyViewTypeLoadFail: {
            //加载失败
            
            imageName = @"empty_icon_wait";
            title = @"暂无数据~";
            
            break;
        }
        case EmptyViewTypeWait: {
            
            imageName = @"empty_icon_wait";
            title = @"加载失败,请重新加载～";
            break;
        }
            
        default:
            break;
    }
    
    
    [warningView.imgView setImage:[UIImage imageNamed:imageName]];
    warningView.lblTitle.text = title;
    
    //副标题
    if(!IsStringEmpty(subTitle)) {
        warningView.lblSubTitle.text = subTitle;
        [warningView.lblSubTitle setNumberOfLines:2];
        if(!IsStringEmpty(subTitle)) {
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:subTitle];
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            [style setAlignment:NSTextAlignmentCenter];
            [style setLineSpacing:5.0f];
            [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, subTitle.length)];
            [warningView.lblSubTitle setAttributedText:attStr];
        }
    }
    
    return warningView;
}

@end

