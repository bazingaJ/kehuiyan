//
//  KHYQuestionRecordVC.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/17.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYQuestionRecordVC.h"
#import "KHYAskRecordCell.h"
#import "KHYAskRecordViewController.h"
#import "KHYQuestionListModel.h"

static NSString *const currentTitle = @"提问记录";

static NSString *const cellIdentifier = @"KHYAskRecordCell1";

static NSString *const cellIdentifier1 = @"KHYAskRecordCell2";

@interface KHYQuestionRecordVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation KHYQuestionRecordVC

- (void)viewDidLoad {
    
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    self.title = currentTitle;
    self.tableView.backgroundColor = BACK_COLOR;
    
}
- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self requestData];
}
// 请求提问详情数据
- (void)requestData
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"app"] = @"home";
    param[@"act"] = @"getMyExpertInfo";
    param[@"patient_id"] = self.patient_id;
    param[@"expert_id"] = self.model.expert_id;
    param[@"cate_id"] = self.cate_id;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataArr.count + 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 120.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    KHYAskRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    KHYAskRecordCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        if (!cell)
        {
            cell =[[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([KHYAskRecordCell class]) owner:nil options:nil]objectAtIndex:0];
        }
        cell.model = self.model;
        return cell;
    }
    else
    {
        if (!cell1)
        {
            cell1 = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([KHYAskRecordCell class]) owner:nil options:nil]objectAtIndex:1];
            
        }
        cell1.questionModel = self.dataArr[indexPath.row - 1];
        return cell1;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.001f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0.001f;
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
    
    if (indexPath.row == 0) return;
    KHYAskRecordViewController *vc = [[KHYAskRecordViewController alloc] init];
    vc.title = @"提问详情";
    vc.model = self.dataArr[indexPath.row-1];
    vc.isPatient = @"1";
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}



@end
