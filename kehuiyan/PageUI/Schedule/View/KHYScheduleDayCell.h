//
//  KHYScheduleDayCell.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/3/2.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHYDateHelper.h"

static CGFloat const dayCellH = 60;//日期cell高度

@interface KHYScheduleDayCell : UICollectionViewCell

@property (nonatomic, strong) NSDate *currentDate;  //当月或当周日期
@property (nonatomic, strong) NSDate *selectDate;   //选择日期
@property (nonatomic, strong) NSDate *cellDate;     //cell显示日期
@property (nonatomic, strong) NSArray *eventArray;  //事件数组

@property (nonatomic, strong) UILabel *lbMsg;
@property (nonatomic, strong) UILabel *lbMsg2;

- (void)setScheduleDay;

@end
