//
//  KHYTaskAddDayViewController.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/10.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYTaskAddDayViewController.h"
#import "KHYHospitalSelectedViewController.h"
#import "KHYSubjectKeshiSelectedViewController.h"
#import "KHYDoctorSelectedViewController.h"
#import "KHYOrganizationViewController.h"
#import "KHYSubjectSelectedViewController.h"
#import "KHYHospitalSheetView.h"

@interface KHYTaskAddDayViewController ()

@property (nonatomic, strong) ZTELimitTextView *limitView;

@property (nonatomic, strong) NSArray *hospitalLevelArr;

@end

@implementation KHYTaskAddDayViewController

- (void)viewDidLoad {
    [self setHiddenHeaderRefresh:YES];
    [self setBottomH:45];
    [super viewDidLoad];
    self.title = @"新建日任务";
    
    //设置数据源
    [self.dataArr removeAllObjects];
    [self.dataArr addObject:@[@"任务类型",@"0"]];
    [self.dataArr addObject:@[@"任务周期",@"0"]];
    [self.dataArr addObject:@[@"任务时间",@"0"]];
    [self.dataArr addObject:@[@"任务地区",@"0"]];
    [self.dataArr addObject:@[@"医院级别",@"1"]];
    [self.dataArr addObject:@[@"医院",@"1"]];
    [self.dataArr addObject:@[@"学科",@"1"]];
    [self.dataArr addObject:@[@"科室",@"1"]];
    [self.dataArr addObject:@[@"客户",@"1"]];
    [self.dataArr addObject:@[@"任务责任人",@"1"]];
    [self.dataArr addObject:@[@"任务参与人",@"1"]];
    
    //创建“任务提交”按钮
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-45, SCREEN_WIDTH,45)];
    [btnFunc setTitle:@"任务提交" forState:UIControlStateNormal];
    [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT17];
    [btnFunc setBackgroundColor:GREEN_COLOR];
    [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnFunc];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(choiceLeader:) name:@"choiceLeader" object:nil];
    
}


