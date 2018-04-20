//
//  KHYCustomerEditViewController.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/23.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYCustomerEditViewController.h"
#import "KHYHospitalSelectedViewController.h"
#import "KHYSubjectKeshiSelectedViewController.h"
#import "KHYPositionSelectedViewController.h"
#import "AddressPickView.h"
#import "MHDatePicker.h"
#import "KHYSubjectSelectedViewController.h"
#import "KHYSubjectKeshiSelectedViewController.h"
#import "KHYHospitalSheetView.h"
#import "KHYCityPickerView.h"

@interface KHYCustomerEditViewController ()<JXAreaViewDelegate> {
    NSMutableArray *titleArr;
}

@property (nonatomic, strong) NSMutableArray *keshiArr;
@property (nonatomic, strong) ZTELimitTextView *limitView;
@property (nonatomic, strong) ZTELimitTextView *limitView2;
@property (nonatomic, strong) NSArray *hospitalLevelArr;

// yjx 客户选择区域从服务端获取

@property (nonatomic, strong) KHYCityPickerView *picker;
// 城市区域数据源
@property (nonatomic, strong) NSArray *cityArr;

@end

@implementation KHYCustomerEditViewController

/**
 *  二级科室数组
 */
- (NSMutableArray *)keshiArr {
    if(!_keshiArr) {
        _keshiArr = [NSMutableArray array];
    }
    return _keshiArr;
}

