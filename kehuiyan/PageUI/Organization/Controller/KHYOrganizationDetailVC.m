//
//  KHYOrganizationDetailVC.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/3/12.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYOrganizationDetailVC.h"

@interface KHYOrganizationDetailVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *officeName;
@property (nonatomic, strong) NSArray *detailName;
@end

@implementation KHYOrganizationDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"%@的名片",self.dataDict[@"realname"]];
    self.view.backgroundColor = kRGB(240, 240, 240);
    [self initialized];
}
// 准备数据源
- (void)initialized
{
    self.tableView.tableFooterView = [UIView new];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:self.dataDict[@"avatar"]] placeholderImage:[UIImage imageNamed:@"default_img_round_list"]];
    self.realNameLab.text = self.dataDict[@"realname"];
    self.jobLab.text = self.dataDict[@"position"];
    self.officeName = @[@"电话",@"邮箱",@"微信"];
    self.detailName = @[self.dataDict[@"mobile"],self.dataDict[@"email"],self.dataDict[@"weixin"]];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 45.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"detailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.officeName[indexPath.row];
    cell.detailTextLabel.text = self.detailName[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:16];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.0001f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0.0001f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    return nil;
}
- (IBAction)backBtn:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