- (void)leftButtonItemClick
{
    [super leftButtonItemClick];
    self.taskModel.hospitalLevel_id = @"";
    self.taskModel.hospitalLevel_name = @"";
    self.taskModel.hospital_id = @"";
    self.taskModel.hospital_name = @"";
    self.taskModel.subject_id = @"";
    self.taskModel.subject_name = @"";
    self.taskModel.keshi_id = @"";
    self.taskModel.keshi_name = @"";
    self.taskModel.doctor_id = @"";
    self.taskModel.doctor_name = @"";
    self.taskModel.leader = @"";
    self.taskModel.leader_name = @"";
    self.taskModel.takeIner = @"";
    self.taskModel.takeIner_name = @"";
    self.taskModel.task_matter = @"";
    NSUserDefaults *us = [NSUserDefaults standardUserDefaults];
    [us setObject:@"" forKey:@"part_user_id"];
    [us setObject:@"" forKey:@"part_user_name"];
    [us synchronize];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSUserDefaults *us = [NSUserDefaults standardUserDefaults];
    NSString *ids = [us objectForKey:@"part_user_id"];
    NSString *name = [us objectForKey:@"part_user_name"];
    if (![ids isEqualToString:@""])
    {
        self.taskModel.takeIner = ids;
        self.taskModel.takeIner_name = name;
    }
    self.taskModel.leader = [HelperManager CreateInstance].user_id;
    self.taskModel.leader_name = [HelperManager CreateInstance].realname;
    [self.tableView reloadData];
    // 请求医院级别数据
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setObject:@"task" forKey:@"app"];
        [param setObject:@"getHospitalLevel" forKey:@"act"];
        [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
            NSString *code = [json objectForKey:@"code"];
            NSString *msg = [json objectForKey:@"msg"];
            if ([code isEqualToString:SUCCESS])
            {
                self.hospitalLevelArr = [json objectForKey:@"data"];
                
            }
            else
            {
                [MBProgressHUD showMessage:msg toView:self.view];
            }
        } failure:^(NSError *error) {
            
        }];
    }];
    [operation start];
}
- (void)choiceLeader:(NSNotification *)noti
{
    NSDictionary *dataDic = noti.userInfo;
    self.taskModel.leader = dataDic[@"leader_user_id"];
    self.taskModel.leader_name = dataDic[@"leader_user_name"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [self.tableView reloadData];
    });
   
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==0) {
        return [self.dataArr count];
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 1 || section == 2)
    {
        return 45;
    }
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==1 || indexPath.section==2)
    {
        return 105;
    }
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section==0)
    {
        return [UIView new];
    }
    else if (section == 1)
    {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        [backView setBackgroundColor:[UIColor whiteColor]];
        
        //创建“标题”
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, backView.frame.size.width-20, 25)];
        [lbMsg setText:@"任务目标"];
        [lbMsg setTextColor:COLOR3];
        [lbMsg setTextAlignment:NSTextAlignmentLeft];
        [lbMsg setFont:FONT16];
        [backView addSubview:lbMsg];
        
        //创建“分割线”
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5)];
        [lineView setBackgroundColor:LINE_COLOR];
        [backView addSubview:lineView];
        
        return backView;
    }
    else
    {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        [backView setBackgroundColor:[UIColor whiteColor]];
        
        //创建“标题”
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, backView.frame.size.width-20, 25)];
        [lbMsg setText:@"任务计划"];
        [lbMsg setTextColor:COLOR3];
        [lbMsg setTextAlignment:NSTextAlignmentLeft];
        [lbMsg setFont:FONT16];
        [backView addSubview:lbMsg];
        
        //创建“分割线”
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5)];
        [lineView setBackgroundColor:LINE_COLOR];
        [backView addSubview:lineView];
        
        return backView;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"KHYTaskAddDayViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    if(indexPath.section==0) {
        
        NSArray *itemArr = [self.dataArr objectAtIndex:indexPath.row];
        
        //创建“标题”
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 25)];
        [lbMsg setText:itemArr[0]];
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
                [lbMsg2 setText:self.taskModel.task_type_text];
                break;
            }
            case 1: {
                //任务周期
                [lbMsg2 setText:self.taskModel.task_cycle_text];
                break;
            }
            case 2: {
                //任务时间
                [lbMsg2 setText:self.taskModel.task_time];
                break;
            }
            case 3: {
                //任务地区
                [lbMsg2 setText:self.taskModel.city_name];
                break;
            }
            case 4: {
                //医院级别
                [lbMsg2 setText:self.taskModel.hospitalLevel_name];
                break;
            }
            case 5: {
                //医院
                [lbMsg2 setText:self.taskModel.hospital_name];
                break;
            }
            case 6: {
                //学科
                [lbMsg2 setText:self.taskModel.subject_name];
                break;
            }
            case 7: {
                //科室
                [lbMsg2 setText:self.taskModel.keshi_name];
                break;
            }
            case 8: {
                //医生
                [lbMsg2 setText:self.taskModel.doctor_name];
                break;
            }
            case 9: {
                //任务责任人
                [lbMsg2 setText:self.taskModel.leader_name];
                break;
            }
            case 10: {
                //任务参与人
                [lbMsg2 setText:self.taskModel.takeIner_name];
                break;
            }
                
            default:
                break;
        }
        
        //创建“右侧尖头”
        if([itemArr[1] integerValue]==1) {
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20, 17.5, 5.5, 10)];
            [imgView setImage:[UIImage imageNamed:@"right_icon_gray"]];
            [cell.contentView addSubview:imgView];
        }
        
        //创建“分割线”
        if(indexPath.row<[self.dataArr count]-1) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5)];
            [lineView setBackgroundColor:LINE_COLOR];
            [cell.contentView addSubview:lineView];
        }
        
    }
    else if (indexPath.section == 1)
    {
        
        //创建“任务目标框”
        self.limitView = [[ZTELimitTextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 105)];
        self.limitView.limitNum = 200;
        if(IsStringEmpty(self.taskModel.task_target)) {
            self.limitView.placeHolder = @"请输入任务目标";
        }else{
            self.limitView.placeHolder = @"";
            self.limitView.textView.text = self.taskModel.task_target;
        }
        WS(weakSelf)
        self.limitView.textViewDidChange = ^(NSString *content) {
            NSLog(@"当前输入的文本:%@",content);
            
            weakSelf.taskModel.task_target = content;
        };
        [cell.contentView addSubview:self.limitView];
        
    }
    else
    {
        //创建“任务计划框”
        self.limitView = [[ZTELimitTextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 105)];
        self.limitView.limitNum = 200;
        if(IsStringEmpty(self.taskModel.task_plain)) {
            self.limitView.placeHolder = @"请输入行动计划";
        }else{
            self.limitView.placeHolder = @"";
            self.limitView.textView.text = self.taskModel.task_plain;
        }
        WS(weakSelf)
        self.limitView.textViewDidChange = ^(NSString *content) {
            NSLog(@"当前输入的文本:%@",content);
            
            weakSelf.taskModel.task_plain = content;
        };
        [cell.contentView addSubview:self.limitView];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UILabel *lbMsg = [cell.contentView viewWithTag:indexPath.row+100];
    
    switch (indexPath.row) {
        case 4: {
            
            //医院级别
            CGRect rect  = CGRectZero;
            KHYHospitalSheetView *sheetView = [[KHYHospitalSheetView alloc] initWithFrame:rect withDataArr:[NSMutableArray arrayWithArray:self.hospitalLevelArr]];
            sheetView.hospitalLevelCallBack = ^(NSString *levelID, NSString *levelStr) {
                NSLog(@"医院级别：%@-%@",levelID,levelStr);
                [lbMsg setText:levelStr];
                //医院级别
                self.taskModel.hospitalLevel_id = levelID;
                self.taskModel.hospitalLevel_name = levelStr;
            };
            [sheetView show];
            
            break;
        }
        case 5: {
            
            //医院
            
            if(IsStringEmpty(self.taskModel.area_id)) {
                [MBProgressHUD showError:@"请选择城市" toView:self.view];
                return;
            }
            kDISPATCH_MAIN_THREAD(^{
                
                KHYHospitalSelectedViewController *hospitalView = [[KHYHospitalSelectedViewController alloc] init];
                hospitalView.city_id = self.taskModel.city_id;
                hospitalView.area_id = self.taskModel.area_id;
                hospitalView.hospitalLevel_id = self.taskModel.hospitalLevel_id;
                hospitalView.callBack = ^(NSString *hospital_id, NSString *hospital_name) {
                    NSLog(@"医院ID：%@-医院名称：%@",hospital_id,hospital_name);
                    [lbMsg setText:hospital_name];
                    
                    self.taskModel.hospital_id = hospital_id;
                    self.taskModel.hospital_name = hospital_name;
                    
                    self.taskModel.doctor_id = @"";
                    self.taskModel.doctor_name = @"";
                    [self.tableView reloadData];
                };
                UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:hospitalView];
                [self.navigationController presentViewController:navC animated:YES completion:nil];
                
            });
            break;
        }
        case 6: {
            //学科
            
            //            NSString *hospitalId = self.taskModel.hospital_id;
            //            if(IsStringEmpty(hospitalId)) {
            //                [MBProgressHUD showError:@"请选择医院" toView:self.view];
            //                return;
            //            }
            
            kDISPATCH_MAIN_THREAD(^{
                
                KHYSubjectSelectedViewController *keshiView = [[KHYSubjectSelectedViewController alloc] init];
                keshiView.title = @"选择学科";
                //                keshiView.hospital_id = hospitalId;
                keshiView.callBack = ^(NSString *keshi_id, NSString *keshi_name,NSArray *keshiArr) {
                    NSLog(@"学科ID：%@-学科名称：%@",keshi_id,keshi_name);
                    [lbMsg setText:keshi_name];
                    
                    self.taskModel.subject_id = keshi_id;
                    self.taskModel.subject_name = keshi_name;
                    
                    self.taskModel.doctor_id = @"";
                    self.taskModel.doctor_name = @"";
                    [self.tableView reloadData];
                    
                };
                UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:keshiView];
                [self.navigationController presentViewController:navC animated:YES completion:nil];
                
            });
            
            break;
        }
        case 7: {
            // 科室
            //            NSString *hospitalId = self.taskModel.hospital_id;
            //            if(IsStringEmpty(hospitalId)) {
            //                [MBProgressHUD showError:@"请选择医院" toView:self.view];
            //                return;
            //            }
            
            kDISPATCH_MAIN_THREAD(^{
                
                KHYSubjectKeshiSelectedViewController *keshiView = [[KHYSubjectKeshiSelectedViewController alloc] init];
                keshiView.title = @"选择科室";
                //                keshiView.hospital_id = hospitalId;
                keshiView.callBack = ^(NSString *keshi_id, NSString *keshi_name) {
                    NSLog(@"科室ID：%@-科室名称：%@",keshi_id,keshi_name);
                    [lbMsg setText:keshi_name];
                    
                    self.taskModel.keshi_id = keshi_id;
                    self.taskModel.keshi_name = keshi_name;
                    
                    self.taskModel.doctor_id = @"";
                    self.taskModel.doctor_name = @"";
                    [self.tableView reloadData];
                    
                };
                UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:keshiView];
                [self.navigationController presentViewController:navC animated:YES completion:nil];
                
            });
            break;
        }
        case 8: {
            //医生
            
            NSString *hospitalId = self.taskModel.hospital_id;
            if(IsStringEmpty(hospitalId)) {
                [MBProgressHUD showError:@"请选择医院" toView:self.view];
                return;
            }
            NSString *keshiId = self.taskModel.keshi_id;
            if(IsStringEmpty(keshiId)) {
                [MBProgressHUD showError:@"请选择科室" toView:self.view];
                return;
            }
            NSString *subjectId = self.taskModel.subject_id;
            if(IsStringEmpty(subjectId)) {
                [MBProgressHUD showError:@"请选择学科" toView:self.view];
                return;
            }
            
            kDISPATCH_MAIN_THREAD(^{
                
                KHYDoctorSelectedViewController *doctorView = [[KHYDoctorSelectedViewController alloc] init];
                doctorView.title = @"选择客户";
                doctorView.hospital_id = hospitalId;
                doctorView.keshi_id = keshiId;
                doctorView.subject_id = subjectId;
                doctorView.callBack = ^(NSString *doctot_id, NSString *doctot_name) {
                    NSLog(@"医生ID:%@-医生名称:%@",doctot_id,doctot_name);
                    [lbMsg setText:doctot_name];
                    
                    self.taskModel.doctor_id = doctot_id;
                    self.taskModel.doctor_name = doctot_name;
                    
                };
                UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:doctorView];
                [self.navigationController presentViewController:navC animated:YES completion:nil];
                
            });
            break;
        }
        case 9: {
            //任务责任人
            KHYOrganizationViewController *vc = [[KHYOrganizationViewController alloc] init];
            vc.isTask = YES;
            NSUserDefaults *us = [NSUserDefaults standardUserDefaults];
            [us setObject:@"leader" forKey:@"isTaskType"];
            [us synchronize];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 10: {
            //任务参与人
            KHYOrganizationViewController *vc = [[KHYOrganizationViewController alloc] init];
            vc.isTask = YES;
            NSUserDefaults *us = [NSUserDefaults standardUserDefaults];
            [us setObject:@"takeInner" forKey:@"isTaskType"];
            [us synchronize];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        default:
            break;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

/**
 *  任务提交按钮事件
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"任务提交");
    [self.view endEditing:YES];
    
    //任务类型验证
    if(IsStringEmpty(self.taskModel.task_type)) {
        [MBProgressHUD showError:@"请选择任务类型" toView:self.view];
        return;
    }
    //任务周期验证
    if(IsStringEmpty(self.taskModel.task_cycle)) {
        [MBProgressHUD showError:@"请选择任务周期" toView:self.view];
        return;
    }
    //任务时间验证
    if(IsStringEmpty(self.taskModel.task_time)) {
        [MBProgressHUD showError:@"请选择任务时间" toView:self.view];
        return;
    }
    //任务地区验证
    if(IsStringEmpty(self.taskModel.province_id) ||
       IsStringEmpty(self.taskModel.city_id) ||
       IsStringEmpty(self.taskModel.area_id)) {
        [MBProgressHUD showError:@"请选择任务地区" toView:self.view];
        return;
    }
    //医院验证
    if(IsStringEmpty(self.taskModel.hospital_id)) {
        [MBProgressHUD showError:@"请选择医院" toView:self.view];
        return;
    }
    //学科验证
    if(IsStringEmpty(self.taskModel.keshi_id)) {
        [MBProgressHUD showError:@"请选择学科" toView:self.view];
        return;
    }
    //医生验证
    if(IsStringEmpty(self.taskModel.doctor_id)) {
        [MBProgressHUD showError:@"请选择客户" toView:self.view];
        return;
    }
    //责任人验证
    if(IsStringEmpty(self.taskModel.leader)) {
        [MBProgressHUD showError:@"请选择责任人" toView:self.view];
        return;
    }
    //参与人验证
//    if(IsStringEmpty(self.taskModel.takeIner)) {
//        [MBProgressHUD showError:@"请选择参与人" toView:self.view];
//        return;
//    }
//    //任务事项
//    if(IsStringEmpty(self.taskModel.task_matter)) {
//        [MBProgressHUD showError:@"请输入任务事项" toView:self.view];
//        return;
//    }
    // 任务目标
    if(IsStringEmpty(self.taskModel.task_target)) {
        [MBProgressHUD showError:@"请输入任务目标" toView:self.view];
        return;
    }
    // 任务计划
    if(IsStringEmpty(self.taskModel.task_plain)) {
        [MBProgressHUD showError:@"请输入任务计划" toView:self.view];
        return;
    }
    
    [MBProgressHUD showMsg:@"任务提交中..." toView:self.view];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"task" forKey:@"app"];
    [param setValue:@"addDayTask" forKey:@"act"];
    [param setValue:self.taskModel.task_type forKey:@"task_type"];
    [param setValue:self.taskModel.task_cycle forKey:@"task_cycle"];
    [param setValue:self.taskModel.task_time forKey:@"task_time"];
    [param setValue:self.taskModel.province_id forKey:@"province_id"];
    [param setValue:self.taskModel.city_id forKey:@"city_id"];
    [param setValue:self.taskModel.area_id forKey:@"area_id"];
    [param setValue:self.taskModel.hospital_id forKey:@"hospital_id"];
    [param setValue:self.taskModel.subject_id forKey:@"subject_id"];
    [param setValue:self.taskModel.keshi_id forKey:@"keshi_id"];
    [param setValue:self.taskModel.doctor_id forKey:@"doctor_id"];
    [param setValue:self.taskModel.leader forKey:@"leader"];
    [param setValue:self.taskModel.takeIner forKey:@"takeIner"];
    [param setValue:self.taskModel.task_target forKey:@"task_target"];
    [param setValue:self.taskModel.task_plain forKey:@"task_plain"];
    
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        [MBProgressHUD hideHUD:self.view];
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            [MBProgressHUD showSuccess:@"任务提交成功" toView:self.view];
            NSUserDefaults *us = [NSUserDefaults standardUserDefaults];
            [us setObject:@"" forKey:@"part_user_id"];
            [us setObject:@"" forKey:@"part_user_name"];
            [us synchronize];
            //延迟0.5秒返回
            kDISPATCH_MAIN_AFTER(0.5, ^{
            
                //返回任务列表页面
                BOOL isYes = NO;
                for (UIViewController *controller in self.navigationController.viewControllers) {
                    //跳转至我的考级科目界面
                    if ([controller isKindOfClass:NSClassFromString(@"KHYTaskViewController")]) {
                        [self.navigationController popToViewController:controller animated:YES];
                        isYes = YES;
                        break;
                    }
                }
                if(!isYes) {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
                
            });
            
        }else{
            [MBProgressHUD showError:msg toView:self.view];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        [MBProgressHUD hideHUD:self.view];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
