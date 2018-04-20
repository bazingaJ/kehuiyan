//
//  KHYBirthdayDatePickerView.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/3/13.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYBirthdayDatePickerView.h"

@interface KHYBirthdayDatePickerView ()

@property (nonatomic, strong) NSString *dateStr;

@end

@implementation KHYBirthdayDatePickerView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // 设置当前日期为最大值
    self.JXDatePicker.maximumDate = [NSDate date];
    
}

- (IBAction)valueChange:(UIDatePicker *)sender
{
    NSDate *selectedDate =sender.date;
    self.dateStr = [JXAppTool transformServerFormatStringByAnydate:selectedDate];
    
}

- (IBAction)cancelBtnClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(cancelBtnClick)])
    {
        [self.delegate cancelBtnClick];
    }
}
- (IBAction)containBtnClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(containBtnClickWithDateString:)])
    {
        [self.delegate containBtnClickWithDateString:self.dateStr];
    }
}


@end
