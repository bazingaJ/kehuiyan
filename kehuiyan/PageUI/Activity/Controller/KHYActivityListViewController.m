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

static NSString *const cellIdentifier = @"KHYActivityListCell1";

@interface KHYActivityListViewController ()<JXActivityCellDelegate>

@end

@implementation KHYActivityListViewController

- (void)viewDidLoad {
    
    [self setHiddenHeaderRefresh:YES];
    self.bottomH = 100;
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
    NSLog(@"========%@",self.selectIndex);
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
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
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    KHYHtmlPageViewController *webView = [[KHYHtmlPageViewController alloc] init];
    webView.title = @"活动详情";
    webView.url = @"https://www.baidu.com";
    [self.navigationController pushViewController:webView animated:YES];
    
}

- (void)lookUpBtnClick:(UIButton *)button
{
    
//    KHYActivityListCell *cell = (KHYActivityListCell *)button.superview.superview;
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    KHYParticipationViewController *vc = [[KHYParticipationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
