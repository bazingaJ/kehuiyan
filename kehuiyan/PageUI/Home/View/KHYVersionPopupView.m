//
//  KHYVersionPopupView.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/10.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYVersionPopupView.h"

@implementation KHYVersionPopupView

- (id)initWithFrame:(CGRect)frame param:(NSMutableDictionary *)param {
    self = [super initWithFrame:frame];
    if(self) {
        
        self.backgroundColor = [UIColor clearColor];
        [self.layer setCornerRadius:4.0];
        
        //参数
        NSString *content = @"";
        NSArray *itemArr = [param objectForKey:@"content"];
        if(itemArr && [itemArr count]>0) {
            content = [itemArr componentsJoinedByString:@"\r\n"];
        }
        
        NSString *version = [param objectForKey:@"version"];
        NSString *is_force = [param objectForKey:@"is_force"];
        
        //创建“头部背景色”
        UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [backView setImage:[UIImage imageNamed:@"version_update"]];
        [self addSubview:backView];
        
        //创建“关闭按钮”
        if(![is_force isEqualToString:@"1"]) {
            UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width-40, 60, 30, 30)];
            [btnFunc setImage:[UIImage imageNamed:@"version_close"] forState:UIControlStateNormal];
            [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
            [btnFunc setTag:2];
            [self addSubview:btnFunc];
        }
        
        //创建“版本号”
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake((frame.size.width-90)/2, 150, 90, 28)];
        [lbMsg.layer setCornerRadius:14];
        [lbMsg.layer setBorderWidth:1.5];
        [lbMsg.layer setBorderColor:UIColorFromRGBWith16HEX(0x6AC7F6).CGColor];
        [lbMsg.layer setMasksToBounds:YES];
        [lbMsg setText:[NSString stringWithFormat:@"v%@",version]];
        [lbMsg setTextColor:[UIColor whiteColor]];
        [lbMsg setFont:FONT15];
        [lbMsg setTextAlignment:NSTextAlignmentCenter];
        [lbMsg setBackgroundColor:UIColorFromRGBWith16HEX(0x5B90C5)];
        [backView addSubview:lbMsg];
        
        //创建“描述”
        UILabel *lblDesc = [[UILabel alloc] initWithFrame:CGRectMake(35, 195, frame.size.width-70, 125)];
        [lblDesc setTextAlignment:NSTextAlignmentLeft];
        [lblDesc setTextColor:[UIColor blackColor]];
        [lblDesc setFont:SYSTEM_FONT_SIZE(14.0)];
        [lblDesc setNumberOfLines:0];
        if(!IsStringEmpty(content)) {
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:content];
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            [style setLineSpacing:10.0f];
            [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, content.length)];
            [lblDesc setAttributedText:attStr];
        }
        [backView addSubview:lblDesc];
        
        CGFloat itemH = 330;
        //创建“更新按钮”
        NSMutableArray *titleArr = [NSMutableArray array];
        [titleArr addObject:@"立即升级"];
        if(![is_force isEqualToString:@"1"]) {
            [titleArr addObject:@"暂不升级"];
        }
        itemH = [titleArr count]==1 ? 350 : itemH;
        for(int i=0;i<[titleArr count];i++) {
            UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake((frame.size.width-185)/2, itemH+45*i, 185, 35)];
            [btnFunc.layer setCornerRadius:5.0];
            [btnFunc setTitle:[titleArr objectAtIndex:i] forState:UIControlStateNormal];
            [btnFunc.titleLabel setFont:FONT17];
            [btnFunc.layer setBorderWidth:0.5];
            [btnFunc.layer setBorderColor:[UIColor whiteColor].CGColor];
            if(i==0) {
                [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btnFunc setBackgroundColor:GREEN_COLOR];
                
            }else if(i==1) {
                [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
                [btnFunc setBackgroundColor:UIColorFromRGBWith16HEX(0xE8E8E8)];
            }
            [btnFunc setTag:i];
            [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btnFunc];
        }
        
    }
    return self;
}

//关闭窗体
- (void)btnCloseClick:(UIButton *)btnSender {
    if([self.delegate respondsToSelector:@selector(popupView:dismissWithSender:)]) {
        [self.delegate popupView:self dismissWithSender:btnSender];
    }
}

//按钮点击事件
- (void)btnFuncClick:(UIButton *)btnSender {
    if([self.delegate respondsToSelector:@selector(popupView:withSender:)]) {
        [self.delegate popupView:self withSender:btnSender];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
