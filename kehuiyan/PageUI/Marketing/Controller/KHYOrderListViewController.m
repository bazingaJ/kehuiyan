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
    NSLog(@"========%@",self.selectIndex);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1)
    {
        return 230.f;
    }
    return 186.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KHYOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell =[[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([KHYOrderCell class]) owner:nil options:nil]objectAtIndex:0];
    }
    cell.deliverBtn.hidden = YES;
    if (indexPath.section == 1)
    {
        cell.deliverBtn.hidden = NO;
    }
    
    
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
    
    KHYOrderDetailViewController *vc = [[KHYOrderDetailViewController alloc] init];
    vc.orderType = @(indexPath.section % 3 + 1).stringValue;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}



@end
