//
//  KHYScheduleMonthView.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/3/2.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHYScheduleDayCell.h"

typedef void(^SendSelectDate)(NSDate *selDate);

@interface KHYScheduleMonthView : UIView<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) NSDate *currentDate;          //当前月份
@property (nonatomic, strong) NSDate *selectDate;           //选中日期
@property (nonatomic, copy) SendSelectDate sendSelectDate;  //回传选中日期
@property (nonatomic, strong) NSArray *eventArray;          //事件数组

- (instancetype)initWithFrame:(CGRect)frame Date:(NSDate *)date;

@property (nonatomic, strong) UICollectionView *collectionV;

@end
