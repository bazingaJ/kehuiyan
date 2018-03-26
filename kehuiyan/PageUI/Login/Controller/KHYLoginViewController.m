//
//  KHYLoginViewController.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/8.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYLoginViewController.h"
#import "KHYForgetPwdViewController.h"
#import "KHYHomeViewController.h"

@interface KHYLoginViewController () {
    NSMutableArray *titleArr;
    
    NSString *mobileStr;
    NSString *passwordStr;
}

@end

@implementation KHYLoginViewController

- (void)viewDidLoad {
    [self setLeftButtonItemHidden:YES];
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"登录";
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    //设置数据源
    titleArr = [NSMutableArray array];
    [titleArr addObject:@[@"login_icon_mobile",@"请输入手机号"]];
    [titleArr addObject:@[@"login_icon_pwd",@"请输入密码"]];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==0) {
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            //账号、密码
            return 65;
            
            break;
        case 1:
            //登录按钮
            return 55;
            
            break;
        case 2:
            //找回密码
            return 45;
            
            break;
            
        default:
            break;
    }
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"KHYLoginViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    switch (indexPath.section) {
        case 0: {
            NSArray *itemArr = [titleArr objectAtIndex:indexPath.row];
            
            //创建“背景层”
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(10, 20, SCREEN_WIDTH-20, 40)];
            [backView.layer setCornerRadius:5.0];
            [backView.layer setBorderWidth:0.5];
            [backView.layer setBorderColor:UIColorFromRGBWith16HEX(0xC1C1C1).CGColor];
            [cell.contentView addSubview:backView];
            
            UIImage *img = [UIImage imageNamed:itemArr[0]];
            CGFloat tW = img.size.width;
            CGFloat tH = img.size.height;
            
            //创建“图标”
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (40-tH)/2, tW, tH)];
            [imgView setImage:img];
            [backView addSubview:imgView];
            
            //创建“手机号码”输入框
            UITextField *tbxContent = [[UITextField alloc] initWithFrame:CGRectMake(40, 5, backView.frame.size.width-50, 30)];
            [tbxContent setPlaceholder:itemArr[1]];
            [tbxContent setTextAlignment:NSTextAlignmentLeft];
            [tbxContent setTextColor:COLOR3];
            [tbxContent setFont:FONT16];
            [tbxContent setValue:COLOR9 forKeyPath:@"_placeholderLabel.textColor"];
            [tbxContent setValue:FONT16 forKeyPath:@"_placeholderLabel.font"];
            if(indexPath.row==0) {
                //手机号码
                [tbxContent setKeyboardType:UIKeyboardTypeNumberPad];
            }else if(indexPath.row==1) {
                //密码
                [tbxContent setSecureTextEntry:YES];
            }
            [tbxContent setDelegate:self];
            [tbxContent addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            [tbxContent setClearButtonMode:UITextFieldViewModeWhileEditing];
            [tbxContent setTag:indexPath.row+100];
            [backView addSubview:tbxContent];
            
            switch (indexPath.row) {
                case 0: {
                    //手机号码
                    [tbxContent setText:mobileStr];
                    
                    break;
                }
                case 1: {
                    //密码
                    [tbxContent setText:passwordStr];
                    
                    break;
                }
                    
                default:
                    break;
            }
            
            
            break;
        }
        case 1: {
            //创建“登录”按钮
            UIButton *btnLogin = [[UIButton alloc] initWithFrame:CGRectMake(10, 15, SCREEN_WIDTH-20, 40)];
            [btnLogin setBackgroundColor:GREEN_COLOR];
            [btnLogin setTitle:@"登录" forState:UIControlStateNormal];
            [btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btnLogin.titleLabel setFont:FONT17];
            [btnLogin.layer setCornerRadius:3.0];
            [btnLogin addTarget:self action:@selector(btnLoginClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btnLogin];
            
            break;
        }
        case 2: {
            //找回密码
            
            //忘记密码
            UIButton *btnForgetPwd = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-90, 10, 80, 20)];
            [btnForgetPwd setTitle:@"找回密码" forState:UIControlStateNormal];
            [btnForgetPwd setTitleColor:COLOR9 forState:UIControlStateNormal];
            [btnForgetPwd.titleLabel setFont:FONT14];
            [btnForgetPwd setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
            [btnForgetPwd addTarget:self action:@selector(btnForgetPwdClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btnForgetPwd];
            
            break;
        }
            
        default:
            break;
    }
    
    return cell;
}

- (void)textFieldDidChange:(UITextField *)textField {
    switch (textField.tag) {
        case 100: {
            //手机号码
            if (textField.text.length > 11) {
                textField.text = [textField.text substringToIndex:11];
            }
            mobileStr = textField.text;
            
            break;
        }
        case 101: {
            //密码
            if (textField.text.length > 12) {
                textField.text = [textField.text substringToIndex:12];
            }
            passwordStr = textField.text;
            
            break;
        }
            
        default:
            break;
    }
}

#pragma mark---scrollView delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

/**
 *  登录按钮事件
 */
- (void)btnLoginClick:(UIButton *)btnSender {
    NSLog(@"登录按钮事件");
    [self.view endEditing:YES];
    
    if (![mobileStr isPhoneNumber]) {
        [MBProgressHUD showError:@"请输入正确的手机号" toView:self.view];
        return;
    }
    if (![passwordStr isMinLength:6 andMaxLength:12]) {
        [MBProgressHUD showError:@"请输入6~12位密码" toView:self.view];
        return;
    }
    
    [MBProgressHUD showMsg:@"登录中..." toView:self.view];
    
    //广告号IDFA
    NSString *idfaStr = [[HelperManager CreateInstance] getIDFA];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"default" forKey:@"app"];
    [param setValue:@"login" forKey:@"act"];
    [param setValue:mobileStr forKey:@"mobile"];
    [param setValue:passwordStr forKey:@"password"];
    [param setValue:idfaStr forKey:@"device_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        [MBProgressHUD hideHUD:self.view];
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            [MBProgressHUD showSuccess:@"登录成功" toView:self.view];
            NSDictionary *dataDic = [json objectForKey:@"data"];
            
            //预先清除
            [[HelperManager CreateInstance] clearAcc];
            
            //设置本地缓存
            [self setUserDefaultInfo:dataDic];
            //推送别名设置
            [JPUSHService setTags:nil alias:idfaStr fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                NSLog(@"%d-------------%@,-------------%@",iResCode,iTags,iAlias);
            }];
            //延迟1秒退出
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
                //进入首页
                [APP_DELEGATE enterMainVC];
                
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
 *  找回密码按钮事件
 */
- (void)btnForgetPwdClick:(UIButton *)btnSender {
    NSLog(@"找回密码按钮事件");
    
    KHYForgetPwdViewController *forgetView = [[KHYForgetPwdViewController alloc] init];
    [self.navigationController pushViewController:forgetView animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
