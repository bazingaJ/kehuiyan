//
//  KHYTaskAddViewController.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/10.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYTaskAddViewController.h"
#import "KHYTaskAddDayViewController.h"
#import "KHYTaskTypeSheetView.h"
#import "AddressPickView.h"
#import "KHYTaskCycleSheetView.h"
#import "KHYDatePickerView.h"
#import "KHYDatePickerWeekView.h"
#import "KHYDatePickerMonthView.h"
#import "KHYDatePickerQuarterlyView.h"
#import "KHYDatePickerYearView.h"
#import "KHYTaskAddNextViewController.h"
#import "KHYTaskModel.h"
#import "KHYCityPickerView.h"

@interface KHYTaskAddViewController ()<JXAreaViewDelegate>
{
    //任务模型
    KHYTaskModel *taskModel;
}
@property (nonatomic, strong) KHYCityPickerView *picker;
@property (nonatomic, strong) NSArray *cityArr;
@end

@implementation KHYTaskAddViewController

- (void)viewDidLoad {
    [self setHiddenHeaderRefresh:YES];
    [self setBottomH:45];
    [super viewDidLoad];
    
    self.title = @"新建任务";
    
    //初始化
    taskModel = [KHYTaskModel new];
    
    //设置数据源
    [self.dataArr removeAllObjects];
    [self.dataArr addObject:@[@"任务类型"]];
    [self.dataArr addObject:@[@"任务周期"]];
    [self.dataArr addObject:@[@"任务时间"]];
    [self.dataArr addObject:@[@"任务地区"]];
    
    //创建“下一步”按钮
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-45, SCREEN_WIDTH,45)];
    [btnFunc setTitle:@"下一步" forState:UIControlStateNormal];
    [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT17];
    [btnFunc setBackgroundColor:GREEN_COLOR];
    [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnFunc];
    [self initialized];
    
    
}

