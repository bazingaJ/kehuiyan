//
//  KHYPatientInfoViewController.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/10.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYPatientInfoViewController.h"
#import "KHYAskRecordViewController.h"

static NSString *const currentTitle = @"患者资料";

static NSString *const cellIdentifier = @"PatientInfocell1";

@interface KHYPatientInfoViewController ()

@end

@implementation KHYPatientInfoViewController

- (void)viewDidLoad {
    
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    self.title = currentTitle;
    
    [self.dataArr addObject:@[@[@"头像",@""],
                              @[@"姓名",@"顾平生"],
                              @[@"性别",@"男"],
                              @[@"出生年月",@"2017-05-04"],
                              @[@"身高",@"180cm"],
                              @[@"患者标签",@"产后康复"],
                              @[@"联系方式",@"135846542987"],
                              @[@"邮箱",@"135846@qq.com"],
                              @[@"联系地址",@"江苏省  南京市  建邺区"],
                              @[@"",@"嘉陵江东街18号05栋"]]];
    [self.dataArr addObject:@[@[@"咨询记录",@""],
                              @[@"购买记录",@""]]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = self.dataArr[section];
    return arr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0 && indexPath.row == 0) return 80;
    return 45.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell1)
            {
                cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                cell1.selectionStyle = UITableViewCellSelectionStyleNone;
                UIView *view = [UIView new];
                view.frame = CGRectMake(0, 79.5, SCREEN_WIDTH, 0.5);
                view.backgroundColor = LINE_COLOR;
                [cell1.contentView addSubview:view];
            }
            cell1.textLabel.font = FONT15;
            cell1.textLabel.textColor = COLOR3;
            cell1.textLabel.text = self.dataArr[indexPath.section][indexPath.row][0];
            
            UIImageView *avatarImg = [[UIImageView alloc] init];
            avatarImg.frame = CGRectMake(SCREEN_WIDTH - 72, 10, 60, 60);
            avatarImg.image = [UIImage imageNamed:@"default_img_round_list"];
            avatarImg.layer.masksToBounds = YES;
            avatarImg.layer.cornerRadius = 30;
            [cell1.contentView addSubview:avatarImg];
            
            return cell1;
        }
        else
        {
            UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (!cell2)
            {
                cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
                cell2.selectionStyle = UITableViewCellSelectionStyleNone;
                UIView *view = [UIView new];
                view.frame = CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5);
                view.backgroundColor = LINE_COLOR;
                [cell2.contentView addSubview:view];
            }
            
            cell2.textLabel.font = FONT15;
            cell2.textLabel.textColor = COLOR3;
            cell2.textLabel.text = self.dataArr[indexPath.section][indexPath.row][0];
            
            cell2.detailTextLabel.font = FONT15;
            cell2.detailTextLabel.textColor = COLOR6;
            cell2.detailTextLabel.text = self.dataArr[indexPath.section][indexPath.row][1];
            return cell2;
        }
    }
    else
    {
        UITableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (!cell3)
        {
            cell3 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            cell3.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell3.selectionStyle = UITableViewCellSelectionStyleNone;
            UIView *view = [UIView new];
            view.frame = CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5);
            view.backgroundColor = LINE_COLOR;
            [cell3.contentView addSubview:view];
        }
        cell3.textLabel.font = FONT15;
        cell3.textLabel.textColor = COLOR3;
        cell3.textLabel.text = self.dataArr[indexPath.section][indexPath.row][0];
        
        return cell3;
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
    if (indexPath.section == 0) return;
    if (indexPath.row == 0)
    {
        // 提问记录
        KHYAskRecordViewController *vc = [[KHYAskRecordViewController alloc] init];
        vc.title = @"提问记录";
        [self.navigationController pushViewController:vc animated:YES];
        // 咨询记录
        
    }
    else
    {
        [MBProgressHUD showMessage:@"购买记录" toView:self.view];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
