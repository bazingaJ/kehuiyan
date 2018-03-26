//
//  KHYTaskViewController.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/10.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYTaskViewController.h"
#import "KHYTaskCell.h"
#import "KHYTaskAddViewController.h"
#import "KHYTaskDropDownMenu.h"
#import "KHYTaskDetailViewController.h"

@interface KHYTaskViewController () <SWTableViewCellDelegate>{
    
    //任务类型
    NSString *task_type;
    //任务周期
    NSString *task_cycle;
    //任务状态
    NSString *status;
}

@property (nonatomic, strong) KHYTaskDropDownMenu *dropDownMenu;

@end

@implementation KHYTaskViewController

- (void)viewDidLoad {
    [self setTopH:45];
    [self setRightButtonItemImageName:@"right_icon_add"];
    [self setShowFooterRefresh:YES];
    [super viewDidLoad];
    
    self.title = @"任务管理";
    
    self.dropDownMenu = [[KHYTaskDropDownMenu alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45) titleArr:@[@"任务类型",@"任务周期",@"任务状态"]];
    WS(weakSelf);
    self.dropDownMenu.callTypeBack = ^(NSString *type_id, NSString *type_name) {
        NSLog(@"状态：%@-%@",type_id,type_name);
        //赋值
        
        task_type = type_id;
        [weakSelf.tableView.mj_header beginRefreshing];
    };
    self.dropDownMenu.callCycleBack = ^(NSString *cycle_id, NSString *cycle_name) {
        NSLog(@"周期：%@-%@",cycle_id,cycle_name);
        
        task_cycle = cycle_id;
        [weakSelf.tableView.mj_header beginRefreshing];
    };
    self.dropDownMenu.callStatusBack = ^(NSString *status_id, NSString *status_name) {
        NSLog(@"状态：%@-%@",status_id,status_name);
        
        status = status_id;
        [weakSelf.tableView.mj_header beginRefreshing];
    };
    [self.view addSubview:self.dropDownMenu];
    
}

/**
 *  左侧返回按钮事件
 */
- (void)leftButtonItemClick {
    [super leftButtonItemClick];
    
    [self.dropDownMenu dismiss];
}

/**
 *  右侧添加按钮事件
 */
- (void)rightButtonItemClick {
    NSLog(@"添加");
    [self.dropDownMenu dismiss];
    
    KHYTaskAddViewController *taskAdd = [[KHYTaskAddViewController alloc] init];
    [self.navigationController pushViewController:taskAdd animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 145;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"KHYTaskCell";
    KHYTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[KHYTaskCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    KHYTaskModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.section];
    }
    
    if (model.status == 1)
    {
        [cell setDelegate:self];
        [cell setRightUtilityButtons:[self rightButtons:model] WithButtonWidth:80];
    }
    
    [cell setTaskModel:model];
    
    return cell;
}

- (NSArray *)rightButtons:(KHYTaskModel *)model
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
//    //设置已办按钮
//    UIButton *btnFunc2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btnFunc2 setTitle:@"编辑" forState:UIControlStateNormal];
//    [btnFunc2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btnFunc2.titleLabel setFont:FONT17];
//    [btnFunc2 setBackgroundColor:LINE_COLOR];
//    [btnFunc2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
//    [rightUtilityButtons addObject:btnFunc2];
    
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

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    KHYTaskCell *tCell = (KHYTaskCell *)cell;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tCell];
    
    KHYTaskModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    if(!model) return;
    if (index == 0)
    {
        if (![model.user_id isEqualToString:[HelperManager CreateInstance].user_id])
        {
            [MBProgressHUD showError:@"暂无权限" toView:self.view];
            return;
        }
        
        UIAlertController * aler = [UIAlertController alertControllerWithTitle:@"警告" message:@"您确定删除吗？删除后将无法恢复？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"确定删除");
            
            [MBProgressHUD showMsg:@"删除中..." toView:self.view];
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            [param setValue:@"task" forKey:@"app"];
            [param setValue:@"dropTask" forKey:@"act"];
            [param setValue:model.task_id forKey:@"task_id"];
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
    }
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    KHYTaskModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.section];
    }
    
    //任务详情
    KHYTaskDetailViewController *detailView = [[KHYTaskDetailViewController alloc] init];
    detailView.task_id = model.task_id;
    [self.navigationController pushViewController:detailView animated:YES];
    
}

/**
 *  获取数据
 */
- (void)getDataList:(BOOL)isMore {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"task" forKey:@"app"];
    [param setValue:@"getTaskList" forKey:@"act"];
    [param setValue:task_type forKey:@"task_type"];
    [param setValue:task_cycle forKey:@"task_cycle"];
    [param setValue:status forKey:@"status"];
    [param setValue:@(self.pageIndex) forKey:@"page"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            if(dataDic && [dataDic count]>0) {
                NSArray *dataArr = [dataDic objectForKey:@"list"];
                for (NSDictionary *itemDic in dataArr) {
                    [self.dataArr addObject:[KHYTaskModel mj_objectWithKeyValues:itemDic]];
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
