//
//  KHYFilterMemberViewController.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/20.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYFilterMemberViewController.h"
#import "KHYOrderViewController.h"
#import "KHYActivityViewController.h"
#import "KHYQuestionListViewController.h"
#import "KHYOrganizationDetailVC.h"
#import "KHYPatientManageViewController.h"
#import "KHYTaskViewController.h"
#import "KHYCustomerViewController.h"

static NSString *const currentTitle = @"部门成员";

static NSString *const cellIdentifier = @"KHYFilterMemberCell1";

@interface KHYFilterMemberViewController ()

@end

@implementation KHYFilterMemberViewController

- (void)viewDidLoad {
    
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    self.title = currentTitle;
    [self requestMemberList];
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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 55.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIView *lineView = [UIView new];
        lineView.frame = CGRectMake(0, 54.5, SCREEN_WIDTH, 0.5);
        lineView.backgroundColor = LINE_COLOR;
        [cell.contentView addSubview:lineView];
    }
    NSDictionary *dic = self.dataArr[indexPath.row];
    cell.textLabel.text = dic[@"realname"];
    cell.textLabel.font = FONT16;
    cell.detailTextLabel.text = [NSString getRightStringByCurrentString:dic[@"position"]];
    cell.detailTextLabel.font = FONT11;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = self.dataArr[indexPath.row];
    if ([[NSString getRightStringByCurrentString:dic[@"user_id"]] isEqualToString:[HelperManager CreateInstance].user_id]) {
        return;
    }
    // 1.咨询列表 2.专家提问 3.患教活动 4.销售管理 5.患者管理
    NSInteger filter = [self.filterType integerValue];
    switch (filter) {
        case 10:
        {
            if ([dic[@"position_id"] isEqualToString:@"4"]) {
                // 咨询记录
                KHYQuestionListViewController *questionVC = [KHYQuestionListViewController new];
                questionVC.memberID = [NSString getRightStringByCurrentString:dic[@"user_id"]];
                questionVC.characterType = 2;
                [self.navigationController pushViewController:questionVC animated:YES];
            }
            else if([dic[@"position_id"] isEqualToString:@"20"]){
                //专家提问
                KHYQuestionListViewController *questionVC = [KHYQuestionListViewController new];
                questionVC.memberID = [NSString getRightStringByCurrentString:dic[@"user_id"]];
                questionVC.characterType = 1;
                [self.navigationController pushViewController:questionVC animated:YES];
            }
            else{
                KHYOrganizationDetailVC *vc = [[KHYOrganizationDetailVC alloc] init];
                vc.dataDict = dic;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
        case 3:
        {
            //患教管理
            KHYActivityViewController *vc = [[KHYActivityViewController alloc] init];
            vc.member_id = [NSString getRightStringByCurrentString:dic[@"user_id"]];
            vc.selectIndex = 0;
            vc.title = @"患教管理";
            vc.menuViewStyle = WMMenuViewStyleLine;
            vc.automaticallyCalculatesItemWidths = YES;
            vc.progressViewIsNaughty = YES;
            vc.progressWidth = 70;
            vc.titleSizeSelected = 18;
            vc.titleColorSelected = MAIN_COLOR;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 4:
        {
            // 销售管理
            KHYOrderViewController *vc = [[KHYOrderViewController alloc] init];
            vc.memberID = [NSString getRightStringByCurrentString:dic[@"user_id"]];
            vc.selectIndex = 0;
            vc.title = @"直销订单管理";
            vc.menuViewStyle = WMMenuViewStyleLine;
            vc.automaticallyCalculatesItemWidths = YES;
            vc.progressViewIsNaughty = YES;
            vc.progressWidth = SCREEN_WIDTH / 4;
            vc.titleSizeSelected = 18;
            vc.titleColorSelected = kRGB(89, 189, 237);
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:
        {
            //患者管理
            KHYPatientManageViewController *vc = [[KHYPatientManageViewController alloc] init];
            vc.member_id = [NSString getRightStringByCurrentString:dic[@"user_id"]];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 6:
        {
            // 任务管理
            KHYTaskViewController *vc = [[KHYTaskViewController alloc] init];
            vc.memberID = [NSString getRightStringByCurrentString:dic[@"user_id"]];
            vc.isMine = @"2";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 7:
        {
            // 客户管理
            KHYCustomerViewController *vc = [[KHYCustomerViewController alloc] init];
            vc.memberID = [NSString getRightStringByCurrentString:dic[@"user_id"]];
            vc.isMine = @"2";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
    }
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}



@end
