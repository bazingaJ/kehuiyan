//
//  KHYOrderListViewController.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/12.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYOrderListViewController.h"
#import "KHYOrderCell.h"
#import "KHYOrderDetailViewController.h"
#import "KHYOrderModel.h"

static NSString *const cellIdentifier = @"KHYOrderCell1";

@interface KHYOrderListViewController ()

@end

@implementation KHYOrderListViewController

- (void)viewDidLoad {
    
    [self setHiddenHeaderRefresh:YES];
    self.bottomH = 50;
    [super viewDidLoad];
    self.tableView.backgroundColor = BACK_COLOR;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    // 请求接口
    if ([self.selectIndex isEqualToString:@"3"]) {
        self.selectIndex = @"5";
    }
    [self requestDataWithType:self.selectIndex];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    KHYOrderModel *model = self.dataArr[indexPath.section];
//    if ([model.status isEqualToString:@"2"])
//    {
//        return 230.f;
//    }
    return 186.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KHYOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell =[[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([KHYOrderCell class]) owner:nil options:nil]objectAtIndex:0];
    }
    cell.model = self.dataArr[indexPath.section];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10.f;
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
    
    KHYOrderModel *model = self.dataArr[indexPath.section];
    if ([model.status isEqualToString:@"5"]) {
        return;
    }
    KHYOrderDetailViewController *vc = [[KHYOrderDetailViewController alloc] init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark - 获取订单列表
// 状态 ( 1待付款 2待发货 3已发货 4已完成 5已取消 )
- (void)requestDataWithType:(NSString *)type
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"app"] = @"ucenter";
    param[@"act"] = @"myOrderList";
    param[@"status"] = type;
    if ([JXAppTool isLeader]) {
        if (self.mem_id == nil) {
            // 领导要看患者的订单信息
            param[@"patient_id"] = self.patient_id;
        }else{
            param[@"mem_id"] = self.mem_id;
        }
        
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
                               self.dataArr = [KHYOrderModel mj_objectArrayWithKeyValuesArray:dict[@"list"]];
                               [self.tableView reloadData];
                               [self.tableView emptyViewShowWithDataType:EmptyViewTypeOrder
                                                                 isEmpty:self.dataArr.count<=0
                                                     emptyViewClickBlock:nil];
                               
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

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}



@end
