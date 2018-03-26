//
//  KHYCustomerViewController.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/23.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYCustomerViewController.h"
#import "KHYCustomerCell.h"
#import "KHYCustomerTopView.h"
#import "KHYCustomerEditViewController.h"
#import "KHYCustomerDetailViewController.h"

@interface KHYCustomerViewController ()<KHYCustomerTopViewDelegate,SWTableViewCellDelegate>

@property (nonatomic, strong) KHYCustomerTopView *topView;
@property (nonatomic, strong) NSString *searchStr;
@property (nonatomic, strong) NSString *areaStr;
@property (nonatomic, strong) NSString *hospitalStr;
@property (nonatomic, strong) NSString *officeStr;
@end

@implementation KHYCustomerViewController

/**
 *  顶部视图
 */
- (KHYCustomerTopView *)topView {
    if(!_topView) {
        _topView = [[KHYCustomerTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        _topView.delegate = self;
        [self.view addSubview:_topView];
    }
    return _topView;
}

- (void)viewDidLoad {
    [self setTopH:100];
    [self setRightButtonItemImageName:@"right_icon_add"];
    [self setShowFooterRefresh:YES];
    [super viewDidLoad];
    self.title = @"客户管理";
    //加载顶部视图
    [self topView];
    
}

/**
 *  左侧返回按钮
 */
- (void)leftButtonItemClick {
    [super leftButtonItemClick];
    
    //隐藏
    [self.topView.dropDownMenu dismiss];
    
}

/**
 *  添加客户
 */
- (void)rightButtonItemClick {
    NSLog(@"添加客户");
    
    KHYCustomerEditViewController *customerView = [[KHYCustomerEditViewController alloc] init];
    customerView.callBack = ^(KHYCustomerModel *customerModel) {
        
        [self.dataArr insertObject:customerModel atIndex:0];
        
        if(self.dataArr.count==1) {
            [self.tableView.mj_header beginRefreshing];
        }else{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView beginUpdates];
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView endUpdates];
        }
        
    };
    [self.navigationController pushViewController:customerView animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"KHYCustomerCell";
    KHYCustomerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[KHYCustomerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    KHYCustomerModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    [cell setCustomerModel:model];
    
    cell.delegate = self;
    [cell setRightUtilityButtons:[self rightButtons] WithButtonWidth:80];
    return cell;
}

- (NSArray *)rightButtons
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

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    KHYCustomerCell *tCell = (KHYCustomerCell *)cell;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tCell];
    
    KHYCustomerModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    if(!model) return;
    if (index == 0)
    {
        UIAlertController * aler = [UIAlertController alertControllerWithTitle:@"警告" message:@"您确定删除吗？删除后将无法恢复？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"确定删除");
            
            [MBProgressHUD showMsg:@"删除中..." toView:self.view];
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            [param setValue:@"customer" forKey:@"app"];
            [param setValue:@"dropCustomer" forKey:@"act"];
            [param setValue:model.doctor_id forKey:@"doctor_id"];
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
    KHYCustomerModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    
    //客户详情
    KHYCustomerDetailViewController *detailView = [[KHYCustomerDetailViewController alloc] init];
    detailView.customer_id = model.doctor_id;
    [self.navigationController pushViewController:detailView animated:YES];
}
- (void)KHYCustomerTopViewSearchBarViewClick:(NSString *)searchStr
{
    self.searchStr = searchStr;
    if ([self.searchStr isEqualToString:@""])
    {
        [MBProgressHUD showError:@"请输入搜索条件" toView:self.view];
        return;
    }
    [self requestData];
}
- (void)KHYCustomerTopViewAreaSelectClick:(NSString *)district_id
{
    self.areaStr = district_id;
    [self requestData];
}
- (void)KHYCustomerTopViewHospitalSelectClick:(NSString *)hospital_id
{
    self.hospitalStr = hospital_id;
    [self requestData];
}
- (void)KHYCustomerTopViewKeshiSelectClick:(NSString *)keshi_id
{
    self.officeStr = keshi_id;
    [self requestData];
}
- (void)requestData
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"customer" forKey:@"app"];
    [param setValue:@"getCustomerList" forKey:@"act"];
    [param setValue:self.hospitalStr forKey:@"hospital_id"];
    [param setValue:self.officeStr forKey:@"keshi_id"];
    [param setValue:self.searchStr forKey:@"doctor_name"];
    [param setValue:self.areaStr forKey:@"area_id"];
    [param setValue:@(self.pageIndex) forKey:@"page"];
    [MBProgressHUD showSimple:self.view];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            [MBProgressHUD hideHUD:self.view];
            NSDictionary *dataDic = [json objectForKey:@"data"];
            if(dataDic && [dataDic count]>0)
            {
                NSArray *dataArr = [dataDic objectForKey:@"list"];
                [self.dataArr removeAllObjects];
                self.dataArr = [KHYCustomerModel mj_objectArrayWithKeyValuesArray:dataArr];
//                for (NSDictionary *itemDic in dataArr)
//                {
//                    [self.dataArr addObject:[KHYCustomerModel mj_objectWithKeyValues:itemDic]];
//                }
                //当前总数
                NSString *dataNum = [dataDic objectForKey:@"count"];
                if(!IsStringEmpty(dataNum))
                {
                    self.totalNum = [dataNum intValue];
                }
                else
                {
                    self.totalNum = 0;
                }
            }
            else
            {
                [MBProgressHUD showMessage:@"无搜索结果" toView:self.view];
            }
        }
        else
        {
            [MBProgressHUD showError:msg toView:self.view];
        }
        [self.tableView reloadData];
        [self endDataRefresh];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        [self endDataRefresh];
        [MBProgressHUD hideHUD:self.view];
    }];
}
/**
 *  获取数据
 */
- (void)getDataList:(BOOL)isMore {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"customer" forKey:@"app"];
    [param setValue:@"getCustomerList" forKey:@"act"];
    [param setValue:@"" forKey:@"hospital_id"];
    [param setValue:@"" forKey:@"keshi_id"];
    [param setValue:@"" forKey:@"doctor_name"];
    [param setValue:@"" forKey:@"area_id"];
    [param setValue:@(self.pageIndex) forKey:@"page"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            if(dataDic && [dataDic count]>0) {
                NSArray *dataArr = [dataDic objectForKey:@"list"];
                for (NSDictionary *itemDic in dataArr) {
                    [self.dataArr addObject:[KHYCustomerModel mj_objectWithKeyValues:itemDic]];
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
