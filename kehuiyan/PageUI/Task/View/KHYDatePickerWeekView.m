//
//  KHYDatePickerWeekView.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/23.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYDatePickerWeekView.h"

@interface KHYDatePickerWeekView () {
    NSString *yearStr;
    NSString *monthStr;
    NSString *weekStr;
    
    //某个月的总天数
    NSInteger totalNum;
    //某个月的总周数
    NSInteger weekNum;
}

@property (nonatomic, strong) UIView *topView;

/**
 *  年
 */
@property (nonatomic, strong) NSMutableArray *yearArr;
/**
 *  月
 */
@property (nonatomic, strong) NSMutableArray *monthArr;
/**
 *  周
 */
@property (nonatomic, strong) NSMutableArray *weekArr;

@end


@implementation KHYDatePickerWeekView

/**
 *  年
 */
- (NSMutableArray *)yearArr {
    if(!_yearArr) {
        _yearArr = [NSMutableArray array];
    }
    return _yearArr;
}

/**
 *  月
 */
- (NSMutableArray *)monthArr {
    if(!_monthArr) {
        _monthArr = [NSMutableArray array];
    }
    return _monthArr;
}

/**
 *  周
 */
- (NSMutableArray *)weekArr {
    if(!_weekArr) {
        _weekArr = [NSMutableArray array];
    }
    return _weekArr;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
        self.titleArr = @[@"年",@"月",@"周"];
        
        //设置背景层
        self.backgroundColor = [UIColor whiteColor];
        
        //设置“背景层”
        CGRect rect = [UIScreen mainScreen].bounds;
        self.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        
        //设置面板高度
        self.yPosition = frame.size.height;
        
        //创建“背景层”
        CGRect frame = self.backView.frame;
        frame.size = CGSizeMake([UIScreen mainScreen].bounds.size.width, self.yPosition);
        frame.origin = CGPointMake(0, self.frame.size.height);
        
        //创建“背景层”
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.userInteractionEnabled = YES;
        _backView.frame = frame;
        [self addSubview:_backView];
        
        //设置年
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy"];//MM dd
        NSInteger currentYear = [[formatter stringFromDate:date] integerValue];
        for (int i=0; i<10; i++) {
            [self.yearArr addObject:[NSString stringWithFormat:@"%zd",currentYear+i]];
        }
        
        //设置月
        NSArray *titleArr = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十",@"十一",@"十二"];
        for (int i=0; i<[titleArr count]; i++) {
            NSString *titleStr = [NSString stringWithFormat:@"%zd",i+1];
            [self.monthArr addObject:@[titleStr,titleArr[i]]];
        }
        
        //加载界面
        [self loadUI];
        
        //弹层
        [self showAlert];
        
    }
    return self;
}

/**
 *  加载界面
 */
- (void)loadUI {
    
    //创建“顶部视图”
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
    [_topView setBackgroundColor:[UIColor whiteColor]];
    [_backView addSubview:_topView];
    
    CGFloat tWidth = self.frame.size.width/3;
    for (int i=0; i<3; i++) {
        NSString *titleStr = [NSString stringWithFormat:@"选择%@",[_titleArr objectAtIndex:i]];
        
        //创建“按钮”
        UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(tWidth*i, 10, tWidth, 30)];
        [btnFunc setTitleColor:COLOR9 forState:UIControlStateNormal];
        [btnFunc.titleLabel setFont:FONT16];
        [btnFunc setTag:100+i];
        [btnFunc setUserInteractionEnabled:NO];
        [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:btnFunc];
        
        //创建“地步滑动线”
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(tWidth*i+10, 48, tWidth-20, 2)];
        lineView.backgroundColor = MAIN_COLOR;
        [lineView setTag:300+i];
        [lineView setHidden:YES];
        [_topView addSubview:lineView];
        
        //设置默认
        if(i==0) {
            [btnFunc setTitle:titleStr forState:UIControlStateNormal];
            [btnFunc setUserInteractionEnabled:YES];
            [lineView setHidden:NO];
        }
    }
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49.5, self.frame.size.width, 0.5)];
    [lineView setBackgroundColor:LINE_COLOR];
    [_topView addSubview:lineView];
    
    //创建“”
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, self.frame.size.width, self.yPosition-50)];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(self.frame.size.width * 1, 300);
    _scrollView.pagingEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [_backView addSubview:_scrollView];
    
    for (int i=0; i<3; i++) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(self.frame.size.width * i, 0, self.frame.size.width, self.yPosition-50) style:UITableViewStylePlain];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.tag = 200+i;
        [_scrollView addSubview:tableView];
    }
    
}

