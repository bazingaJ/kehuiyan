//
//  KHYScheduleViewController.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/23.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYScheduleViewController.h"
#import "KHYSegmentedControl.h"
#import "KHYScheduleDayTopView.h"
#import "KHYScheduleWeekTopView.h"
#import "KHYScheduleMonthTopView.h"
#import "KHYTaskCell.h"
#import "KHYTaskDetailViewController.h"

@interface KHYScheduleViewController ()<KHYSegmentedControlDelegate,YJXDayTopViewDelegate>

@property (nonatomic, strong) KHYSegmentedControl *segmentView;
@property (nonatomic, strong) KHYScheduleDayTopView *topDayView;
@property (nonatomic, strong) KHYScheduleWeekTopView *topWeekView;
@property (nonatomic, strong) KHYScheduleMonthTopView *topMonthView;
@property (nonatomic, strong) NSString *dayType;
@property (nonatomic, strong) NSString *beginTime;
@property (nonatomic, strong) NSString *endTime;
@end
static NSString *const type_day = @"1";
static NSString *const type_week = @"2";
static NSString *const type_month = @"3";
@implementation KHYScheduleViewController

/**
 *  切换视图
 */
- (KHYSegmentedControl *)segmentView {
    if(!_segmentView) {
        _segmentView = [[KHYSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45) titleArr:@[@"当日",@"当周",@"当月"]];
        [_segmentView setDelegate:self];
        [self.view addSubview:_segmentView];
    }
    return _segmentView;
}

/**
 *  顶部视图(当日)
 */
- (KHYScheduleDayTopView *)topDayView {
    if(!_topDayView) {
        _topDayView = [[KHYScheduleDayTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55)];
        _topDayView.delegate = self;
    }
    return _topDayView;
}

/**
 *  顶部视图(当周)
 */
- (KHYScheduleWeekTopView *)topWeekView {
    if(!_topWeekView) {
        _topWeekView = [[KHYScheduleWeekTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    }
    return _topWeekView;
}

/**
 *  顶部视图(当月)
 */
- (KHYScheduleMonthTopView *)topMonthView {
    if(!_topMonthView) {
        _topMonthView = [[KHYScheduleMonthTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10+460+100)];
    }
    return _topMonthView;
}

- (void)viewDidLoad {
    [self setTopH:45];
    [super viewDidLoad];
    
    self.title = @"日程管理";
    [self initialized];
    //顶部视图
    [self segmentView];
    
    [self KHYSegmentedControlSegmentClick:0];
    
}
- (void)initialized
{
    NSDate *currentDate = [JXAppTool getCurrentTime];
    self.beginTime = [JXAppTool transformServerFormatStringByAnydate:currentDate];
    self.endTime = [JXAppTool transformServerFormatStringByAnydate:currentDate];
}

- (void)weekTime
{
    // 当前时间
        NSDate *now = [NSDate date];
    // 当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 当前日历组件
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:now];
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
    
    // 在当前日期(去掉了时分秒)基础上加上差的天数
    [comp setDay:day + firstDiff];
    NSDate *firstDayOfWeek= [calendar dateFromComponents:comp];
    
    [comp setDay:day + lastDiff];
    NSDate *lastDayOfWeek= [calendar dateFromComponents:comp];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    
    self.beginTime = [formater stringFromDate:firstDayOfWeek];
    self.endTime = [formater stringFromDate:lastDayOfWeek];
    
//    NSLog(@"一周开始 %@",[formater stringFromDate:firstDayOfWeek]);
    //    NSLog(@"当前 %@",[formater stringFromDate:date]);
//    NSLog(@"一周结束 %@",[formater stringFromDate:lastDayOfWeek]);
}
- (void)getMonthBeginAndEndWith:(NSString *)dateStr
{
    
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM"];
    NSDate *newDate=[format dateFromString:dateStr];
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:newDate];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *beginString = [myDateFormatter stringFromDate:beginDate];
    NSString *endString = [myDateFormatter stringFromDate:endDate];
    self.beginTime = beginString;
    self.endTime = endString;
//    NSString *s = [NSString stringWithFormat:@"%@+%@",beginString,endString];
    
}
/**
 *  切换按钮委托代理
 */
