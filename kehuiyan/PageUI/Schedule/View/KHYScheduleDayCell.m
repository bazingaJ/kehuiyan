//
//  KHYScheduleDayCell.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/3/2.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYScheduleDayCell.h"

@implementation KHYScheduleDayCell

- (void)setScheduleDay {
    
    CGFloat tWidth = SCREEN_WIDTH/7;
    
    //创建“背景层”
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(1, 1, tWidth-2, 58)];
    [self.contentView addSubview:backView];
    
    //创建“日期”
    self.lbMsg = [[UILabel alloc] initWithFrame:CGRectMake((backView.frame.size.width-35)/2, 0, 35, 35)];
    [self.lbMsg setTextColor:COLOR3];
    [self.lbMsg setFont:SYSTEM_FONT_SIZE(15.0)];
    [self.lbMsg setTextAlignment:NSTextAlignmentCenter];
    [self.lbMsg.layer setCornerRadius:17.5];
    [self.lbMsg.layer setMasksToBounds:YES];
    //[self.lbMsg setBackgroundColor:RGBA(224,208,219,0.8)];
    [backView addSubview:self.lbMsg];
    
    //创建“约课状态”
    self.lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, backView.frame.size.width, 20)];
    [self.lbMsg2 setText:@"已约课"];
    [self.lbMsg2 setTextColor:MAIN_COLOR];
    [self.lbMsg2 setTextAlignment:NSTextAlignmentCenter];
    [self.lbMsg2 setFont:SYSTEM_FONT_SIZE(10.0)];
    [self.lbMsg2 setHidden:YES];
    [backView addSubview:self.lbMsg2];
    
}

- (void)setCellDate:(NSDate *)cellDate {
    _cellDate = cellDate;
    if ([[KHYDateHelper manager] checkSameMonth:_cellDate AnotherMonth:_currentDate]) {
        [self showDateFunction];
    } else {
        [self showSpaceFunction];
    }
    
}

- (void)showSpaceFunction {
    self.userInteractionEnabled = NO;
    self.lbMsg.text = @"";
    self.lbMsg.backgroundColor = [UIColor clearColor];
    self.lbMsg.layer.borderWidth = 0;
    self.lbMsg.layer.borderColor = [UIColor clearColor].CGColor;
    
    self.lbMsg2.text = @"";
    //_pointV.hidden = YES;
}

- (void)showDateFunction {
    
    self.userInteractionEnabled = YES;
    
    self.lbMsg.text = [[KHYDateHelper manager] getStrFromDateFormat:@"d" Date:_cellDate];
    if ([[KHYDateHelper manager] isSameDate:_cellDate AnotherDate:[NSDate date]]) {
        self.lbMsg.layer.borderWidth = 1.5;
        self.lbMsg.layer.borderColor = MAIN_COLOR.CGColor;
    } else {
        self.lbMsg.layer.borderWidth = 0;
        self.lbMsg.layer.borderColor = [UIColor clearColor].CGColor;
    }
    
    if (_selectDate) {
        
        if ([[KHYDateHelper manager] isSameDate:_cellDate AnotherDate:_selectDate]) {
            self.lbMsg.backgroundColor = MAIN_COLOR;
            self.lbMsg.textColor = [UIColor whiteColor];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *dateTime = [formatter stringFromDate:_selectDate];
            NSLog(@"当前日期:%@",dateTime);
            
            if([_eventArray containsObject:dateTime]) {
                self.lbMsg2.hidden = NO;
            }
        } else {
            self.lbMsg.backgroundColor = [UIColor clearColor];
            self.lbMsg.textColor = [UIColor blackColor];
            
            NSString *currentDate = [[KHYDateHelper manager] getStrFromDateFormat:@"yyyy-MM-dd" Date:_cellDate];
            if([_eventArray containsObject:currentDate]) {
                self.lbMsg2.hidden = NO;
                
                self.lbMsg.backgroundColor = kRGB_alpha(224,208,219,1);
                self.lbMsg.textColor = [UIColor blackColor];
            }
        }
    }
    
    
    
}

@end
