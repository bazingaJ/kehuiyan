//
//  KHYActivityListViewController.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/10.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYActivityListViewController.h"
#import "KHYActivityListCell.h"
#import "KHYParticipationViewController.h"
#import "KHYHtmlPageViewController.h"
#import "KHYActivityModel.h"

static NSString *const cellIdentifier = @"KHYActivityListCell1";

@interface KHYActivityListViewController ()<JXActivityCellDelegate>

@end

@implementation KHYActivityListViewController

- (void)viewDidLoad {
    
    [self setHiddenHeaderRefresh:YES];
    
    self.bottomH = 50;
    if ([[HelperManager CreateInstance].position_id isEqualToString:@"4"]) {
        self.bottomH = 100;
    }
    
    [super viewDidLoad];
    
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.backgroundColor = BACK_COLOR;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
    view.backgroundColor = BACK_COLOR;
    self.tableView.tableHeaderView = view;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    // 请求接口
    [self requestActivityList];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KHYActivityListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell =[[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([KHYActivityListCell class]) owner:nil options:nil]objectAtIndex:0];
    }
    cell.delegate = self;
    cell.model = self.dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    KHYActivityModel *model = self.dataArr[indexPath.row];
    KHYHtmlPageViewController *webView = [[KHYHtmlPageViewController alloc] init];
    webView.title = @"活动详情";
    webView.url = model.url;
    [self.navigationController pushViewController:webView animated:YES];
    
}

- (void)lookUpBtnClick:(UIButton *)button
{
    
    KHYActivityListCell *cell = (KHYActivityListCell *)button.superview.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    KHYParticipationViewController *vc = [[KHYParticipationViewController alloc] init];
    vc.model = self.dataArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
/**
 请求活动列表
 */
- (void)requestActivityList
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"app"] = @"home";
    param[@"act"] = @"getActivityList";
    param[@"cate_id"] = self.selectIndex;
    if (![[HelperManager CreateInstance].position_id isEqualToString:@"4"] && ![[HelperManager CreateInstance].position_id isEqualToString:@"20"]) {
        param[@"mem_id"] = self.memberID;
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
                               self.dataArr = [KHYActivityModel mj_objectArrayWithKeyValuesArray:dict[@"list"]];
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