- (void)initialized
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:@"default" forKey:@"app"];
    [param setObject:@"getCityList" forKey:@"act"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        NSString *msg= [json objectForKey:@"msg"];
        if ([code isEqualToString:SUCCESS])
        {
            self.cityArr = [json objectForKey:@"data"];
            if (self.cityArr.count == 0)
            {
                return ;
            }
            [self picker];
        }
        else
        {
            [MBProgressHUD showMsg:msg toView:self.view];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"KHYTaskAddViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    NSArray *titleArr = [self.dataArr objectAtIndex:indexPath.row];
    
    //创建“标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 25)];
    [lbMsg setText:titleArr[0]];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT16];
    [cell.contentView addSubview:lbMsg];
    
    //创建“内容”
    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, SCREEN_WIDTH-130, 25)];
    [lbMsg2 setTextColor:COLOR9];
    [lbMsg2 setTextAlignment:NSTextAlignmentRight];
    [lbMsg2 setFont:FONT16];
    [lbMsg2 setTag:100+indexPath.row];
    [cell.contentView addSubview:lbMsg2];
    
    switch (indexPath.row) {
        case 0: {
            //任务类型
            [lbMsg2 setText:taskModel.task_type_text];
            
            break;
        }
        case 1: {
            //任务周期
            [lbMsg2 setText:taskModel.task_cycle_text];
            
            break;
        }
        case 2: {
            //任务时间
            [lbMsg2 setText:taskModel.task_time];
            
            break;
        }
        case 3: {
            //任务地区
            [lbMsg2 setText:taskModel.city_name];
            
            break;
        }
            
        default:
            break;
    }
    
    //创建“右侧尖头”
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20, 17.5, 5.5, 10)];
    [imgView setImage:[UIImage imageNamed:@"right_icon_gray"]];
    [cell.contentView addSubview:imgView];
    
    //创建“分割线”
    if(indexPath.row<[self.dataArr count]-1) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5)];
        [lineView setBackgroundColor:LINE_COLOR];
        [cell.contentView addSubview:lineView];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UILabel *lbMsg = [cell.contentView viewWithTag:100+indexPath.row];
    
    switch (indexPath.row) {
        case 0: {
            //任务类型
            KHYTaskTypeSheetView *sheetView = [[KHYTaskTypeSheetView alloc] init];
            sheetView.callBack = ^(NSString *type_id, NSString *type_name) {
                NSLog(@"任务类型：%@-%@",type_id,type_name);
                
                [lbMsg setText:type_name];
                
                //任务类型
                taskModel.task_type = type_id;
                taskModel.task_type_text = type_name;
                
            };
            [sheetView show];
            
            break;
        }
        case 1: {
            //任务周期
            KHYTaskCycleSheetView *sheetView = [[KHYTaskCycleSheetView alloc] init];
            sheetView.callBack = ^(NSString *cycle_id, NSString *cycle_name) {
                NSLog(@"任务周期：%@-%@",cycle_id,cycle_name);
                
                [lbMsg setText:cycle_name];
                
                //任务周期
                taskModel.task_cycle = cycle_id;
                taskModel.task_cycle_text = cycle_name;
                
                //清除任务时间
                taskModel.task_time = @"";
                taskModel.start_date = @"";
                taskModel.end_date = @"";
                
                NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:2 inSection:0];
                UITableViewCell *cell2 = [tableView cellForRowAtIndexPath:indexPath2];
                UILabel *lbMsg2 = [cell2.contentView viewWithTag:100+indexPath2.row];
                [lbMsg2 setText:@""];
            };
            [sheetView show];
            
            break;
        }
        case 2: {
            //任务时间
            
            switch ([taskModel.task_cycle integerValue]) {
                case 1: {
                    //日任务
                    KHYDatePickerView *pickerView = [[KHYDatePickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 320)];
                    pickerView.callBack = ^(NSString *dateStr) {
                        NSLog(@"时间：%@",dateStr);
                        
                        //任务时间
                        taskModel.task_time = dateStr;
                        taskModel.start_date = dateStr;
                        taskModel.end_date = dateStr;
                        
                        [lbMsg setText:dateStr];
                        
                    };
                    [pickerView show];
                    
                    break;
                }
                case 2: {
                    //周任务
                    KHYDatePickerWeekView *pickerView = [[KHYDatePickerWeekView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 320)];
                    pickerView.callBack = ^(NSString *startTime, NSString *endTime) {
                        NSLog(@"开始时间:%@,结束时间:%@",startTime,endTime);
                        
                        //任务时间
                        taskModel.task_time = [NSString stringWithFormat:@"%@至%@",startTime,endTime];
                        taskModel.start_date = startTime;
                        taskModel.end_date = endTime;
                        
                        [lbMsg setText:taskModel.task_time];
                        
                    };
                    [pickerView show];
                    
                    break;
                }
                case 3: {
                    //月任务
                    KHYDatePickerMonthView *pickerView = [[KHYDatePickerMonthView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 320)];
                    pickerView.callBack = ^(NSString *startTime, NSString *endTime) {
                        NSLog(@"开始时间:%@-结束时间:%@",startTime,endTime);
                        
                        //任务时间
                        taskModel.task_time = [NSString stringWithFormat:@"%@至%@",startTime,endTime];
                        taskModel.start_date = startTime;
                        taskModel.end_date = endTime;
                        
                        [lbMsg setText:taskModel.task_time];
                        
                    };
                    [pickerView show];
                    
                    break;
                }
                case 4: {
                    //季任务
                    
                    KHYDatePickerQuarterlyView *pickerView = [[KHYDatePickerQuarterlyView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 320)];
                    pickerView.callBack = ^(NSString *startTime, NSString *endTime) {
                        NSLog(@"开始时间:%@-结束时间:%@",startTime,endTime);
                        
                        //任务时间
                        taskModel.task_time = [NSString stringWithFormat:@"%@至%@",startTime,endTime];
                        taskModel.start_date = startTime;
                        taskModel.end_date = endTime;
                        
                        [lbMsg setText:taskModel.task_time];
                        
                    };
                    [pickerView show];
                    
                    break;
                }
                case 5: {
                    //年任务
                    KHYDatePickerYearView *pickerView = [[KHYDatePickerYearView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 320)];
                    pickerView.callBack = ^(NSString *startTime, NSString *endTime) {
                        NSLog(@"开始时间：%@,结束时间:%@",startTime,endTime);
                        
                        //任务时间
                        taskModel.task_time = [NSString stringWithFormat:@"%@至%@",startTime,endTime];
                        taskModel.start_date = startTime;
                        taskModel.end_date = endTime;
                        
                        [lbMsg setText:taskModel.task_time];
                    };
                    [pickerView show];
                    
                    break;
                }
                    
                default:
                    break;
            }
            
            break;
        }
        case 3: {
            //任务地区
            
            if (self.cityArr.count == 0)
            {
                [MBProgressHUD showError:@"您暂无负责区域" toView:self.view];
                return;
            }
            [UIView animateWithDuration:0.03 animations:^{
                self.picker.transform = CGAffineTransformMakeTranslation(0, -SCREEN_HEIGHT);
            }];
//            AddressPickView *addressPickView = [AddressPickView CreateInstance];
//            [self.view addSubview:addressPickView];
//            addressPickView.block = ^(NSString *cityIds,NSString *nameStr){
//                NSLog(@"%@ %@",cityIds,nameStr);
//                //省市区名称
//                [lbMsg setText:nameStr];
//
//                //值存储
//                NSArray *itemArr = [cityIds componentsSeparatedByString:@","];
//                taskModel.province_id = itemArr[0];
//                taskModel.city_id = itemArr[1];
//                taskModel.area_id = itemArr[2];
//                taskModel.city_name = nameStr;
//
//            };
            
            
            
            
            break;
        }
            
        default:
            break;
    }
}

