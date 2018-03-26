//
//  KHYScheduleMonthTopView.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/23.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYScheduleMonthTopView.h"
#import "KHYScheduleCalendarView.h"

@interface KHYScheduleMonthTopView ()

@property (nonatomic, strong) KHYScheduleCalendarView *calendarView;


@end

@implementation KHYScheduleMonthTopView

/**
 *  菜单
 */
- (KHYScheduleMenuView *)menuView {
    if(!_menuView) {
        _menuView = [[KHYScheduleMenuView alloc] initWithFrame:CGRectMake(0, 480, self.frame.size.width, 90) detailArr:@[@"本月总任务",@"已完成",@"已逾期"]];
        [self addSubview:_menuView];
    }
    return _menuView;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
        //设置背景层
        self.backgroundColor = BACK_COLOR;
        
        //创建“日历”
//        WS(weakSelf);
        NSLog(@"%f",[KHYScheduleCalendarView getMonthTotalHeight:[NSDate date]]);
        _calendarView = [[KHYScheduleCalendarView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, [KHYScheduleCalendarView getMonthTotalHeight:[NSDate date]]) Date:[NSDate date]];
        _calendarView.sendSelectDate = ^(NSDate *selDate)
        {
            NSString *dateStr = [[KHYDateHelper manager] getStrFromDateFormat:@"yyyy-MM-dd" Date:selDate];
            NSLog(@"当前选择日期：%@",dateStr);
            
//            weakSelf.monthStr = [[KHYDateHelper manager] getStrFromDateFormat:@"yyyy-MM-dd" Date:selDate];
//
//            [weakSelf.dataArr removeAllObjects];
//            [weakSelf.tableView reloadData];
//            //获取当前日期的数据
//            [weakSelf getScheduleList:weakSelf.monthStr];
        };
        [self addSubview:_calendarView];
        
        //创建“菜单”
        [self menuView];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
