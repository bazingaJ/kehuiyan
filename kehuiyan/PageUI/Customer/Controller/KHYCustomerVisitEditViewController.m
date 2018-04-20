//
//  KHYCustomerVisitEditViewController.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/24.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYCustomerVisitEditViewController.h"
#import "MHDatePicker.h"

@interface KHYCustomerVisitEditViewController () {
    NSMutableArray *titleArr;
}

@property (nonatomic, strong) ZTELimitTextView *limitView;

@end

@implementation KHYCustomerVisitEditViewController

- (void)viewDidLoad {
    [self setBottomH:45];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"新增拜访记录";
    
    //初始化对象
    if(!_visitModel) {
        _visitModel = [KHYCustomerVisitModel new];
        _visitModel.doctor_id = self.doctor_id;
        _visitModel.doctor_name = self.doctor_name;
    }
    
    //设置数据源
    titleArr = [NSMutableArray array];
    [titleArr addObject:@[@"拜访客户",@"请选择客户",@"1"]];
    [titleArr addObject:@[@"拜访时间",@"请选择拜访时间",@"1"]];
    [titleArr addObject:@[@"地点",@"请输入拜访地点",@"0"]];
    
    //创建“确定按钮”
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-45, SCREEN_WIDTH, 45)];
    [btnFunc setTitle:@"确定" forState:UIControlStateNormal];
    [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT17];
    [btnFunc setBackgroundColor:GREEN_COLOR];
    [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnFunc];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==0) {
        return [titleArr count];
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
    if(indexPath.section==1) {
        return 115;
    }
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section==0) return [UIView new];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    [backView setBackgroundColor:[UIColor whiteColor]];
    
    //创建“标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 25)];
    [lbMsg setText:@"拜访记录"];
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
    static NSString *cellIndentifier = @"KHYCustomerVisitEditViewControllerCell";
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
            
            //基本信息
            NSArray *itemArr = [titleArr objectAtIndex:indexPath.row];
            
            //创建“标题”
            UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 25)];
            [lbMsg setText:itemArr[0]];
            [lbMsg setTextColor:COLOR3];
            [lbMsg setTextAlignment:NSTextAlignmentLeft];
            [lbMsg setFont:FONT16];
            [lbMsg sizeToFit];
            [lbMsg setCenterY:22.5];
            [cell.contentView addSubview:lbMsg];
            
            CGFloat tWidth = 120;
            if([itemArr[2] integerValue]==1) {
                tWidth = 140;
            }
            //创建“内容”
            UITextField *tbxContent = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, SCREEN_WIDTH-tWidth, 25)];
            [tbxContent setPlaceholder:itemArr[1]];
            [tbxContent setValue:COLOR9 forKeyPath:@"_placeholderLabel.textColor"];
            [tbxContent setValue:FONT15 forKeyPath:@"_placeholderLabel.font"];
            [tbxContent setTextColor:COLOR3];
            [tbxContent setTextAlignment:NSTextAlignmentRight];
            [tbxContent setFont:FONT16];
            [tbxContent setClearButtonMode:UITextFieldViewModeWhileEditing];
            [tbxContent setTag:100+indexPath.row];
            [tbxContent addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            if([itemArr[2] integerValue]==1) {
                [tbxContent setEnabled:NO];
            }
            [cell.contentView addSubview:tbxContent];
            
            switch (indexPath.row) {
                case 0: {
                    //拜访客户
                    [tbxContent setText:_visitModel.doctor_name];
                    
                    break;
                }
                case 1: {
                    //拜访时间
                    [tbxContent setText:_visitModel.visit_date];
                    
                    break;
                }
                case 2: {
                    //地点
                    [tbxContent setText:_visitModel.address];
                    
                    break;
                }
                    
                default:
                    break;
            }
            
            //创建“右侧尖头”
            if([itemArr[2] integerValue]==1) {
                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20, 17.5, 5.5, 10)];
                [imgView setImage:[UIImage imageNamed:@"right_icon_gray"]];
                [cell.contentView addSubview:imgView];
            }
            
            //创建“分割线”
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5)];
            [lineView setBackgroundColor:LINE_COLOR];
            [cell.contentView addSubview:lineView];
            
            break;
        }
        case 1: {
            //拜访记录
            
            self.limitView = [[ZTELimitTextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 115)];
            self.limitView.limitNum = 200;
            if(IsStringEmpty(_visitModel.note)) {
                self.limitView.placeHolder = @"请输入拜访记录";
            }else {
                self.limitView.placeHolder = @"";
                self.limitView.textView.text = _visitModel.note;
            }
            self.limitView.textViewDidChange = ^(NSString *content) {
                NSLog(@"当前内容");
                _visitModel.note = content;
            };
            [cell.contentView addSubview:self.limitView];
            
            break;
        }
            
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UITextField *tbxContent = [cell.contentView viewWithTag:indexPath.row+100];
    
    if(indexPath.row==1) {
        //选择日期
        
        MHDatePicker *selectDatePicker = [[MHDatePicker alloc] init];
        selectDatePicker.isBeforeTime = YES;
        selectDatePicker.datePickerMode = UIDatePickerModeDate;
        [selectDatePicker didFinishSelectedDate:^(NSDate *selectedDate) {
            NSDate * now = [NSDate date];
            if ([selectedDate timeIntervalSince1970] < [now timeIntervalSince1970]) {
                [MBProgressHUD showMessage:@"年月日不能小于或等于当前时间" toView:self.view];
            }else{
                //MM月dd日 HH:mm
                NSString *birthday = [NSString dateStringWithDate:selectedDate DateFormat:@"yyyy-MM-dd"];
                [tbxContent setText:birthday];
                
                _visitModel.visit_date = birthday;
            }
        }];
        
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)textFieldDidChange:(UITextField *)textField {
    
    if(textField.tag==102) {
        _visitModel.address = textField.text;
    }
    
}

