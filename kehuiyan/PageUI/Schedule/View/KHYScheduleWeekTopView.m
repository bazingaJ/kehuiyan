//
//  KHYScheduleWeekTopView.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/23.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYScheduleWeekTopView.h"


@interface KHYScheduleWeekTopView ()



@property (nonatomic, strong) NSMutableArray *weeksArr;;

@property (nonatomic, strong) NSDate *currentDate;

@end

@implementation KHYScheduleWeekTopView

/**
 *  菜单
 */
- (KHYScheduleMenuView *)menuView {
    if(!_menuView) {
        _menuView = [[KHYScheduleMenuView alloc] initWithFrame:CGRectMake(0, 110, self.frame.size.width, 90) detailArr:@[@"本周总任务",@"已完成",@"已逾期"]];
        [self addSubview:_menuView];
    }
    return _menuView;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.currentDate = [NSDate date];
        [self getCurrentWeekByDate];
        //设置背景层
        self.backgroundColor = BACK_COLOR;
        
        //创建“背景层”
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, self.frame.size.width, 90)];
        [backView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:backView];
        
        //创建“左侧尖头”
//        UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 35, 35)];
//        [btnFunc setImage:[UIImage imageNamed:@"next_icon_right"] forState:UIControlStateNormal];
//        [btnFunc addTarget:self action:@selector(weeksLeftArrowClick) forControlEvents:UIControlEventTouchUpInside];
//        [backView addSubview:btnFunc];
        
        //创建“右侧尖头”
//        UIButton *btnFunc2 = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-35, 5, 35, 35)];
//        [btnFunc2 setImage:[UIImage imageNamed:@"next_icon_right"] forState:UIControlStateNormal];
//        [btnFunc2 addTarget:self action:@selector(weeksRightArrowClick) forControlEvents:UIControlEventTouchUpInside];
//        [backView addSubview:btnFunc2];
        
        //创建“周”
        NSArray *titleArr = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
        CGFloat tWidth = (self.frame.size.width-70)/7;
        for (int i=0; i<7; i++) {
            
            UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(35+tWidth*i, 5, tWidth, 35)];
            [btnFunc setTitle:titleArr[i] forState:UIControlStateNormal];
            [btnFunc setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
            [btnFunc.titleLabel setFont:FONT16];
            [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
            [backView addSubview:btnFunc];
            
        }
        
        //创建“分割线”
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, self.frame.size.width, 0.5)];
        [lineView setBackgroundColor:LINE_COLOR];
        [self addSubview:lineView];
        
        //创建“日”
        for (int i=0; i<7; i++) {
            
            UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(35+tWidth*i, 50, tWidth, 35)];
            [btnFunc setTitle:self.weeksArr[i] forState:UIControlStateNormal];
            [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
            [btnFunc.titleLabel setFont:FONT16];
            btnFunc.tag = i + 10;
            [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
            [backView addSubview:btnFunc];
            
        }
        
        //创建“菜单”
        [self menuView];
        
    }
    return self;
}

- (void)weeksLeftArrowClick
{
    self.currentDate = [NSDate dateWithTimeInterval:-24*60*60*7 sinceDate:self.currentDate];
    [self getCurrentWeekByDate];
    for (int i = 0; i < 7; i ++)
    {
        UIView *backView = [self.subviews firstObject];
        UIButton *btn = (UIButton *)[backView viewWithTag:i+10];
        [btn setTitle:self.weeksArr[i] forState:UIControlStateNormal];
        
    }
}
- (void)weeksRightArrowClick
{
    self.currentDate = [NSDate dateWithTimeInterval:24*60*60*7 sinceDate:self.currentDate];
    [self getCurrentWeekByDate];
    for (int i = 0; i < 7; i ++)
    {
        UIView *backView = [self.subviews firstObject];
        UIButton *btn = (UIButton *)[backView viewWithTag:i+10];
        [btn setTitle:self.weeksArr[i] forState:UIControlStateNormal];
        
    }
}
/**
 *  获取当前时间所在一周的第一天和最后一天
 */
- (void)getCurrentWeekByDate
{
    // 当前时间
//    NSDate *now = [NSDate date];
    // 当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 当前日历组件
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:self.currentDate];
    // 得到星期几
    // 1(星期天) 2(星期二) 3(星期三) 4(星期四) 5(星期五) 6(星期六) 7(星期天)
    NSInteger weekDay = [comp weekday];
    // 得到几号
    NSInteger day = [comp day];
    
    // 计算当前日期和这周的星期一和星期天差的天数
    long firstDiff,lastDiff;
    if (weekDay == 1) {
        firstDiff = 1;
        lastDiff = 0;
    }else{
        firstDiff = [calendar firstWeekday] - weekDay;
        lastDiff = 7 - weekDay;
    }
    
    self.weeksArr = [NSMutableArray arrayWithArray:[self getCurrentWeeksWithFirstDiff:firstDiff lastDiff:lastDiff]];
    
    // 在当前日期(去掉了时分秒)基础上加上差的天数
    [comp setDay:day + firstDiff];
    NSDate *firstDayOfWeek= [calendar dateFromComponents:comp];
    
    [comp setDay:day + lastDiff];
    NSDate *lastDayOfWeek= [calendar dateFromComponents:comp];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    
    NSLog(@"一周开始 %@",[formater stringFromDate:firstDayOfWeek]);
//    NSLog(@"当前 %@",[formater stringFromDate:date]);
    NSLog(@"一周结束 %@",[formater stringFromDate:lastDayOfWeek]);
    
}

//获取一周时间 数组
- (NSMutableArray *)getCurrentWeeksWithFirstDiff:(NSInteger)first lastDiff:(NSInteger)last{
    NSMutableArray *eightArr = [[NSMutableArray alloc] init];
    for (NSInteger i = first; i < last + 1; i ++) {
        //从现在开始的24小时
        NSTimeInterval secondsPerDay = i * 24*60*60;
        NSDate *curDate = [NSDate dateWithTimeInterval:secondsPerDay sinceDate:self.currentDate];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd"];
        NSString *dateStr = [dateFormatter stringFromDate:curDate];//几月几号
        /*
        NSDateFormatter *weekFormatter = [[NSDateFormatter alloc] init];
        [weekFormatter setDateFormat:@"EEEE"];//星期几 @"HH:mm 'on' EEEE MMMM d"];
        NSString *weekStr = [weekFormatter stringFromDate:curDate];
        
        //组合时间
        NSString *strTime = [NSString stringWithFormat:@"%@(%@)",dateStr,weekStr];
        [eightArr addObject:strTime];
        */
        [eightArr addObject:dateStr];
    }
    return eightArr;
}

@end