- (void)btnFuncClick:(UIButton *)btnSender {
    for (UIView *view in _topView.subviews) {
        if (view.tag >= 300) {
            view.hidden = YES;
        }
    }
    UIView *lineView = [_topView viewWithTag:300+btnSender.tag-100];
    lineView.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        _scrollView.contentOffset = CGPointMake(self.frame.size.width*(btnSender.tag-100), 0);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (tableView.tag) {
        case 200: {
            //年
            return self.yearArr.count;
            
            break;
        }
        case 201: {
            //月
            return self.monthArr.count;
            
            break;
        }
        case 202: {
            //周
            return self.weekArr.count;
            
            break;
        }
            
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"KHYDatePickerWeekViewCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    //创建“标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 24)];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentCenter];
    [lbMsg setFont:FONT16];
    [cell.contentView addSubview:lbMsg];
    
    NSString *titleStr = @"";
    switch (tableView.tag) {
        case 200: {
            //年
            titleStr = [NSString stringWithFormat:@"%@年",[self.yearArr objectAtIndex:indexPath.row]];
            
            break;
        }
        case 201: {
            //月
            NSArray *itemArr = [self.monthArr objectAtIndex:indexPath.row];
            titleStr = [NSString stringWithFormat:@"%@月",itemArr[1]];
            
            break;
        }
        case 202: {
            //周
            NSArray *itemArr = [self.weekArr objectAtIndex:indexPath.row];
            titleStr = [NSString stringWithFormat:@"第%@周",itemArr[1]];
            
            break;
        }
            
        default:
            break;
    }
    [lbMsg setText:titleStr];
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, self.frame.size.width, 0.5)];
    [lineView setBackgroundColor:LINE_COLOR];
    [cell.contentView addSubview:lineView];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIButton *btnFunc1 = [_topView viewWithTag:100];
    UIButton *btnFunc2 = [_topView viewWithTag:101];
    UIButton *btnFunc3 = [_topView viewWithTag:102];
    
    for (UIView *view in _topView.subviews) {
        if (view.tag >= 300) {
            view.hidden = YES;
        }
    }
    
    CGFloat tWidth = self.frame.size.width/3;
    
    UIView *lineView1 = [_topView viewWithTag:300];
    UIView *lineView2 = [_topView viewWithTag:301];
    UIView *lineView3 = [_topView viewWithTag:302];
    
    switch (tableView.tag) {
        case 200: {
            //年
            
            //设置按钮1
            yearStr = [self.yearArr objectAtIndex:indexPath.row];
            NSString *titleStr = [NSString stringWithFormat:@"%@年",yearStr];
            [btnFunc1 setFrame:CGRectMake(0, 10, tWidth, 30)];
            [btnFunc1 setTitle:titleStr forState:UIControlStateNormal];
            [btnFunc1 setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
            [btnFunc1 setUserInteractionEnabled:YES];
            
            //设置按钮2
            NSString *titleStr2 = [NSString stringWithFormat:@"选择%@",[_titleArr objectAtIndex:tableView.tag-200+1]];
            [btnFunc2 setFrame:CGRectMake(tWidth, 10, tWidth, 30)];
            [btnFunc2 setTitle:titleStr2 forState:UIControlStateNormal];
            [btnFunc2 setTitleColor:COLOR9 forState:UIControlStateNormal];
            [btnFunc2 setUserInteractionEnabled:YES];
            
            //设置按钮3
            [btnFunc3 setTitle:@"" forState:UIControlStateNormal];
            [btnFunc3 setUserInteractionEnabled:NO];
            
            //设置滑动线条
            [lineView1 setFrame:CGRectMake(10, 48, tWidth-20, 2)];
            [lineView1 setHidden:YES];
            [lineView2 setFrame:CGRectMake(tWidth+10, 48, tWidth-20, 2)];
            [lineView2 setHidden:NO];
            
            //刷新数据表
            UITableView *tableView = [_scrollView viewWithTag:201];
            [tableView reloadData];
            _scrollView.contentSize = CGSizeMake(self.frame.size.width * 2, 300);
            [UIView animateWithDuration:0.5 animations:^{
                _scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
            }];
            
            break;
        }
        case 201: {
            //月
            
            //设置按钮2
            NSArray *itemArr = [self.monthArr objectAtIndex:indexPath.row];
            monthStr = itemArr[0];
            NSString *titleStr = [NSString stringWithFormat:@"%@月",itemArr[1]];
            [btnFunc2 setFrame:CGRectMake(tWidth, 10, tWidth, 30)];
            [btnFunc2 setTitle:titleStr forState:UIControlStateNormal];
            [btnFunc2 setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
            
            //设置按钮3
            NSString *titleStr2 = [NSString stringWithFormat:@"选择%@",[_titleArr objectAtIndex:tableView.tag-200+1]];
            [btnFunc3 setFrame:CGRectMake(tWidth*2, 10, tWidth, 30)];
            [btnFunc3 setTitle:titleStr2 forState:UIControlStateNormal];
            [btnFunc3 setTitleColor:COLOR9 forState:UIControlStateNormal];
            [btnFunc3 setUserInteractionEnabled:YES];
            
            //设置滑动线条
            [lineView2 setFrame:CGRectMake(tWidth+10, 48, tWidth-20, 2)];
            [lineView2 setHidden:YES];
            [lineView3 setFrame:CGRectMake(tWidth*2+10, 48, tWidth-20, 2)];
            [lineView3 setHidden:NO];
            
            //获取当前月的周数
            weekNum = [self weeksOfMonth:[monthStr integerValue] inYear:[yearStr integerValue]];
            NSArray *titleArr = @[@"一",@"二",@"三",@"四",@"五",@"六"];
            [self.weekArr removeAllObjects];
            for (int i=0; i<weekNum; i++) {
                NSString *tIndex = [NSString stringWithFormat:@"%zd",i+1];
                [self.weekArr addObject:@[tIndex,titleArr[i]]];
            }
            
            //获取当前月的总天数
            totalNum = [self getSumOfDaysInMonth:yearStr month:monthStr];
            
            //刷新数据表
            UITableView *tableView = [_scrollView viewWithTag:202];
            [tableView reloadData];
            _scrollView.contentSize = CGSizeMake(self.frame.size.width * 3, 300);
            [UIView animateWithDuration:0.5 animations:^{
                _scrollView.contentOffset = CGPointMake(self.frame.size.width*2, 0);
            }];
            
            break;
        }
        case 202: {
            //周
            
            //设置按钮3
            NSArray *itemArr = [self.weekArr objectAtIndex:indexPath.row];
            weekStr = itemArr[0];
            NSString *titleStr = [NSString stringWithFormat:@"第%@周",itemArr[1]];
            [btnFunc3 setFrame:CGRectMake(tWidth*2, 10, tWidth, 30)];
            [btnFunc3 setTitle:titleStr forState:UIControlStateNormal];
            [btnFunc3 setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
            
            //设置滑动线条
            [lineView3 setHidden:NO];
            [lineView3 setFrame:CGRectMake(tWidth*2+10, 48, tWidth-20, 2)];
            
            [self dismiss];
            
            break;
        }
            
        default:
            break;
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    for (UIView *view in _topView.subviews) {
        if (view.tag >= 300) {
            view.hidden = YES;
        }
    }
    if (scrollView == _scrollView) {
        UIView *lineView = [_topView viewWithTag:300 + scrollView.contentOffset.x / self.frame.size.width];
        lineView.hidden = NO;
    }
}

/**
 *  关闭弹出层
 */
- (void)dismiss {
    
//    UIButton *btnFunc1 = [_topView viewWithTag:100];
//    UIButton *btnFunc2 = [_topView viewWithTag:101];
//    UIButton *btnFunc3 = [_topView viewWithTag:102];
    
    //时间
    NSString *dateStr = [NSString stringWithFormat:@"%@-%@-1",yearStr,monthStr];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [format dateFromString:dateStr];
    
    //获取1号是周几(第一周)
    [format setDateFormat:@"EEEE"];
    NSString *weekString = [format stringFromDate:date];
    NSLog(@"%@是：%@",dateStr,weekString);
    
    NSArray *titleArr = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    NSInteger num = 7;
    for (int i=0; i<[titleArr count]; i++) {
        if(![weekString isEqualToString:[NSString stringWithFormat:@"星期%@",titleArr[i]]]) {
            num--;
            continue;
        }
        break;
    }
    
    //当前选择周数
    NSInteger week = [weekStr integerValue];
    
    //计算开始日期和结束日期
    NSInteger startNum = 0;
    NSInteger endNum = 0;
    if(week==1) {
        //第一个月
        startNum = 1;
        endNum = num;
    }else if(week==weekNum) {
        //最后一个月
        endNum = num+7*(week-1);
        if(endNum>totalNum) {
            endNum = totalNum;
        }
        //计算开始日期
        NSString *dateStr = [NSString stringWithFormat:@"%@-%@-%zd",yearStr,monthStr,endNum];
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [format dateFromString:dateStr];
        
        //获取是周几
        [format setDateFormat:@"EEEE"];
        NSString *weekString = [format stringFromDate:date];
        NSLog(@"%@是：%@",dateStr,weekString);
        
        NSArray *titleArr = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
        NSInteger num = 0;
        for (int i=0; i<[titleArr count]; i++) {
            if(![weekString isEqualToString:[NSString stringWithFormat:@"星期%@",titleArr[i]]]) {
                num++;
                continue;
            }
            break;
        }
        
        startNum = endNum-num;
        
    }else {
        endNum = num+7*(week-1);
        startNum = endNum-6;
    }
    
    NSString *startTime = @"";
    NSString *endTime = @"";
    if(!IsStringEmpty(yearStr) && !IsStringEmpty(monthStr)) {
        //开始日期
        if(startNum>0) {
            startTime = [NSString stringWithFormat:@"%@-%@-%zd",yearStr,monthStr,startNum];
        }
        //结束日期
        if(endNum>0) {
            endTime = [NSString stringWithFormat:@"%@-%@-%zd",yearStr,monthStr,endNum];
        }
    }
    NSString *resultStr = [NSString stringWithFormat:@"%@,%@",startTime,endTime];
    NSLog(@"当前日期为:第%zd周(日期为:%@)",week,resultStr);
    
    [UIView animateWithDuration:0.23 animations:^{
        CGRect frame = self.backView.frame;
        frame.origin.y += self.yPosition;
        self.backView.frame = frame;
        [self removeFromSuperview];
    }completion:^(BOOL finished) {
        self.hidden = YES;
        
        //回调
        if(!IsStringEmpty(startTime) &&
           !IsStringEmpty(endTime) &&
           self.callBack) {
            self.callBack(startTime,endTime);
        }
        
    }];
}

/**
 *  显示弹出层
 */
- (void)show {
    self.hidden = NO;
    [UIView animateWithDuration:.23 animations:^{
        CGRect frame = _backView.frame;
        frame.origin.y -= self.yPosition;
        _backView.frame = frame;
    }];
    
}

- (void)showAlert {
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}

/**
 *  计算某年某月有几周
 */
- (NSInteger)weeksOfMonth:(NSInteger)month inYear:(NSInteger)year {
    NSCalendar *cCalendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:month];
    [components setYear:year];
    
    NSRange range = [cCalendar rangeOfUnit:NSCalendarUnitDay
                                    inUnit:NSCalendarUnitMonth
                                   forDate:[cCalendar dateFromComponents:components]];
    
    cCalendar = [NSCalendar currentCalendar];
    [cCalendar setMinimumDaysInFirstWeek:4];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setLocale: [[NSLocale alloc] initWithLocaleIdentifier:@"fr"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSMutableSet *weeks = [[NSMutableSet alloc] init ];
    
    for(int i = 0; i < range.length; i++) {
        NSString *temp = [NSString stringWithFormat:@"%4d-%2d-   %2zd",year,month,range.location+i];
        NSDate *date = [dateFormatter dateFromString:temp ];
        NSInteger week = [[cCalendar components: NSCalendarUnitWeekOfYear fromDate:date] weekOfYear];
        [weeks addObject:[NSNumber numberWithInteger:week]];
    }
    
    return [weeks count];
}

/**
 *  获取某个月的天数
 */
- (NSInteger)getSumOfDaysInMonth:(NSString *)year month:(NSString *)month{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"]; // 年-月
    NSString * dateStr = [NSString stringWithFormat:@"%@-%@",year,month];
    NSDate * date = [formatter dateFromString:dateStr];
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay
                                   inUnit: NSCalendarUnitMonth
                                  forDate:date];
    return range.length;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
