//
//  MHDatePicker.h
//  AIYISHU
//
//  Created by 相约在冬季 on 16/4/11.
//  Copyright © 2016年 AIYISHU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHSelectPickerView.h"

typedef void (^DataTimeSelect)(NSDate *selectDataTime);

@interface MHDatePicker : UIView
@property (strong, nonatomic) NSDate *maxSelectDate;
///优先级低于isBeforeTime
@property (strong, nonatomic) NSDate *minSelectDate;

@property (strong, nonatomic) NSDate *selectDate;

///是否可选择当前时间之前的时间,默认为NO
@property (nonatomic,assign) BOOL isBeforeTime;

///DatePickerMode,默认是DateAndTime
@property (assign, nonatomic) UIDatePickerMode datePickerMode;

- (void)didFinishSelectedDate:(DataTimeSelect)selectDataTime;

@end
