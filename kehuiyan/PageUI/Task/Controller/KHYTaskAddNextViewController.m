//
//  KHYTaskAddNextViewController.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/23.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYTaskAddNextViewController.h"
#import "KHYOrganizationViewController.h"

@interface KHYTaskAddNextViewController () {
    NSString *numStr;
}

//任务目标
@property (nonatomic, strong) ZTELimitTextView *limitView;
//行动计划
@property (nonatomic, strong) ZTELimitTextView *limitView2;

@end

@implementation KHYTaskAddNextViewController

- (void)viewDidLoad {
    [self setBottomH:45];
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"新建任务";
    
    //任务类型：1日任务 2周任务 3月任务 4季任务 5年任务
    NSInteger taskType = [self.taskModel.task_type integerValue];
    
    //设置数据源
    //备注：标题/描述/是否可编辑/是否有箭头
    [self.dataArr removeAllObjects];
    [self.dataArr addObject:@[@"任务类型",@"请选择任务类型",@"1",@"0"]];
    [self.dataArr addObject:@[@"任务周期",@"请选择任务周期",@"1",@"0"]];
    [self.dataArr addObject:@[@"任务时间",@"请选择任务时间",@"1",@"0"]];
    [self.dataArr addObject:@[@"任务地区",@"请选择任务地区",@"1",@"0"]];
    switch (taskType) {
        case 1: {
            //客户拓展医生
            [self.dataArr addObject:@[@"拓展客户数",@"请输入拓展客户数",@"0",@"0"]];
            
            break;
        }
        case 2: {
            //学术会议开展
            [self.dataArr addObject:@[@"学术会议开展数",@"请输入学术会议开展数",@"0",@"0"]];
            
            break;
        }
        case 3: {
            //患教活动开展
            [self.dataArr addObject:@[@"患教活动开展",@"请输入患教活动开展数",@"0",@"0"]];
            
            break;
        }
        case 4: {
            //销售量
            [self.dataArr addObject:@[@"销量",@"请输入销量",@"0",@"0"]];
            
            break;
        }
            
        default:
            break;
    }
    
    [self.dataArr addObject:@[@"任务责任人",@"请选择任务责任人",@"1",@"1"]];
    [self.dataArr addObject:@[@"任务参与人",@"请选择任务参与人",@"1",@"1"]];
    
    //创建“任务提交”
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-45, SCREEN_WIDTH, 45)];
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
        return self.dataArr.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section==0) {
        return 0.0001;
    }
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0) {
        return 45;
    }
    return 105;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section==0) return [UIView new];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    [backView setBackgroundColor:[UIColor whiteColor]];
    
    //创建“标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, backView.frame.size.width-20, 25)];
    if(section==1) {
        [lbMsg setText:@"任务目标"];
    }else if(section==2) {
        [lbMsg setText:@"任务计划"];
    }
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"KHYTaskAddNextViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    switch (indexPath.section) {
        case 0: {
            //基本信息
            
            NSArray *itemArr = [self.dataArr objectAtIndex:indexPath.row];
            
            //创建“标题”
            UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 120, 25)];
            [lbMsg setText:itemArr[0]];
            [lbMsg setTextColor:COLOR3];
            [lbMsg setTextAlignment:NSTextAlignmentLeft];
            [lbMsg setFont:FONT16];
            [cell.contentView addSubview:lbMsg];
            
            CGFloat rWidth = 30;
            if([itemArr[3] integerValue]==0) {
                rWidth = 10;
            }
            
            //创建“输入框”
            UITextField *tbxContent = [[UITextField alloc] initWithFrame:CGRectMake(140, 10, SCREEN_WIDTH-140-rWidth, 25)];
            [tbxContent setPlaceholder:itemArr[1]];
            [tbxContent setValue:COLOR9 forKeyPath:@"_placeholderLabel.textColor"];
            [tbxContent setValue:FONT15 forKeyPath:@"_placeholderLabel.font"];
            [tbxContent setTextColor:COLOR9];
            [tbxContent setTextAlignment:NSTextAlignmentRight];
            [tbxContent setFont:FONT16];
            [tbxContent setClearButtonMode:UITextFieldViewModeWhileEditing];
            [tbxContent addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            [tbxContent setTag:indexPath.row];
            if([itemArr[2] integerValue]==1) {
                [tbxContent setEnabled:NO];
            }else{
                [tbxContent setEnabled:YES];
                [tbxContent setKeyboardType:UIKeyboardTypeNumberPad];
            }
            [cell.contentView addSubview:tbxContent];
            
            switch (indexPath.row) {
                case 0: {
                    //任务类型
                    [tbxContent setText:self.taskModel.task_type_text];
                    
                    break;
                }
                case 1: {
                    //任务周期
                    [tbxContent setText:self.taskModel.task_cycle_text];
                    
                    break;
                }
                case 2: {
                    //任务时间
                    [tbxContent setText:self.taskModel.task_time];
                    
                    break;
                }
                case 3: {
                    //任务地区
                    [tbxContent setText:self.taskModel.city_name];
                    
                    break;
                }
                case 4: {
                    //拓展医生数
                    [tbxContent setText:numStr];
                    
                    break;
                }
                case 5: {
                    //任务责任人
                    [tbxContent setText:self.taskModel.leader_name];
                    
                    break;
                }
                case 6: {
                    //任务参与人
                    [tbxContent setText:self.taskModel.takeIner_name];
                    
                    break;
                }
                    
                default:
                    break;
            }
            
            //创建“右侧尖头”
            if([itemArr[3] integerValue]==1) {
                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20, 17.5, 5.5, 10)];
                [imgView setImage:[UIImage imageNamed:@"right_icon_gray"]];
                [cell.contentView addSubview:imgView];
            }
            
            //创建“分割线”
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5)];
            [lineView setBackgroundColor:BACK_COLOR];
            [cell.contentView addSubview:lineView];
            
            break;
        }
        case 1: {
            //任务目标
            
            WS(weakSelf);
            self.limitView = [[ZTELimitTextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 105)];
            self.limitView.limitNum = 200;
            if(IsStringEmpty(self.taskModel.task_target)) {
                self.limitView.placeHolder = @"请输入任务目标";
            }else{
                self.limitView.placeHolder = @"";
                self.limitView.textView.text = self.taskModel.task_target;
            }
            self.limitView.textViewDidChange = ^(NSString *content) {
                NSLog(@"当前输入的文本:%@",content);
                
                weakSelf.taskModel.task_target = content;
            };
            [cell.contentView addSubview:self.limitView];
            
            break;
        }
        case 2: {
            //行动计划
            
            WS(weakSelf);
            self.limitView2 = [[ZTELimitTextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 105)];
            self.limitView2.limitNum = 200;
            if(IsStringEmpty(self.taskModel.task_plain)) {
                self.limitView2.placeHolder = @"请输入行动计划";
            }else{
                self.limitView2.placeHolder = @"";
                self.limitView2.textView.text = self.taskModel.task_plain;
            }
            self.limitView2.textViewDidChange = ^(NSString *content) {
                NSLog(@"当前输入的文本:%@",content);
                
                weakSelf.taskModel.task_plain = content;
            };
            [cell.contentView addSubview:self.limitView2];
            
            break;
        }
            
        default:
            break;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UITextField *tbxContent = [cell.contentView viewWithTag:indexPath.row];
    switch (indexPath.row)
    {
        case 5:
        {
            //任务责任人
            KHYOrganizationViewController *vc = [[KHYOrganizationViewController alloc] init];
            vc.isTask = YES;
            NSUserDefaults *us = [NSUserDefaults standardUserDefaults];
            [us setObject:@"leader" forKey:@"isTaskType"];
            [us synchronize];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 6:
        {
            //任务参与人
            KHYOrganizationViewController *vc = [[KHYOrganizationViewController alloc] init];
            vc.isTask = YES;
            NSUserDefaults *us = [NSUserDefaults standardUserDefaults];
            [us setObject:@"takeInner" forKey:@"isTaskType"];
            [us synchronize];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)textFieldDidChange:(UITextField *)textField {
    
    numStr = textField.text;
    
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
    if(IsStringEmpty(self.taskModel.start_date) ||
       IsStringEmpty(self.taskModel.end_date)) {
        [MBProgressHUD showError:@"请选择任务时间" toView:self.view];
        return;
    }
    NSString *timeStr = [NSString stringWithFormat:@"%@,%@",self.taskModel.start_date,self.taskModel.end_date];
    
    //任务地区验证
    if(IsStringEmpty(self.taskModel.province_id) ||
       IsStringEmpty(self.taskModel.city_id) ||
       IsStringEmpty(self.taskModel.area_id)) {
        [MBProgressHUD showError:@"请选择任务地区" toView:self.view];
        return;
    }
    //数量验证
    NSArray *titleArr = [self.dataArr objectAtIndex:4];
    if(IsStringEmpty(numStr)) {
        [MBProgressHUD showError:titleArr[1] toView:self.view];
        return;
    }
    //责任人验证
    if(IsStringEmpty(self.taskModel.leader)) {
        [MBProgressHUD showError:@"请选择责任人" toView:self.view];
        return;
    }
//    //参与人验证
//    if(IsStringEmpty(self.taskModel.takeIner)) {
//        [MBProgressHUD showError:@"请选择参与人" toView:self.view];
//        return;
//    }
    //任务目标
    if(IsStringEmpty(self.taskModel.task_target)) {
        [MBProgressHUD showError:@"请输入任务目标" toView:self.view];
        return;
    }
    //行动计划
    if(IsStringEmpty(self.taskModel.task_plain)) {
        [MBProgressHUD showError:@"请输入行动计划" toView:self.view];
        return;
    }
    
    [MBProgressHUD showMsg:@"任务提交中..." toView:self.view];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"task" forKey:@"app"];
    [param setValue:@"addTask" forKey:@"act"];
    [param setValue:self.taskModel.task_type forKey:@"task_type"];
    [param setValue:self.taskModel.task_cycle forKey:@"task_cycle"];
    [param setValue:timeStr forKey:@"task_time"];
    [param setValue:self.taskModel.province_id forKey:@"province_id"];
    [param setValue:self.taskModel.city_id forKey:@"city_id"];
    [param setValue:self.taskModel.area_id forKey:@"area_id"];
    [param setValue:numStr forKey:@"task_num"];
    [param setValue:self.taskModel.task_target forKey:@"task_target"];//任务目标
    [param setValue:self.taskModel.task_plain forKey:@"task_plain"];//任务计划
    [param setValue:self.taskModel.leader forKey:@"leader"];
    [param setValue:self.taskModel.takeIner forKey:@"takeIner"];
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
                    //返回跟目录
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
}


@end
