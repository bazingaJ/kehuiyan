//
//  KHYQuestionListViewController.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/10.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYQuestionListViewController.h"
#import "KHYQuestionListCell.h"
#import "KHYQuestionListModel.h"
#import "KHYComboViewController.h"
#import "KHYAskRecordViewController.h"
#import "KHYChatViewController.h"
#import "KHYChatModel.h"

static NSString *const currentTitle1 = @"患者提问";

static NSString *const currentTitle2 = @"咨询列表";

static NSString *const cellIdentifier = @"KHYQuestionListCell1";

@interface KHYQuestionListViewController ()

@end

@implementation KHYQuestionListViewController

- (void)viewDidLoad {
    
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    self.title = self.characterType == 1 ? currentTitle1 : currentTitle2;
    
//    [self initialized];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    if ([[HelperManager CreateInstance].position_id isEqualToString:@"4"]) {
        
    }
    else if ([[HelperManager CreateInstance].position_id isEqualToString:@"20"])
    {
        [self requestQuestionData];
    }
    
}

// 获取提问列表
- (void)requestQuestionData
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"app"] = @"home";
    param[@"act"] = @"getQuestionList";
    if (![[HelperManager CreateInstance].position_id isEqualToString:@"4"] && ![[HelperManager CreateInstance].position_id isEqualToString:@"20"]) {
        param[@"mem_id"] = self.memberID;
    }
    [MBProgressHUD showSimple:self.view];
    [HttpRequestEx postWithURL:SERVICE_URL
                        params:param
                       success:^(id json) {
                           [MBProgressHUD hideHUDForView:self.view];
                           NSString *code = [json objectForKey:@"code"];
                           NSString *msg  = [json objectForKey:@"msg"];
                           if ([code isEqualToString:SUCCESS])
                           {
                               NSDictionary *dict = [json objectForKey:@"data"];
                               self.dataArr = [KHYQuestionListModel mj_objectArrayWithKeyValuesArray:dict[@"list"]];
                               [self.tableView reloadData];
                           }
                           else
                           {
                               [MBProgressHUD showError:msg toView:self.view];
                           }
                       }
                       failure:^(NSError *error) {
                           [MBProgressHUD hideHUDForView:self.view];
                           [MBProgressHUD showError:@"与服务器连接失败" toView:self.view];
                       }];
}

- (void)requestConsultData
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"app"] = @"home";
    param[@"act"] = @"getChatList";
    [MBProgressHUD showSimple:self.view];
    [HttpRequestEx postWithURL:SERVICE_URL
                        params:param
                       success:^(id json) {
                           [MBProgressHUD hideHUDForView:self.view];
                           NSString *code = [json objectForKey:@"code"];
                           NSString *msg  = [json objectForKey:@"msg"];
                           if ([code isEqualToString:SUCCESS])
                           {
                               NSDictionary *dict = [json objectForKey:@"data"];
                               self.dataArr = [KHYChatModel mj_objectArrayWithKeyValuesArray:dict[@"list"]];
                               [self.tableView reloadData];
                           }
                           else
                           {
                               [MBProgressHUD showError:msg toView:self.view];
                           }
                       }
                       failure:^(NSError *error) {
                           [MBProgressHUD hideHUDForView:self.view];
                           [MBProgressHUD showError:@"与服务器连接失败" toView:self.view];
                       }];
    
}

- (void)initialized
{
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 70.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    KHYQuestionListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([KHYQuestionListCell class]) owner:nil options:nil]objectAtIndex:0];
    }
    if ([[HelperManager CreateInstance].position_id isEqualToString:@"4"]) {
        cell.chatModel = self.dataArr[indexPath.row];
    }else if ([[HelperManager CreateInstance].position_id isEqualToString:@"20"]){
        cell.model = self.dataArr[indexPath.row];
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.001f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 10.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([[HelperManager CreateInstance].position_id isEqualToString:@"4"]){
        KHYChatViewController *vc = [[KHYChatViewController alloc] init];
        vc.title = @"咨询详情";
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([[HelperManager CreateInstance].position_id isEqualToString:@"20"]){
        KHYAskRecordViewController *vc = [[KHYAskRecordViewController alloc] init];
        vc.title = @"提问详情";
        vc.model = self.dataArr[indexPath.row];
        vc.isPatient = @"2";
        [self.navigationController pushViewController:vc animated:YES];
    }

}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}



@end
