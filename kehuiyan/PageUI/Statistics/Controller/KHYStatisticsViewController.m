//
//  KHYStatisticsViewController.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/24.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYStatisticsViewController.h"
#import "KHYStatisticsCell.h"
#import "KHYStatisticsTopView.h"

@interface KHYStatisticsViewController ()<JXStatisticsTopViewDelegate>
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, strong) KHYStatisticsTopView *topView;
@property (nonatomic, strong) NSString *selectedStr;
@end

@implementation KHYStatisticsViewController

/**
 *  顶部视图
 */
- (KHYStatisticsTopView *)topView {
    if(!_topView) {
        _topView = [[KHYStatisticsTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        _topView.delegate = self;
        [self.view addSubview:_topView];
    }
    return _topView;
}

- (void)viewDidLoad {
    [self setTopH:100];
    [super viewDidLoad];
    
    self.title = @"数据统计";
    
    //加载顶部视图
    [self topView];
    self.selectedStr = @"1";
//    //默认展示第一项
//    [self KHYSegmentedControlSegmentClick:0];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"KHYStatisticsCell";
    KHYStatisticsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[KHYStatisticsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    NSArray *titleArr = [self.dataArr objectAtIndex:indexPath.row];
    [cell setStatisticsCell:titleArr];
    
    if (indexPath.row == 0)
    {
        [cell firstString:self.dataDic[@"befor_hop"] secondString:self.dataDic[@"hospital"]];
    }
    if (indexPath.row == 1)
    {
        [cell firstString:self.dataDic[@"befor_keshi"] secondString:self.dataDic[@"keshi"]];
    }
    if (indexPath.row == 2)
    {
        [cell firstString:self.dataDic[@"befor_doc"] secondString:self.dataDic[@"doctor"]];
    }
    if (indexPath.row == 3)
    {
        [cell firstString:self.dataDic[@"befor_visit"] secondString:self.dataDic[@"visit"]];
    }
    return cell;
}
- (void)selectedTopViewIndex:(NSInteger)index
{
    if (index == 0)
    {
        self.selectedStr = @"1";
        [self getDataList:NO];
    }
    else if (index == 1)
    {
        self.selectedStr = @"2";
        [self getDataList:NO];
    }
    else if (index == 2)
    {
        self.selectedStr = @"3";
        [self getDataList:NO];
    }
    else if (index == 3)
    {
        self.selectedStr = @"4";
        [self getDataList:NO];
    }
    else if (index == 4)
    {
        self.selectedStr = @"5";
        [self getDataList:NO];
    }
}
/**
 *  获取数据
 */
- (void)getDataList:(BOOL)isMore {
    
    //设置数据源
    [self.dataArr removeAllObjects];
    [self.dataArr addObject:@[@"tongji_icon_hospital",@"拓展医院数"]];
    [self.dataArr addObject:@[@"tongji_icon_keshi",@"拓展科室数"]];
    [self.dataArr addObject:@[@"tongji_icon_doctor",@"拓展客户数"]];
    [self.dataArr addObject:@[@"tongji_icon_visit",@"拜访次数"]];
    //    [self.dataArr addObject:@[@"tongji_icon_patient",@"关联患者数"]];
    //    [self.dataArr addObject:@[@"tongji_icon_sell",@"总销量"]];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"statistics" forKey:@"app"];
    [param setValue:@"getStatistics" forKey:@"act"];
    [param setValue:self.selectedStr forKey:@"type"];
    [HttpRequestEx postWithURL:SERVICE_URL
                        params:param
                       success:^(id json) {
                           NSString *code = [json objectForKey:@"code"];
                           NSString *msg = [json objectForKey:@"msg"];
                           if ([code isEqualToString:SUCCESS])
                           {
                               self.dataDic = [json objectForKey:@"data"];
                               NSLog(@"----%@",self.dataDic);
                               [self.tableView reloadData];
                               [self endDataRefresh];
                           }
                           else
                           {
                               [MBProgressHUD showMsg:msg toView:self.view];
                               [self endDataRefresh];
                           }
    }
                       failure:^(NSError *error) {
                           [MBProgressHUD hideHUDForView:self.view];
                           [self endDataRefresh];
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
