//
//  KHYDeliverViewController.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/12.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYDeliverViewController.h"
#import "KHYLogisticsViewController.h"

static NSString *const currentTitle = @"发货";

static NSString *const cellIdentifier = @"KHYDeliverCell1";

static NSString *const cellIdentifier1 = @"KHYDeliverCell2";

@interface KHYDeliverViewController ()

@end

@implementation KHYDeliverViewController

- (void)viewDidLoad {
    
    [self setHiddenHeaderRefresh:YES];
    self.bottomH = 50;
    [super viewDidLoad];
    self.title = currentTitle;
//    [self prepareForData];
    [self createUI];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
- (void)prepareForData
{
    
    
}

- (void)createUI
{
 
    UIButton *deliverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deliverBtn setTitle:@"确定" forState:UIControlStateNormal];
    [deliverBtn setBackgroundColor:BLUE_COLOR];
    deliverBtn.titleLabel.font = FONT16;
    [deliverBtn addTarget:self action:@selector(containBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deliverBtn];
    [deliverBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
}

#pragma mark - table view datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 45.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIView *lineView = [UIView new];
            lineView.backgroundColor = LINE_COLOR;
            lineView.frame = CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5);
            [cell.contentView addSubview:lineView];
           
        }
        cell.textLabel.text = @"选择物流";
        cell.textLabel.textColor = COLOR3;
        cell.textLabel.font= FONT15;
        
        cell.detailTextLabel.text = @"请选择";
        if (self.logisticsString.length != 0)
        {
            cell.detailTextLabel.text = self.logisticsString;
        }
        cell.detailTextLabel.textColor = COLOR9;
        cell.detailTextLabel.font= FONT15;
        
        
        return cell;
    }
    else
    {
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        if (!cell1)
        {
            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            cell1.accessoryType = UITableViewCellAccessoryNone;
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UITextField *orderIDTF = [[UITextField alloc] init];
            orderIDTF.borderStyle = UITextBorderStyleNone;
            orderIDTF.placeholder = @"请输入物流单号";
            orderIDTF.textAlignment = NSTextAlignmentRight;
            orderIDTF.textColor = COLOR9;
            orderIDTF.font = FONT15;
            [cell1.contentView addSubview:orderIDTF];
            [orderIDTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(cell1.contentView).offset(-12);
                make.width.mas_equalTo(120);
                make.centerY.mas_equalTo(cell1.contentView.mas_centerY);
            }];
            
            UIView *lineView = [UIView new];
            lineView.backgroundColor = LINE_COLOR;
            lineView.frame = CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5);
            [cell1.contentView addSubview:lineView];
        }
        cell1.textLabel.text = @"单号";
        cell1.textLabel.textColor = COLOR3;
        cell1.textLabel.font= FONT15;
        return cell1;
            
        
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0)
    {
        KHYLogisticsViewController *vc = [[KHYLogisticsViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

/**
 确定按钮点击
 */
- (void)containBtnClick
{
    
    [MBProgressHUD showMessage:@"确定发货" toView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
