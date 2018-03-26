//
//  KHYScheduleCalendarView.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/3/2.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYScheduleCalendarView.h"

static CGFloat const yearMonthH = 60;   //年月高度
static CGFloat const weeksH = 40;       //周高度

@interface KHYScheduleCalendarView ()

@property (nonatomic, strong) UILabel *yearMonthL;      //年月label
@property (nonatomic, strong) UIScrollView *scrollV;    //scrollview
//@property (nonatomic, assign) CalendarType type;        //选择类型
@property (nonatomic, strong) NSDate *currentDate;      //当前月份
@property (nonatomic, strong) NSDate *selectDate;       //选中日期
@property (nonatomic, strong) NSDate *tmpCurrentDate;   //记录上下滑动日期

@property (nonatomic, strong) KHYScheduleMonthView *leftView;    //左侧日历
@property (nonatomic, strong) KHYScheduleMonthView *middleView;  //中间日历
@property (nonatomic, strong) KHYScheduleMonthView *rightView;   //右侧日历

@end

@implementation KHYScheduleCalendarView

- (instancetype)initWithFrame:(CGRect)frame Date:(NSDate *)date
{
    
    if (self = [super initWithFrame:frame])
    {
        _currentDate = date;
        _selectDate = date;
        
        //创建“背景层”
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, weeksH)];
        [backView setBackgroundColor:MAIN_COLOR];
        [self addSubview:backView];
        
        //创建“周”
        NSArray *weekArr = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
        CGFloat weekdayW = SCREEN_WIDTH/7;
        for (int i = 0; i < 7; i++) {
            UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(i*weekdayW, 0, weekdayW, weeksH)];
            [lbMsg setText:weekArr[i]];
            [lbMsg setTextColor:[UIColor whiteColor]];
            [lbMsg setTextAlignment:NSTextAlignmentCenter];
            [lbMsg setFont:SYSTEM_FONT_SIZE(15.0)];
            [backView addSubview:lbMsg];
        }
        
        //创建“年月”
        _yearMonthL = [[UILabel alloc] initWithFrame:CGRectMake(0, weeksH, SCREEN_WIDTH, yearMonthH)];
        _yearMonthL.text = [[KHYDateHelper manager] getStrFromDateFormat:@"yyyy MM EEE" Date:_currentDate];
        _yearMonthL.textAlignment = NSTextAlignmentCenter;
        _yearMonthL.font = [UIFont systemFontOfSize:24.0];
        _yearMonthL.backgroundColor = [UIColor whiteColor];
        [self addSubview:_yearMonthL];
        
        [self settingScrollView];
        [self addObserver];
        
    }
    return self;
}

- (void)dealloc
{
    [_scrollV removeObserver:self forKeyPath:@"contentOffset"];
}

+ (CGFloat)getMonthTotalHeight:(NSDate *)date
{
    
    //NSInteger rows = [[EYDateHelper manager] getRows:date];
    //return yearMonthH + weeksH + (rows) * dayCellH;
    return yearMonthH + weeksH + 6 * dayCellH;
    
}

- (void)settingScrollView
{
    _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, yearMonthH + weeksH, SCREEN_WIDTH, 360)];
    _scrollV.contentSize = CGSizeMake(SCREEN_WIDTH * 3, 0);
    _scrollV.pagingEnabled = YES;
    _scrollV.showsHorizontalScrollIndicator = NO;
    _scrollV.showsVerticalScrollIndicator = NO;
    _scrollV.backgroundColor = [UIColor greenColor];
    _scrollV.scrollEnabled = NO;
    [self addSubview:_scrollV];
    
    __weak typeof(self) weakSelf = self;
    CGFloat height = 6 * dayCellH;
    _leftView = [[KHYScheduleMonthView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height) Date:[[KHYDateHelper manager] getPreviousMonth:_currentDate]];
    _leftView.selectDate = _selectDate;
    
    _middleView = [[KHYScheduleMonthView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, height) Date:_currentDate];
    _middleView.selectDate = _selectDate;
    _middleView.sendSelectDate = ^(NSDate *selDate)
    {
        weakSelf.selectDate = selDate;
        if (weakSelf.sendSelectDate) {
            weakSelf.sendSelectDate(selDate);
        }
        [weakSelf setData];
    };
    
    _rightView = [[KHYScheduleMonthView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 2, 0, SCREEN_WIDTH, height) Date:[[KHYDateHelper manager] getNextMonth:_currentDate]];
    _rightView.selectDate = _selectDate;
    
    [_scrollV addSubview:_leftView];
    [_scrollV addSubview:_middleView];
    [_scrollV addSubview:_rightView];
    
    //年月
    NSString *monthStr = [[KHYDateHelper manager] getStrFromDateFormat:@"yyyy-MM" Date:_currentDate];
    
    [self scrollToCenter:monthStr];
}