/**
 *   下一步按钮事件
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"下一步");
    
    //任务类型
    if(IsStringEmpty(taskModel.task_type)) {
        [MBProgressHUD showError:@"请选择任务类型" toView:self.view];
        return;
    }
    //任务周期
    if(IsStringEmpty(taskModel.task_cycle)) {
        [MBProgressHUD showError:@"请选择任务周期" toView:self.view];
        return;
    }
    //任务时间
    if(IsStringEmpty(taskModel.task_time)) {
        [MBProgressHUD showError:@"任务时间" toView:self.view];
        return;
    }
    //任务地区
    if(IsStringEmpty(taskModel.province_id) ||
       IsStringEmpty(taskModel.city_id) ||
       IsStringEmpty(taskModel.area_id)) {
        [MBProgressHUD showError:@"请选择任务地区" toView:self.view];
        return;
    }
    
    if([taskModel.task_cycle isEqualToString:@"1"]) {
        //日任务
        KHYTaskAddDayViewController *taskView = [[KHYTaskAddDayViewController alloc] init];
        taskView.taskModel = taskModel;
        [self.navigationController pushViewController:taskView animated:YES];
    }else{
        
        KHYTaskAddNextViewController *taskView = [[KHYTaskAddNextViewController alloc] init];
        taskView.taskModel = taskModel;
        [self.navigationController pushViewController:taskView animated:YES];
    }
}

- (void)viewTouch
{
    [UIView animateWithDuration:0.03 animations:^{
        self.picker.transform = CGAffineTransformIdentity;
    }];
}

- (void)leftBtnClick
{
    [self viewTouch];
}

- (void)rightBtnClickWithIDs:(NSArray *)ids Strings:(NSArray *)strs
{
    [self viewTouch];
    NSString *str = [NSString stringWithFormat:@"%@ %@ %@",strs[0],strs[1],strs[2]];
    taskModel.province_id = ids[0];
    taskModel.city_id = ids[1];
    taskModel.area_id = ids[2];
    taskModel.city_name = str;
    [self.tableView reloadData];
    
}

// 地区选择器
- (KHYCityPickerView *)picker
{
    if (!_picker)
    {
        _picker = [[KHYCityPickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT) withDataArr:self.cityArr];
        _picker.delegate = self;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTouch)];
        [_picker addGestureRecognizer:tap];
        
        [self.view addSubview:_picker];
    }
    return _picker;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
