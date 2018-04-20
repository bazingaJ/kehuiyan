//
//  KHYCustomerVisitViewController.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/24.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYCustomerVisitViewController.h"
#import "KHYCustomerVisitCell.h"
#import "KHYCustomerVisitTopView.h"
#import "KHYCustomerVisitEditViewController.h"

@interface KHYCustomerVisitViewController ()<KHYCustomerVisitTopViewDelegate,SWTableViewCellDelegate> {
    //开始时间
    NSString *startDate;
    //结束时间
    NSString *endDate;
}

@property (nonatomic, strong) KHYCustomerVisitTopView *topView;

@end

@implementation KHYCustomerVisitViewController

/**
 *  顶部视图
 */
- (KHYCustomerVisitTopView *)topView {
    if(!_topView) {
        _topView = [[KHYCustomerVisitTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        [_topView setDelegate:self];
        [self.view addSubview:_topView];
    }
    return _topView;
}

- (void)viewDidLoad {
    [self setTopH:45];
    if ([self.isMyself isEqualToString:@"1"]) {
        [self setRightButtonItemImageName:@"right_icon_add"];
    }
    
    [super viewDidLoad];
    self.title = @"客户拜访记录";
    //加载顶部视图
    [self topView];
    
}

/**
 *  新增客户拜访记录
 */
- (void)rightButtonItemClick {
    NSLog(@"新增客户拜访记录");
    
    KHYCustomerVisitEditViewController *visitView = [[KHYCustomerVisitEditViewController alloc] init];
    visitView.doctor_id = self.customerModel.doctor_id;
    visitView.doctor_name = self.customerModel.realname;
    visitView.callBack = ^(KHYCustomerVisitModel *model) {
        
        [self.dataArr insertObject:model atIndex:0];
        if(self.dataArr.count==1) {
            [self.tableView reloadData];
        }else{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView beginUpdates];
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView endUpdates];
        }
    };
    [self.navigationController pushViewController:visitView animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"KHYCustomerVisitCell";
    KHYCustomerVisitCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[KHYCustomerVisitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    KHYCustomerVisitModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    [cell setRightUtilityButtons:[self rightButtons:model] WithButtonWidth:80];
    [cell setDelegate:self];
    [cell setCustomerVisitModel:model indexPath:indexPath];
    
    return cell;
}

- (NSArray *)rightButtons:(KHYCustomerVisitModel *)model
{
    if ([self.isMyself isEqualToString:@"2"]) {
        return nil;
    }
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    //设置已办按钮
    UIButton *btnFunc2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnFunc2 setTitle:@"编辑" forState:UIControlStateNormal];
    [btnFunc2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnFunc2.titleLabel setFont:FONT17];
    [btnFunc2 setBackgroundColor:LINE_COLOR];
    [btnFunc2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [rightUtilityButtons addObject:btnFunc2];
    
    //设置删除按钮
    UIButton *btnFunc = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnFunc setTitle:@"删除" forState:UIControlStateNormal];
    [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT17];
    [btnFunc setBackgroundColor:RED_COLOR];
    [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [rightUtilityButtons addObject:btnFunc];
    
    return rightUtilityButtons;
}

/**
 *  滑动删除委托代理
 */
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    NSLog(@"滑动删除委托代理");
    
    KHYCustomerVisitCell *tCell = (KHYCustomerVisitCell *)cell;
    NSIndexPath *indexPath = tCell.indexPath;
    
    KHYCustomerVisitModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    if(!model) return;
    
    switch (index) {
        case 0: {
            //编辑
            
            KHYCustomerVisitEditViewController *visitView = [[KHYCustomerVisitEditViewController alloc] init];
            visitView.visitModel = model;
            visitView.isEdit = YES;
            visitView.callBack = ^(KHYCustomerVisitModel *model) {
                NSLog(@"编辑成功");
                
                [self.tableView beginUpdates];
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                [self.tableView endUpdates];
                
            };
            [self.navigationController pushViewController:visitView animated:YES];
            
            break;
        }
        case 1: {
            //删除
            
            UIAlertController * aler = [UIAlertController alertControllerWithTitle:@"警告" message:@"您确定删除吗？删除后将无法恢复？" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"确定删除");
                
                [MBProgressHUD showMsg:@"删除中..." toView:self.view];
                NSMutableDictionary *param = [NSMutableDictionary dictionary];
                [param setValue:@"customer" forKey:@"app"];
                [param setValue:@"dropVisit" forKey:@"act"];
                [param setValue:model.visit_id forKey:@"visit_id"];
                [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
                    [MBProgressHUD hideHUD:self.view];
                    NSString *msg = [json objectForKey:@"msg"];
                    NSString *code = [json objectForKey:@"code"];
                    if([code isEqualToString:SUCCESS]) {
                        [MBProgressHUD showSuccess:@"删除成功" toView:self.view];
                        
                        //延迟0.5秒执行
                        kDISPATCH_MAIN_AFTER(0.5, ^{
                            [self.tableView.mj_header beginRefreshing];
                        });
                        
                    }else{
                        [MBProgressHUD showError:msg toView:self.view];
                    }
                } failure:^(NSError *error) {
                    NSLog(@"%@",[error description]);
                    [MBProgressHUD hideHUD:self.view];
                }];
                
            }];
            [aler addAction:cancelAction];
            [aler addAction:okAction];
            [self presentViewController:aler animated:YES completion:nil];
            
            break;
        }
            
        default:
            break;
    }

}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    return YES;
}

/**
 *  时间筛选委托代理
 */
- (void)KHYCustomerVisitTopViewConfirmClick:(NSString *)startTime endTime:(NSString *)endTime {
    NSLog(@"时间筛选委托代理:%@-%@",startTime,endTime);
    
    startDate = startTime;
    endDate = endTime;
    
    [self.tableView.mj_header beginRefreshing];
    
}

/**
 *  获取数据
 */
- (void)getDataList:(BOOL)isMore {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"customer" forKey:@"app"];
    [param setValue:@"getVisitList" forKey:@"act"];
    [param setValue:self.customerModel.doctor_id forKey:@"doctor_id"];
    [param setValue:startDate forKey:@"start_data"];
    [param setValue:endDate forKey:@"end_data"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            if(dataDic && [dataDic count]>0) {
                NSArray *dataArr = [dataDic objectForKey:@"list"];
                for (NSDictionary *itemDic in dataArr) {
                    [self.dataArr addObject:[KHYCustomerVisitModel mj_objectWithKeyValues:itemDic]];
                }
                
                //当前总数
                NSString *dataNum = [dataDic objectForKey:@"count"];
                if(!IsStringEmpty(dataNum)) {
                    self.totalNum = [dataNum intValue];
                }else{
                    self.totalNum = 0;
                }
            }
        }else{
            [MBProgressHUD showError:msg toView:self.view];
        }
        [self.tableView reloadData];
        [self endDataRefresh];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
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
