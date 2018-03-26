//
//  KHYScheduleCalendarView.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/3/2.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHYScheduleMonthView.h"

typedef void(^RefreshH)(CGFloat viewH);

@interface KHYScheduleCalendarView : UIView

@property (nonatomic, copy) SendSelectDate sendSelectDate;  //回传选择日期

/**
 实现该block滑动时更新控件高度
 */
@property (nonatomic, copy) RefreshH refreshH;

/**
 根据日期获取控件总高度
 
 @param date 日期
 @return return value description
 */
+ (CGFloat)getMonthTotalHeight:(NSDate *)date;

/**
 初始化方法
 
 @param frame 控件尺寸,高度可以调用该类计算方法计算
 @param date 日期
 @return return value description
 */
- (instancetype)initWithFrame:(CGRect)frame Date:(NSDate *)date;

- (void)scrollToCenter:(NSString *)monthStr;


@end