- (void)viewDidLoad {
    [self setBottomH:45];
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //初始化模型
    if(!_customerModel) {
        _customerModel = [KHYCustomerModel new];
        _customerModel.gender = @"1";//性别默认“男”
        
        self.title = @"新增客户";
    }else{
        self.title = @"编辑客户";
    }
    
    //设置数据源
    //备注：标题/描述/是否必填/是否可编辑/是否有箭头/输入类型
    titleArr = [NSMutableArray array];
    [titleArr addObject:@[@"姓名",@"请输入客户姓名",@"1",@"0",@"0",@"0"]];
    [titleArr addObject:@[@"性别",@"",@"0",@"1",@"0",@"0"]];
    [titleArr addObject:@[@"出生年月",@"请选择出生年月",@"0",@"1",@"1",@"0"]];
    [titleArr addObject:@[@"职级",@"请选择客户职级",@"0",@"1",@"1",@"0"]];
    [titleArr addObject:@[@"所在地区",@"请选择所在地区",@"0",@"1",@"1",@"0"]];
    [titleArr addObject:@[@"医院级别",@"级别",@"0",@"1",@"1",@"0"]];
    [titleArr addObject:@[@"所在医院",@"请选择所在医院",@"1",@"1",@"1",@"0"]];
    [titleArr addObject:@[@"学科",@"请选择学科",@"1",@"1",@"1",@"0"]];
    [titleArr addObject:@[@"所在科室",@"请选择所在科室",@"1",@"1",@"1",@"0"]];
    [titleArr addObject:@[@"所在治疗组",@"请输入客户所在治疗组",@"1",@"0",@"0",@"0"]];
    [titleArr addObject:@[@"电话",@"请输入客户电话",@"1",@"0",@"0",@"1"]];
    [titleArr addObject:@[@"邮箱",@"请输入客户邮箱",@"0",@"0",@"0",@"0"]];
    [titleArr addObject:@[@"微信",@"请输入客户微信",@"0",@"0",@"0",@"0"]];
    [titleArr addObject:@[@"QQ",@"请输入客户QQ号",@"0",@"0",@"0",@"2"]];
    
    //创建“完成”按钮
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-45, SCREEN_WIDTH, 45)];
    [btnFunc setTitle:@"完成" forState:UIControlStateNormal];
    [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT17];
    [btnFunc setBackgroundColor:GREEN_COLOR];
    [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnFunc];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
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
    }];
    [operation start];
    [operation1 start];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
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
    if(indexPath.section==0) {
        return 45;
    }
    return 115;
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
    if(section==1) {
        [lbMsg setText:@"客户简介"];
    }else if(section==2) {
        [lbMsg setText:@"备注信息"];
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
    static NSString *cellIndentifier = @"KHYCustomerEditViewControllerCell";
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
            
            //创建“是否必填标志”
            if([itemArr[2] integerValue]==1) {
                UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(lbMsg.right, 10, 10, 25)];
                [lbMsg2 setText:@"*"];
                [lbMsg2 setTextColor:[UIColor redColor]];
                [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
                [lbMsg2 setFont:FONT17];
                [cell.contentView addSubview:lbMsg2];
            }
            
            CGFloat tWidth = 120;
            if([itemArr[4] integerValue]==1) {
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
            if([itemArr[3] integerValue]==1) {
                [tbxContent setEnabled:NO];
            }else if([itemArr[5] integerValue]==1) {
                //手机号码
                [tbxContent setKeyboardType:UIKeyboardTypePhonePad];
            }else if([itemArr[5] integerValue]==2) {
                //数字输入框
                [tbxContent setKeyboardType:UIKeyboardTypeNumberPad];
            }
            [cell.contentView addSubview:tbxContent];
            
            if(indexPath.row==1) {
                [tbxContent setHidden:YES];
                
                NSMutableArray *titleArr = [NSMutableArray array];
                [titleArr addObject:@[@"checked_icon_selected",@"男"]];
                [titleArr addObject:@[@"checked_icon_normal",@"女"]];
                for (int i=0; i<2; i++) {
                    NSArray *itemArr = [titleArr objectAtIndex:i];
                    
                    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-110+50*i, 10, 50, 25)];
                    [btnFunc setTitle:itemArr[1] forState:UIControlStateNormal];
                    [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
                    [btnFunc.titleLabel setFont:FONT14];
                    [btnFunc setImage:[UIImage imageNamed:itemArr[0]] forState:UIControlStateNormal];
                    [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
                    [btnFunc setTag:i];
                    [btnFunc setSelected:NO];
                    if(i==0) {
                        [btnFunc setSelected:YES];
                    }
                    [btnFunc addTouch:^{
                        NSLog(@"选择排烟通道");
                        [self.view endEditing:YES];
                        
                        for (UIView *view in cell.contentView.subviews) {
                            if([view isKindOfClass:[UIButton class]]) {
                                UIButton *btn = (UIButton *)view;
                                [btn setImage:[UIImage imageNamed:@"checked_icon_normal"] forState:UIControlStateNormal];
                                [btn setSelected:NO];
                            }
                        }
                        if(btnFunc.tag==0) {
                            //男
                            _customerModel.gender = @"1";
                        }else if(btnFunc.tag==1) {
                            //女
                            _customerModel.gender = @"2";
                        }
                        [btnFunc setImage:[UIImage imageNamed:@"checked_icon_selected"] forState:UIControlStateNormal];
                        
                    }];
                    [cell.contentView addSubview:btnFunc];
                    
                }
            }
            
            switch (indexPath.row) {
                case 0: {
                    //姓名
                    [tbxContent setText:_customerModel.realname];
                    
                    break;
                }
                case 2: {
                    //出生年月
                    [tbxContent setText:_customerModel.birthday];
                    
                    break;
                }
                case 3: {
                    //职级
                    [tbxContent setText:_customerModel.position_name];
                    
                    break;
                }
                case 4: {
                    //所在地区
                    [tbxContent setText:_customerModel.city_name];
                    
                    break;
                }
                case 5: {
                    //医院级别
                    [tbxContent setText:_customerModel.hospitalLevel_name];
                    
                    break;
                }
                case 6: {
                    //所在医院
                    [tbxContent setText:_customerModel.hospital_name];
                    
                    break;
                }
                case 7: {
                    //学科
                    [tbxContent setText:_customerModel.subject_name];
                    
                    break;
                }
                case 8: {
                    //所在科室
                    [tbxContent setText:_customerModel.keshi_name];
                    
                    break;
                }
                case 9: {
                    //所在治疗组
                    [tbxContent setText:_customerModel.treat_group];
                    
                    break;
                }
                case 10: {
                    //电话
                    [tbxContent setText:_customerModel.mobile];
                    
                    break;
                }
                case 11: {
                    //邮箱
                    [tbxContent setText:_customerModel.email];
                    
                    break;
                }
                case 12: {
                    //微信
                    [tbxContent setText:_customerModel.weixin];
                    
                    break;
                }
                case 13: {
                    //QQ
                    [tbxContent setText:_customerModel.qq];
                    
                    break;
                }
                    
                default:
                    break;
            }
            
            //创建“右侧尖头”
            if([itemArr[4] integerValue]==1) {
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
            //医生简介
            
            self.limitView = [[ZTELimitTextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 115)];
            self.limitView.limitNum = 200;
            if(IsStringEmpty(_customerModel.intro)) {
                self.limitView.placeHolder = @"请输入客户简介";
            }else{
                self.limitView.placeHolder = @"";
                [self.limitView.textView setText:_customerModel.intro];
            }
            WS(weakSelf)
            self.limitView.textViewDidChange = ^(NSString *content) {
                NSLog(@"简介：%@",content);
                
                weakSelf.customerModel.intro = content;
                
            };
            [cell.contentView addSubview:self.limitView];
            
            break;
        }
        case 2: {
            //备注信息
            self.limitView2 = [[ZTELimitTextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 115)];
            self.limitView2.limitNum = 200;
            if(IsStringEmpty(_customerModel.note)) {
                self.limitView2.placeHolder = @"请输入备注信息";
            }else{
                self.limitView2.placeHolder = @"";
                [self.limitView2.textView setText:_customerModel.note];
            }
            WS(weakSelf)
            self.limitView2.textViewDidChange = ^(NSString *content) {
                NSLog(@"备注：%@",content);
                
                weakSelf.customerModel.note = content;
                
            };
            [cell.contentView addSubview:self.limitView2];
            
            break;
        }
            
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UITextField *tbxContent = [cell.contentView viewWithTag:indexPath.row+100];
    
    if(indexPath.section==0) {
        switch (indexPath.row) {
            case 2: {
                //选择出生年月
                MHDatePicker *selectDatePicker = [[MHDatePicker alloc] init];
                selectDatePicker.isBeforeTime = YES;
                selectDatePicker.datePickerMode = UIDatePickerModeDate;
                [selectDatePicker didFinishSelectedDate:^(NSDate *selectedDate) {
                    NSDate * now = [NSDate date];
                    if ([selectedDate timeIntervalSince1970] > [now timeIntervalSince1970]) {
                        [MBProgressHUD showMessage:@"年月日不能大于当前时间" toView:self.view];
                    }else{
                        //MM月dd日 HH:mm
                        NSString *birthday = [NSString dateStringWithDate:selectedDate DateFormat:@"yyyy-MM-dd"];
                        [tbxContent setText:birthday];
                        
                        _customerModel.birthday = birthday;
                    }
                }];
                
                break;
            }
            case 3: {
                //职级
                
                KHYPositionSelectedViewController *positionView = [[KHYPositionSelectedViewController alloc] init];
                positionView.callBack = ^(NSString *position_id, NSString *position_name) {
                    NSLog(@"职级ID：%@-职级名称：%@",position_id,position_name);
                    [tbxContent setText:position_name];
                    
                    _customerModel.position_id = position_id;
                    _customerModel.position_name = position_name;
                    
                };
                UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:positionView];
                [self.navigationController presentViewController:navC animated:YES completion:nil];
                
                break;
            }
            case 4: {
                //所在地区
                if (self.cityArr.count == 0)
                {
                    [MBProgressHUD showError:@"您暂无负责区域" toView:self.view];
                    return;
                }
                [UIView animateWithDuration:0.03 animations:^{
                    self.picker.transform = CGAffineTransformMakeTranslation(0, -SCREEN_HEIGHT);
                }];
                
//                AddressPickView *addressPickView = [AddressPickView CreateInstance];
//                [self.view addSubview:addressPickView];
//                addressPickView.block = ^(NSString *cityIds,NSString *nameStr){
//                    NSLog(@"%@ %@",cityIds,nameStr);
//                    //省市区名称
//                    [tbxContent setText:nameStr];
//
//                    //值存储
//                    NSArray *itemArr = [cityIds componentsSeparatedByString:@","];
//                    _customerModel.province_id = itemArr[0];
//                    _customerModel.city_id = itemArr[1];
//                    _customerModel.area_id = itemArr[2];
//                    _customerModel.city_name = nameStr;
//
//                };
                
                break;
            }
            case 5: {
                //医院级别
                CGRect rect  = CGRectZero;
                KHYHospitalSheetView *sheetView = [[KHYHospitalSheetView alloc] initWithFrame:rect withDataArr:[NSMutableArray arrayWithArray:self.hospitalLevelArr]];
                sheetView.hospitalLevelCallBack = ^(NSString *levelID, NSString *levelStr) {
                    NSLog(@"医院级别：%@-%@",levelID,levelStr);
                    [tbxContent setText:levelStr];
                    //医院级别
                    self.customerModel.hospitalLevel_id = levelID;
                    self.customerModel.hospitalLevel_name = levelStr;
                };
                [sheetView show];
                break;
            }
            case 6: {
                //所在医院
                
                //城市验证
                if(IsStringEmpty(_customerModel.area_id)) {
                    [MBProgressHUD showError:@"请选择城市" toView:self.view];
                    return;
                }
                
                kDISPATCH_MAIN_THREAD(^{
                    
                    KHYHospitalSelectedViewController *hospitalView = [[KHYHospitalSelectedViewController alloc] init];
                    hospitalView.city_id = _customerModel.city_id;
                    hospitalView.area_id = _customerModel.area_id;
                    hospitalView.hospitalLevel_id = _customerModel.hospitalLevel_id;
                    hospitalView.callBack = ^(NSString *hospital_id, NSString *hospital_name) {
                        NSLog(@"医院ID：%@-医院名称：%@",hospital_id,hospital_name);
                        [tbxContent setText:hospital_name];
                        
                        _customerModel.hospital_id = hospital_id;
                        _customerModel.hospital_name = hospital_name;
                        
                    };
                    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:hospitalView];
                    [self.navigationController presentViewController:navC animated:YES completion:nil];
                    
                });
                
                break;
            }
            case 7: {
                //学科
                
                //                if(IsStringEmpty(_customerModel.hospital_id)) {
                //                    [MBProgressHUD showError:@"请选择医院" toView:self.view];
                //                    return;
                //                }
                
                kDISPATCH_MAIN_THREAD(^{
                    
                    KHYSubjectSelectedViewController *keshiView = [[KHYSubjectSelectedViewController alloc] init];
                    keshiView.hospital_id = _customerModel.hospital_id;
                    keshiView.callBack = ^(NSString *keshi_id, NSString *keshi_name,NSArray *keshiArr) {
                        NSLog(@"科室ID：%@-科室名称：%@",keshi_id,keshi_name);
                        [tbxContent setText:keshi_name];
                        
                        _customerModel.subject_id = keshi_id;
                        _customerModel.subject_name = keshi_name;
                        
                        //给二级科室赋值
                        self.keshiArr = [keshiArr mutableCopy];
                        
                    };
                    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:keshiView];
                    [self.navigationController presentViewController:navC animated:YES completion:nil];
                    
                });
                
                break;
            }
            case 8: {
                //所在科室
                
                //                if(IsStringEmpty(_customerModel.first_keshi_id)) {
                //                    [MBProgressHUD showError:@"请选择学科" toView:self.view];
                //                    return;
                //                }
                
                kDISPATCH_MAIN_THREAD(^{
                    
                    KHYSubjectKeshiSelectedViewController *keshiView = [[KHYSubjectKeshiSelectedViewController alloc] init];
                    keshiView.dataArr = self.keshiArr;
                    keshiView.callBack = ^(NSString *keshi_id, NSString *keshi_name) {
                        NSLog(@"科室ID：%@-科室名称：%@",keshi_id,keshi_name);
                        [tbxContent setText:keshi_name];
                        
                        _customerModel.keshi_id = keshi_id;
                        _customerModel.keshi_name = keshi_name;
                        
                    };
                    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:keshiView];
                    [self.navigationController presentViewController:navC animated:YES completion:nil];
                    
                });
                
                break;
            }
                
            default:
                break;
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)textFieldDidChange:(UITextField *)textField {
    
    switch (textField.tag) {
        case 100: {
            //客户姓名
            _customerModel.realname = textField.text;
            
            break;
        }
        case 109: {
            //治疗组
            _customerModel.treat_group = textField.text;
            
            break;
        }
        case 110: {
            //电话
            if (textField.text.length > 11) {
                textField.text = [textField.text substringToIndex:11];
            }
            _customerModel.mobile = textField.text;
            
            break;
        }
        case 111: {
            //邮箱
            _customerModel.email = textField.text;
            
            break;
        }
        case 112: {
            //微信
            _customerModel.weixin = textField.text;
            
            break;
        }
        case 113: {
            //QQ号
            _customerModel.qq = textField.text;
            
            break;
        }
            
        default:
            break;
    }
    
}

