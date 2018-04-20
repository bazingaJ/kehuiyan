//
//  KHYMineSettingViewController.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/24.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYMineSettingViewController.h"
#import "KHYMineSettingCell.h"
#import "KHYMineWebViewController.h"
#import "KHYUpdatePwdViewController.h"

@interface KHYMineSettingViewController ()

@end

@implementation KHYMineSettingViewController

- (void)viewDidLoad {
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设置";
    
    //设置数据源
    [self.dataArr removeAllObjects];
//    [self.dataArr addObject:@[@"setting_icon_about",@"关于"]];
//    [self.dataArr addObject:@[@"setting_icon_help",@"帮助"]];
    [self.dataArr addObject:@[@"setting_icon_resetpwd",@"重置密码"]];
    
    //创建“退出”按钮
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-45, SCREEN_WIDTH, 45)];
    [btnFunc setTitle:@"退出登录" forState:UIControlStateNormal];
    [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT17];
    [btnFunc setBackgroundColor:GREEN_COLOR];
    [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnFunc];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"KHYMineSettingCell";
    KHYMineSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[KHYMineSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    NSArray *itemArr = [self.dataArr objectAtIndex:indexPath.row];
    [cell setMineSettingCell:itemArr];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0)
    {
        KHYUpdatePwdViewController *updatePwd = [[KHYUpdatePwdViewController alloc] init];
        [self.navigationController pushViewController:updatePwd animated:YES];
    }
    
    // 3月20日 暂时隐藏 “关于”和“帮助” 模块
//    switch (indexPath.row) {
//        case 0: {
//            //关于
//
//            KHYMineWebViewController *webView = [[KHYMineWebViewController alloc] init];
//            webView.title = @"关于";
//            webView.contentStr = [URLManager manager].about;
//            [self.navigationController pushViewController:webView animated:YES];
//
//            break;
//        }
//        case 1: {
//            //帮助
//
//            KHYMineWebViewController *webView = [[KHYMineWebViewController alloc] init];
//            webView.title = @"帮助";
//            webView.contentStr = [URLManager manager].help;
//            [self.navigationController pushViewController:webView animated:YES];
//
//            break;
//        }
//        case 2: {
//            //重置密码
//
//            KHYUpdatePwdViewController *updatePwd = [[KHYUpdatePwdViewController alloc] init];
//            [self.navigationController pushViewController:updatePwd animated:YES];
//
//            break;
//        }
//
//        default:
//            break;
//    }
}

/**
 *  退出
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"退出");
    
    UIAlertController * aler = [UIAlertController alertControllerWithTitle:@"警告" message:@"您确定退出吗?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //清除用户本地账号信息
        [[HelperManager CreateInstance] clearAcc];
        
        //推送,用户退出,别名去掉
        [JPUSHService setAlias:@"" completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            NSLog(@"=退出登录去掉别名====%ld====%@====%ld",(long)iResCode,iAlias,(long)seq);
        } seq:1];
        // 过期方法
//        [JPUSHService setAlias:@"" callbackSelector:nil object:self];
        
        //退出后跳转至首页
        [APP_DELEGATE enterMainVC];
    }];
    [aler addAction:cancelAction];
    [aler addAction:okAction];
    [self presentViewController:aler animated:YES completion:nil];
    
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
