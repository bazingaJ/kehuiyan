//
//  KHYScheduleDayTopView.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/23.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYScheduleDayTopView.h"

@interface KHYScheduleDayTopView ()
@property (nonatomic, strong) UILabel *lbMsg;
@property (nonatomic, strong) NSDate *currentDate;
@end

@implementation KHYScheduleDayTopView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
        self.currentDate = [JXAppTool getCurrentTime];
        //设置背景层
        self.backgroundColor = BACK_COLOR;
        
        //创建“背景层”
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, self.frame.size.width, 45)];
        [backView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:backView];
        
        //创建“左侧尖头”
//        UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 35, 35)];
//        [btnFunc setImage:[UIImage imageNamed:@"next_icon_right"] forState:UIControlStateNormal];
//        [btnFunc addTarget:self action:@selector(leftArrowClick) forControlEvents:UIControlEventTouchUpInside];
//        [backView addSubview:btnFunc];
        
        //创建“日期”
        self.lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(45, 10, self.frame.size.width-90, 25)];
        [self.lbMsg setText:[JXAppTool transformLocalStringByAnydate:self.currentDate]];
        [self.lbMsg setTextColor:COLOR3];
        [self.lbMsg setTextAlignment:NSTextAlignmentCenter];
        [self.lbMsg setFont:FONT16];
        [backView addSubview:self.lbMsg];
        
        //创建“右侧尖头”
//        UIButton *btnFunc2 = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-35, 5, 35, 35)];
//        [btnFunc2 setImage:[UIImage imageNamed:@"next_icon_right"] forState:UIControlStateNormal];
//        [btnFunc2 addTarget:self action:@selector(rightArrowClick) forControlEvents:UIControlEventTouchUpInside];
//        [backView addSubview:btnFunc2];
        
    }
    return self;
}

- (void)leftArrowClick
{
    if ([self.delegate respondsToSelector:@selector(leftArrowClickGetDateString:)])
    {
        self.currentDate = [JXAppTool getYesterdayTimeByRandomTime:self.currentDate];
        NSString *lastTimeString = [JXAppTool transformLocalStringByAnydate:self.currentDate];
        self.lbMsg.text = lastTimeString;
        [self.delegate leftArrowClickGetDateString:self.currentDate];
    }
}

- (void)rightArrowClick
{
    if ([self.delegate respondsToSelector:@selector(rightArrowClickGetDateString:)])
    {
        self.currentDate = [JXAppTool getTomorrowTimeByRandomTime:self.currentDate];
        NSString *nextTimeString = [JXAppTool transformLocalStringByAnydate:self.currentDate];
        self.lbMsg.text = nextTimeString;
        [self.delegate rightArrowClickGetDateString:self.currentDate];
    }
}


@end