- (void)KHYSegmentedControlSegmentClick:(NSInteger)segmentIndex {
    NSLog(@"切换按钮委托代理：%zd",segmentIndex);
    
    switch (segmentIndex) {
        case 0: {
            //当日
            self.tableView.tableHeaderView = [self topDayView];
            self.dayType = type_day;
            [self initialized];
            [self getDataList:YES];
            break;
        }
        case 1: {
            //当周
            self.tableView.tableHeaderView = [self topWeekView];
            self.dayType = type_week;
            [self weekTime];
            [self getDataList:YES];
            break;
        }
        case 2: {
            //当月
            self.tableView.tableHeaderView = [self topMonthView];
            self.dayType = type_month;
            [self getMonthBeginAndEndWith:[JXAppTool getNowMonthStr]];
            [self getDataList:YES];
            break;
        }
            
        default:
            break;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 145;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"KHYTaskExCell";
    KHYTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[KHYTaskCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    KHYTaskModel *model = self.dataArr[indexPath.section];
//    if(self.dataArr.count) {
//        model = [self.dataArr objectAtIndex:indexPath.section];
//    }
    
    [cell setTaskModel:model];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KHYTaskDetailViewController *vc = [[KHYTaskDetailViewController alloc] init];
    KHYTaskModel *model = self.dataArr[indexPath.section];
    
    vc.task_id = model.task_id;
    
    [self.navigationController pushViewController:vc animated:YES];
}
/**
 *  获取数据
 */
- (void)getDataList:(BOOL)isMore {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"app"] = @"home";
    param[@"act"] = @"getScheduleList";
    param[@"day_type"] = self.dayType;
//    param[@"page"] = @"1";
    param[@"task_time"] = [NSString stringWithFormat:@"%@,%@",self.beginTime,self.endTime];
    [HttpRequestEx postWithURL:SERVICE_URL
                        params:param
                       success:^(id json) {
                           NSString *msg = [json objectForKey:@"msg"];
                           NSString *code = [json objectForKey:@"code"];
                           if([code isEqualToString:SUCCESS]) {
                               NSLog(@"====%@",json);
                               NSDictionary *dataDict = [NSDictionary changeType:[json objectForKey:@"data"]];
                               self.dataArr = [KHYTaskModel mj_objectArrayWithKeyValuesArray:dataDict[@"list"]];
                               [self setDataDictWithDic:dataDict];
                               [self.tableView reloadData];
                               [self endDataRefresh];
                           }else{
                               [MBProgressHUD showError:msg toView:self.view];
                               [self endDataRefresh];
                           }
    }
                       failure:^(NSError *error) {
                           NSLog(@"%@",[error description]);
                           [MBProgressHUD hideHUD:self.view];
                           [self endDataRefresh];
    }];
    
//    for (int i=0; i<10; i++) {
//        KHYTaskModel *model = [KHYTaskModel new];
//        [self.dataArr addObject:model];
//    }
//    [self.tableView reloadData];
    
}
- (void)setDataDictWithDic:(NSDictionary *)dict
{
    if ([self.dayType isEqualToString:@"2"])
    {
        UILabel *lab = (UILabel *)[self.topWeekView.menuView.subviews[0] viewWithTag:20];
        lab.text = dict[@"task_num"];
        UILabel *lab1 = (UILabel *)[self.topWeekView.menuView.subviews[1] viewWithTag:21];
        lab1.text = dict[@"task_finish_num"];
        UILabel *lab2 = (UILabel *)[self.topWeekView.menuView.subviews[2] viewWithTag:22];
        lab2.text = dict[@"task_out_num"];
    }
    else if ([self.dayType isEqualToString:@"3"])
    {
        UILabel *lab = (UILabel *)[self.topMonthView.menuView.subviews[0] viewWithTag:20];
        lab.text = dict[@"task_num"];
        UILabel *lab1 = (UILabel *)[self.topMonthView.menuView.subviews[1] viewWithTag:21];
        lab1.text = dict[@"task_finish_num"];
        UILabel *lab2 = (UILabel *)[self.topMonthView.menuView.subviews[2] viewWithTag:22];
        lab2.text = dict[@"task_out_num"];
    }
    else
    {
        
    }
}
- (void)leftArrowClickGetDateString:(NSDate *)dateStr
{
    self.beginTime = [JXAppTool transformServerFormatStringByAnydate:dateStr];
    self.endTime = [JXAppTool transformServerFormatStringByAnydate:dateStr];
    [self getDataList:YES];
}

- (void)rightArrowClickGetDateString:(NSDate *)dateStr
{
    self.beginTime = [JXAppTool transformServerFormatStringByAnydate:dateStr];
    self.endTime = [JXAppTool transformServerFormatStringByAnydate:dateStr];
    [self getDataList:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