/**
 *  完成按钮事件
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"完成");
    [self.view endEditing:YES];
    
    //姓名验证
    if(IsStringEmpty(_customerModel.realname)) {
        [MBProgressHUD showError:@"请输入客户姓名" toView:self.view];
        return;
    }
    
    //医院验证
    if(IsStringEmpty(_customerModel.hospital_id)) {
        [MBProgressHUD showError:@"请选择医院" toView:self.view];
        return;
    }
    
    //科室验证
    if(IsStringEmpty(_customerModel.subject_id)) {
        [MBProgressHUD showError:@"请选择学科" toView:self.view];
        return;
    }
    
    //科室验证
    if(IsStringEmpty(_customerModel.keshi_id)) {
        [MBProgressHUD showError:@"请选择科室" toView:self.view];
        return;
    }
    
    //治疗组验证
    if(IsStringEmpty(_customerModel.treat_group)) {
        [MBProgressHUD showError:@"请输入客户所在治疗组" toView:self.view];
        return;
    }
    
    //电话
    if(IsStringEmpty(_customerModel.mobile)) {
        [MBProgressHUD showError:@"请输入客户电话" toView:self.view];
        return;
    }
    
    [MBProgressHUD showMsg:@"数据提交中..." toView:self.view];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"customer" forKey:@"app"];
    [param setValue:@"addCustomer" forKey:@"act"];
    [param setValue:_customerModel.doctor_id forKey:@"doctor_id"];
    [param setValue:_customerModel.hospital_id forKey:@"hospital_id"];
    [param setValue:_customerModel.keshi_id forKey:@"keshi_id"];
    [param setValue:_customerModel.subject_id forKey:@"subject_id"];
    [param setValue:_customerModel.realname forKey:@"realname"];
    [param setValue:_customerModel.gender forKey:@"gender"];
    [param setValue:_customerModel.birthday forKey:@"birthday"];
    [param setValue:_customerModel.position_id forKey:@"position_id"];
    [param setValue:_customerModel.province_id forKey:@"province_id"];
    [param setValue:_customerModel.city_id forKey:@"city_id"];
    [param setValue:_customerModel.area_id forKey:@"area_id"];
    [param setValue:_customerModel.treat_group forKey:@"treat_group"];
    [param setValue:_customerModel.mobile forKey:@"mobile"];
    [param setValue:_customerModel.email forKey:@"email"];
    [param setValue:_customerModel.weixin forKey:@"weixin"];
    [param setValue:_customerModel.qq forKey:@"qq"];
    [param setValue:_customerModel.intro forKey:@"intro"];
    [param setValue:_customerModel.note forKey:@"note"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        [MBProgressHUD hideHUD:self.view];
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            [MBProgressHUD showSuccess:@"提交成功" toView:self.view];
            
            NSDictionary *dataDic = [json objectForKey:@"data"];
            KHYCustomerModel *model = [KHYCustomerModel mj_objectWithKeyValues:dataDic];

            //延迟1秒返回
            kDISPATCH_MAIN_AFTER(1, ^{
                if(self.callBack) {
                    self.callBack(model);
                }
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }else{
            [MBProgressHUD showError:msg toView:self.view];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        [MBProgressHUD hideHUD:self.view];
    }];
    
}

- (void)viewTouch
{
    [UIView animateWithDuration:0.03 animations:^{
        self.picker.transform = CGAffineTransformIdentity;
    }];
}
#pragma mark - JXAreaViewDelegate
- (void)leftBtnClick
{
    [self viewTouch];
}

- (void)rightBtnClickWithIDs:(NSArray *)ids Strings:(NSArray *)strs
{
    [self viewTouch];
    NSString *str = [NSString stringWithFormat:@"%@ %@ %@",strs[0],strs[1],strs[2]];
    _customerModel.province_id = ids[0];
    _customerModel.city_id = ids[1];
    _customerModel.area_id = ids[2];
    _customerModel.city_name = str;
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