- (void)setData {
    
    _middleView.currentDate = _currentDate;
    _middleView.selectDate = _selectDate;
    _leftView.currentDate = [[KHYDateHelper manager] getPreviousMonth:_currentDate];
    _leftView.selectDate = _selectDate;
    _rightView.currentDate = [[KHYDateHelper manager] getNextMonth:_currentDate];
    _rightView.selectDate = _selectDate;
    
}

//MARK: - kvo
- (void)addObserver
{
    [_scrollV addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        [self monitorScroll];
    }
    
}

- (void)monitorScroll
{
    
    if (_scrollV.contentOffset.x > 2*SCREEN_WIDTH -1) {
        
        //左滑,下个月
        _middleView.currentDate = [[KHYDateHelper manager] getNextMonth:_currentDate];
        _middleView.selectDate = _selectDate;
        _leftView.currentDate = _currentDate;
        _leftView.selectDate = _selectDate;
        _currentDate = [[KHYDateHelper manager] getNextMonth:_currentDate];
        _rightView.currentDate = [[KHYDateHelper manager] getNextMonth:_currentDate];
        _rightView.selectDate = _selectDate;
        _yearMonthL.text = [[KHYDateHelper manager] getStrFromDateFormat:@"yyyy MM EEE" Date:_currentDate];
        
        //年月
        NSString *monthStr = [[KHYDateHelper manager] getStrFromDateFormat:@"yyyy-MM" Date:_currentDate];
        
        [self scrollToCenter:monthStr];
        
    }
    else if (_scrollV.contentOffset.x < 1)
    {
        
        //右滑,上个月
        _middleView.currentDate = [[KHYDateHelper manager] getPreviousMonth:_currentDate];
        _middleView.selectDate = _selectDate;
        _rightView.currentDate = _currentDate;
        _rightView.selectDate = _selectDate;
        _currentDate = [[KHYDateHelper manager] getPreviousMonth:_currentDate];
        _leftView.currentDate = [[KHYDateHelper manager] getPreviousMonth:_currentDate];
        _leftView.selectDate = _selectDate;
        _yearMonthL.text = [[KHYDateHelper manager] getStrFromDateFormat:@"yyyy MM EEE" Date:_currentDate];
        
        //年月
        NSString *monthStr = [[KHYDateHelper manager] getStrFromDateFormat:@"yyyy-MM" Date:_currentDate];
        
        [self scrollToCenter:monthStr];
        
    }
    
}

//MARK: - scrollViewMethod
- (void)scrollToCenter:(NSString *)monthStr
{
    _scrollV.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    
    //可以在这边进行网络请求获取事件日期数组等,记得取消上个未完成的网络请求
    
    NSMutableArray *itemArr = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        NSString *dateStr = [NSString stringWithFormat:@"%@-%d",[[KHYDateHelper manager] getStrFromDateFormat:@"MM" Date:_currentDate],1 + arc4random()%28];
        [itemArr addObject:dateStr];
    }
    
    
//    NSMutableArray *itemArr = [NSMutableArray array];
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    [param setValue:@"ucenter" forKey:@"app"];
//    [param setValue:@"getDayListByMonth" forKey:@"act"];
//    [param setValue:monthStr forKey:@"month"];
//    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
//        NSString *code = [json objectForKey:@"code"];
//        if([code isEqualToString:SUCCESS]) {
//            NSArray *dataArr = [json objectForKey:@"data"];
//            if(dataArr && [dataArr count]>0)
//            {
//                for (int i=0; i<[dataArr count]; i++)
//                {
//                    [itemArr addObject:dataArr[i]];
//                }
//
//                _middleView.eventArray = itemArr;
//            }
//
//        }
//    } failure:^(NSError *error) {
//        NSLog(@"%@",[error description]);
//    }];
    
    _middleView.eventArray = itemArr;
}


@end