/**
 *  确定按钮事件
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"确定");
    [self.view endEditing:YES];
    
    //医生ID验证
    if(!self.isEdit && IsStringEmpty(_visitModel.doctor_id)) {
        [MBProgressHUD showError:@"客户ID不能为空" toView:self.view];
        return;
    }
    //拜访时间验证
    if(IsStringEmpty(_visitModel.visit_date)) {
        [MBProgressHUD showError:@"请选择拜访时间" toView:self.view];
        return;
    }
    //地点验证
    if(IsStringEmpty(_visitModel.address)) {
        [MBProgressHUD showError:@"请输入地点" toView:self.view];
        return;
    }
    //拜访记录验证
    if(IsStringEmpty(_visitModel.note)) {
        [MBProgressHUD showError:@"请输入拜访记录" toView:self.view];
        return;
    }
    
    [MBProgressHUD showMsg:@"数据提交中..." toView:self.view];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"customer" forKey:@"app"];
    [param setValue:@"addVisit" forKey:@"act"];
    [param setValue:_visitModel.visit_id forKey:@"visit_id"];
    [param setValue:_visitModel.doctor_id forKey:@"doctor_id"];
    [param setValue:_visitModel.visit_date forKey:@"visit_date"];
    [param setValue:_visitModel.address forKey:@"address"];
    [param setValue:_visitModel.note forKey:@"note"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        [MBProgressHUD hideHUD:self.view];
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            [MBProgressHUD showSuccess:@"提交成功" toView:self.view];
            
            NSDictionary *dataDic = [json objectForKey:@"data"];
            KHYCustomerVisitModel *model = [KHYCustomerVisitModel mj_objectWithKeyValues:dataDic];
            //延迟0.5秒返回
            kDISPATCH_MAIN_AFTER(0.5, ^{
                
                [self.navigationController popViewControllerAnimated:YES];
                if(self.callBack) {
                    self.callBack(model);
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

/**
 *  获取数据
 */
- (void)getDataList:(BOOL)isMore {
    [self endDataRefresh];
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
