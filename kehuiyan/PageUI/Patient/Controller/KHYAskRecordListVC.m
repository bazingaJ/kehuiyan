//
//  KHYAskRecordListVC.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/17.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYAskRecordListVC.h"
#import "KHYAskRecordCell.h"
#import "KHYQuestionRecordVC.h"
#import "KHYExpertQuestionModel.h"

static NSString *const cellIdentifier = @"KHYAskRecordCell1";

@interface KHYAskRecordListVC ()

@end

@implementation KHYAskRecordListVC

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
    [self requestExpertList];
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KHYAskRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell =[[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([KHYAskRecordCell class]) owner:nil options:nil]objectAtIndex:0];
    }
    
    cell.model = self.dataArr[indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KHYQuestionRecordVC *vc = [[KHYQuestionRecordVC alloc] init];
    vc.model = self.dataArr[indexPath.row];
    vc.cate_id = self.selectIndex;
    vc.patient_id = self.patient_id;
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 请求患者提问的专家列表
 */
- (void)requestExpertList
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"app"] = @"home";
    param[@"act"] = @"getMyExpertList";
    param[@"cate_id"] = self.selectIndex;
    param[@"patient_id"] = self.patient_id;
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
                               self.dataArr = [KHYExpertQuestionModel mj_objectArrayWithKeyValuesArray:dict[@"list"]];
                               [self.tableView reloadData];
                               [self.tableView emptyViewShowWithDataType:EmptyViewTypeData
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
