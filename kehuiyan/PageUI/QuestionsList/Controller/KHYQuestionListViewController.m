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
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    if (self.characterType == 1){
        [self requestQuestionData];
    }else if (self.characterType == 2){
        [self requestConsultData];
    }
    
    
}

// 获取提问列表
- (void)requestQuestionData
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"app"] = @"home";
    param[@"act"] = @"getQuestionList";
    if ([JXAppTool isLeader]) {
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
                               [self.tableView emptyViewShowWithDataType:EmptyViewTypeData isEmpty:self.dataArr.count <= 0 emptyViewClickBlock:nil];
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

// 获取咨询列表
- (void)requestConsultData
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"app"] = @"home";
    param[@"act"] = @"getChatList";
    if ([JXAppTool isLeader]) {
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
                               self.dataArr = [KHYChatModel mj_objectArrayWithKeyValuesArray:dict[@"list"]];
                               [self.tableView reloadData];
                               [self.tableView emptyViewShowWithDataType:EmptyViewTypeData isEmpty:self.dataArr.count <= 0 emptyViewClickBlock:nil];
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
    if (self.characterType == 1){
        cell.model = self.dataArr[indexPath.row];
    }else if (self.characterType == 2){
        cell.chatModel = self.dataArr[indexPath.row];
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
    
    if (self.characterType== 1) {
        KHYAskRecordViewController *vc = [[KHYAskRecordViewController alloc] init];
        vc.title = @"提问详情";
        vc.model = self.dataArr[indexPath.row];
        vc.isPatient = @"2";
        vc.memberID = self.memberID;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        KHYChatViewController *vc = [[KHYChatViewController alloc] init];
        vc.title = @"咨询详情";
        vc.isFromInfo = self.isFromInfo;
        vc.model = self.dataArr[indexPath.row];
        if ([JXAppTool isLeader]) {
            vc.memberID = self.memberID;
        }
        
        [self.navigationController pushViewController:vc animated:YES];
    }

}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}



@end
