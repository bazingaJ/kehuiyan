//
//  KHYMineMessageViewController.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/24.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYMineMessageViewController.h"
#import "KHYMineMessageCell.h"
#import "KHYMineMessageDetailViewController.h"

@interface KHYMineMessageViewController ()<KHYMineMessageCellDelegate,SWTableViewCellDelegate>

@end

@implementation KHYMineMessageViewController

- (void)viewDidLoad {
    [self setShowFooterRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的消息";
    
}

/**
 *  左侧按钮点击事件
 */
- (void)leftButtonItemClick {
    if(self.isPush) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"KHYMineMessageCell";
    KHYMineMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[KHYMineMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    KHYMessageModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.section];
    }
    [cell setRightUtilityButtons:[self rightButtons:model] WithButtonWidth:80];
    [cell setDelegate:self];
    [cell setMessageModel:model indexPath:indexPath];
    
    return cell;
}

- (NSArray *)rightButtons:(KHYMessageModel *)model
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
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
    
    KHYMineMessageCell *tCell = (KHYMineMessageCell *)cell;
    NSIndexPath *indexPath = tCell.indexPath;
    
    KHYMessageModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.section];
    }
    if(!model) return;
    
    UIAlertController * aler = [UIAlertController alertControllerWithTitle:@"警告" message:@"您确定删除吗？删除后将无法恢复？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"确定删除");
        
        [MBProgressHUD showMsg:@"删除中..." toView:self.view];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setValue:@"ucenter" forKey:@"app"];
        [param setValue:@"dropMessage" forKey:@"act"];
        [param setValue:model.system_message_id forKey:@"system_message_id"];
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

- (void)KHYMineMessageCellClick:(KHYMessageModel *)model indexPath:(NSIndexPath *)indexPath {
    
    //消息详情
    KHYMineMessageDetailViewController *detailView = [[KHYMineMessageDetailViewController alloc] init];
    detailView.messageInfo = model;
    detailView.callBack = ^(){
        model.is_read = @"1";
        
        //刷新当前单元格
        NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] initWithIndex:indexPath.section];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    [self.navigationController pushViewController:detailView animated:YES];
}

/**
 *  获取数据
 */
- (void)getDataList:(BOOL)isMore {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"getMessageList" forKey:@"act"];
    [param setValue:@(self.pageIndex) forKey:@"page"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            if(dataDic && [dataDic count]>0) {
                NSArray *dataArr = [dataDic objectForKey:@"list"];
                for (NSDictionary *itemDic in dataArr) {
                    [self.dataArr addObject:[KHYMessageModel mj_objectWithKeyValues:itemDic]];
                }
                
                //当前总数
                NSString *dataNum = [dataDic objectForKey:@"count"];
                if(!IsStringEmpty(dataNum)) {
                    self.totalNum = [dataNum intValue];
                }else{
                    self.totalNum = 0;
                }
            }
            
            //设置空白页面
            
            [self.tableView emptyViewShowWithDataType:EmptyViewTypeData
                                              isEmpty:self.dataArr.count<=0
                                  emptyViewClickBlock:nil];
            
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
