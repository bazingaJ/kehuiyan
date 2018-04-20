//
//  KHYLogisticsViewController.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/12.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYLogisticsViewController.h"
#import "KHYDeliverViewController.h"

static NSString *const currentTitle = @"物流列表";

static NSString *const cellIdentifier = @"KHYLogisticsCelll1";

@interface KHYLogisticsViewController ()
@property (nonatomic, strong) NSIndexPath *selectIndex;
@end

@implementation KHYLogisticsViewController

- (void)viewDidLoad {
    
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    self.title = currentTitle;
    [self prepareForData];
    
}
- (void)prepareForData
{
    
    [self.dataArr addObject:@"顺丰"];
    [self.dataArr addObject:@"圆通"];
    [self.dataArr addObject:@"中通"];
    [self.dataArr addObject:@"申通"];
    [self.dataArr addObject:@"韵达"];
    [self.dataArr addObject:@"天天快递"];
    [self.dataArr addObject:@"百世汇通"];
    [self.dataArr addObject:@"邮政"];
    [self.dataArr addObject:@"EMS"];
    [self.dataArr addObject:@"京东"];
    [self.dataArr addObject:@"苏宁"];
    [self.dataArr addObject:@"菜鸟裹裹"];
}
#pragma mark - table view dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 45.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        // 分隔线
        UIView *lineView = [UIView new];
        lineView.backgroundColor = LINE_COLOR;
        lineView.frame = CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5);
        [cell.contentView addSubview:lineView];
    }
    cell.textLabel.text = self.dataArr[indexPath.row];
    cell.textLabel.textColor = COLOR3;
    cell.textLabel.font= FONT15;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.001f;
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (!self.selectIndex) {
        self.selectIndex = indexPath;
    }else{
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:self.selectIndex];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.selectIndex = indexPath;
    
    NSArray *viewControllers = self.navigationController.viewControllers;
    //从数组中找到上一个界面的对象
    KHYDeliverViewController *vc = [viewControllers objectAtIndex:3];
    vc.logisticsString = self.dataArr[indexPath.row];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
