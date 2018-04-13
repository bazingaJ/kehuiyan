//
//  KHYAnnounceViewController.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/11.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYAnnounceViewController.h"
#import "KHYAnnounceCell.h"

static NSString *const cellIdentifier1 = @"KHYAnnounceCell1";
static NSString *const cellIdentifier2 = @"KHYAnnounceCell2";
static NSString *const cellIdentifier3 = @"KHYAnnounceCell3";
static NSString *const cellIdentifier4 = @"KHYAnnounceCell4";
static NSString *const cellIdentifier5 = @"KHYAnnounceCell5";

@interface KHYAnnounceViewController ()
@property (nonatomic, strong) NSArray *originArr;
@end

@implementation KHYAnnounceViewController

- (void)viewDidLoad {
    
    [self setHiddenHeaderRefresh:YES];
    self.bottomH = 50;
    [super viewDidLoad];
    self.title = @"发布活动";
    [self prepareForData];
    [self createUI];
}

- (void)prepareForData
{
    
    self.originArr = @[@[@"活动名称",@"请输入活动名称"],
                       @[@"主办机构",@"请输入主办机构名称"],
                       @[@"承办单位",@"请输入承办单位名称"],
                       @[@"活动时间",@""],
                       @[@"报名时间",@""],
                       @[@"报名人数",@"请输入报名人数"],
                       @[@"活动地址",@"江苏省  南京市  建邺区"],
                       @[@"",@"嘉陵江东街18号05栋"]];
}

- (void)createUI
{
    
    UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [publishBtn setTitle:@"发布" forState:UIControlStateNormal];
    [publishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [publishBtn setBackgroundColor:kRGB(89, 189, 237)];
    [publishBtn addTarget:self action:@selector(publishActivity) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:publishBtn];
    [publishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0)
    {
        return 8;
    }
    else if (section == 1)
    {
        return 2;
    }
    else
    {
        return 2;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1 && indexPath.row == 1)
    {
        return 120.f;
    }
    else if (indexPath.section == 2 && indexPath.row == 1)
    {
        return 130.f;
    }
    return 45.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 3 || indexPath.row == 4)
        {
            KHYAnnounceCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
            if (!cell1)
            {
                cell1 = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([KHYAnnounceCell class]) owner:nil options:nil]objectAtIndex:1];
            }
            cell1.titleLab1.text = self.originArr[indexPath.row][0];
            return cell1;
        }
        else
        {
            KHYAnnounceCell *cell2 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
            if (!cell2)
            {
                cell2 = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([KHYAnnounceCell class]) owner:nil options:nil]objectAtIndex:0];
                cell2.accessoryType = UITableViewCellAccessoryNone;
            }
            cell2.titleLab.text = self.originArr[indexPath.row][0];
            cell2.contentTF.placeholder = self.originArr[indexPath.row][1];
            if (indexPath.row == 6)
            {
                cell2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell2.width.constant = 0;
            }
            if (indexPath.row == 7)
            {
                cell2.titleLab.hidden = YES;
            }
            return cell2;
        }
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 1)
        {
            KHYAnnounceCell *cell3 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier3];
            if (!cell3)
            {
                cell3 = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([KHYAnnounceCell class]) owner:nil options:nil]objectAtIndex:2];
            }
            
            return cell3;
        }
        else
        {
            KHYAnnounceCell *cell4 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
            if (!cell4)
            {
                cell4 = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([KHYAnnounceCell class]) owner:nil options:nil]objectAtIndex:0];
                cell4.accessoryType = UITableViewCellAccessoryNone;
            }
            cell4.titleLab.text = @"活动简介";
            cell4.contentTF.hidden = YES;
            return cell4;
        }
        
    }
    else
    {
        if (indexPath.row == 1)
        {
            KHYAnnounceCell *cell5 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier4];
            if (!cell5)
            {
                cell5 = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([KHYAnnounceCell class]) owner:nil options:nil]objectAtIndex:3];
            }
            
            return cell5;
        }
        else
        {
            KHYAnnounceCell *cell6 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier5];
            if (!cell6)
            {
                cell6 = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([KHYAnnounceCell class]) owner:nil options:nil]objectAtIndex:4];
            }
            
            return cell6;
        }
    }
    
    
    
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

- (void)publishActivity
{
    
    [MBProgressHUD showMessage:@"发布活动" toView:self.view];
}

- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    
}



@end
