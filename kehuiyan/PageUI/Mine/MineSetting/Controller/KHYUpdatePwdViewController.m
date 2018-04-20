//
//  KHYUpdatePwdViewController.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/24.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYUpdatePwdViewController.h"

@interface KHYUpdatePwdViewController ()<UITextFieldDelegate>

@end

@implementation KHYUpdatePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"重置密码";
    self.view.backgroundColor = kRGB(240, 240, 240);
}

- (IBAction)commitBtnClick:(UIButton *)sender
{
    if ([self.oldTF.text isEqualToString:@""])
    {
        [MBProgressHUD showMessage:@"请输入原密码" toView:self.view];
    }
    else if ([self.freshTF.text isEqualToString:@""])
    {
        [MBProgressHUD showMessage:@"请输入新密码" toView:self.view];
    }
    else if ([self.renewTF.text isEqualToString:@""])
    {
        [MBProgressHUD showMessage:@"请再次输入新密码" toView:self.view];
    }
    else if (![self isLegalWithString:self.freshTF.text])
    {
        [MBProgressHUD showMessage:@"新密码不能小于6个字符" toView:self.view];
    }
    else if (![self.freshTF.text isEqualToString:self.renewTF.text])
    {
        [MBProgressHUD showMessage:@"新密码输入不一致" toView:self.view];
    }
    else
    {
        
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setObject:@"ucenter" forKey:@"app"];
        [param setObject:@"resetPwdByUser" forKey:@"act"];
        [param setObject:self.oldTF.text forKey:@"password"];
        [param setObject:self.freshTF.text forKey:@"password_new"];
        [param setObject:self.renewTF.text forKey:@"password_confirm"];
        [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
            NSString *code = [json objectForKey:@"code"];
            NSString *msg = [json objectForKey:@"msg"];
            if ([code isEqualToString:SUCCESS])
            {
//                NSDictionary *dic = [json objectForKey:@"data"];
                [MBProgressHUD showMessage:@"重置成功" toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
            else
            {
                [MBProgressHUD showMessage:msg toView:self.view];
            }
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view];
        }];
    }
}
// 新密码的设置 控制字符串输入  < 12
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==self.freshTF || textField==self.renewTF)
    {
        NSInteger loc =range.location;
        if (loc < 12)
        {
            return YES;
        }
        else
        {
            [MBProgressHUD showMessage:@"新密码不能大于12个字符" toView:self.view];
            return NO;
        }
    }
    return YES;
}
// 新密码设置 合法性判断
- (BOOL)isLegalWithString:(NSString *)string
{
    if (string.length < 6)
    {
        return NO;
    }
    else
    {
        return YES;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}




@end
