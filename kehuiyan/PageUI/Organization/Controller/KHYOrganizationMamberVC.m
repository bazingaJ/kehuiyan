//
//  KHYOrganizationMamberVC.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/3/13.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYOrganizationMamberVC.h"
#import "KHYOrganizationDetailVC.h"

@interface KHYOrganizationMamberVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *dataArr;
@end

@implementation KHYOrganizationMamberVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"部门成员";
    [self initialized];
}
- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self requestMemberList];
}
- (void)initialized
{
    self.tableView.tableFooterView = [UIView new];
}
- (void)requestMemberList
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"getMemberByDepId" forKey:@"act"];
    [param setValue:self.dep_id forKey:@"dep_id"];
    [HttpRequestEx postWithURL:SERVICE_URL
                        params:param
                       success:^(id json) {
                           NSString *msg = [json objectForKey:@"msg"];
                           NSString *code = [json objectForKey:@"code"];
                           if([code isEqualToString:SUCCESS]) {
                               NSDictionary *dict = [NSDictionary changeType:[json objectForKey:@"data"]];
                               self.dataArr = dict[@"list"];
                               [self.tableView reloadData];
                           }else{
                               [MBProgressHUD showError:msg toView:self.view];
                           }
    }
                       failure:^(NSError *error) {
                           NSLog(@"%@",[error description]);
                           [MBProgressHUD hideHUD:self.view];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 55.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"organizationID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSDictionary *dic = self.dataArr[indexPath.row];
    cell.textLabel.text = dic[@"realname"];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    return cell;
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
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.isTask)
    {
        NSDictionary *dic = self.dataArr[indexPath.row];
        NSString *user_id = dic[@"user_id"];
        NSString *realName = dic[@"realname"];
        NSUserDefaults *us = [NSUserDefaults standardUserDefaults];
        
        if ([[us objectForKey:@"isTaskType"] isEqualToString:@"leader"])
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSArray *controllers = self.navigationController.childViewControllers;
                for (UIViewController *vc in controllers)
                {
                    if ([NSStringFromClass([vc class]) isEqualToString:@"KHYTaskAddDayViewController"] || [NSStringFromClass([vc class]) isEqualToString:@"KHYTaskAddNextViewController"])
                    {
                        [us setObject:@"" forKey:@"isTaskType"];
                        // 由于选择两次 一次是选责任人 一次是选参与人 分两种方法传递参数 责任人用通知传 参与人用本地缓存传值
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"choiceLeader" object:nil userInfo:@{@"leader_user_id":user_id,@"leader_user_name":realName}];
                        [self.navigationController popToViewController:vc animated:YES];
                    }
                }
            });
        }
        if ([[us objectForKey:@"isTaskType"] isEqualToString:@"takeInner"])
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSArray *controllers = self.navigationController.childViewControllers;
                for (UIViewController *vc in controllers)
                {
                    if ([NSStringFromClass([vc class]) isEqualToString:@"KHYTaskAddDayViewController"] || [NSStringFromClass([vc class]) isEqualToString:@"KHYTaskAddNextViewController"])
                    {
                        // 由于选择两次 一次是选责任人 一次是选参与人 分两种方法传递参数 责任人用通知传 参与人用本地缓存传值
                        [us setObject:user_id forKey:@"part_user_id"];
                        [us setObject:realName forKey:@"part_user_name"];
                        [us setObject:@"" forKey:@"isTaskType"];
                        [us synchronize];
                        [self.navigationController popToViewController:vc animated:YES];
                    }
                }
            });
            
        }
        
        
    }
    else
    {
        NSDictionary *dic = self.dataArr[indexPath.row];
        KHYOrganizationDetailVC *vc = [[KHYOrganizationDetailVC alloc] init];
        vc.dataDict = dic;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
