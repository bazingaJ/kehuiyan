//
//  KHYComboViewController.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/13.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYComboViewController.h"
#import "KHYComboCell.h"
#import "KHYComboModel.h"
#import "KHYAnswerDetailVC.h"

static NSString *currentTitle = @"添加套餐";

static NSString *cellIdntifier = @"KHYComboCell1";

@interface KHYComboViewController ()<JXComboCellDelegate>
@property (nonatomic, strong) NSIndexPath *selectIndex;
@end

@implementation KHYComboViewController

- (void)viewDidLoad {
    
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    self.title = currentTitle;
    [self createUI];
    [self prepareForData];
}

/**
 请求套餐列表数据
 */
- (void)prepareForData
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"app"] = @"home";
    param[@"act"] = @"getPackageList";
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
                               self.dataArr = [KHYComboModel mj_objectArrayWithKeyValuesArray:dict[@"list"]];
                               [self.tableView reloadData];
                               [self.tableView emptyViewShowWithDataType:EmptyViewTypeData
                                                                 isEmpty:self.dataArr.count <= 0
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

- (void)createUI
{
    
    UIButton *containBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [containBtn setTitle:@"确定" forState:UIControlStateNormal];
    [containBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [containBtn setBackgroundColor:kRGB(89, 189, 237)];
    [containBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:containBtn];
    [containBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    KHYComboCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdntifier];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([KHYComboCell class]) owner:nil options:nil]objectAtIndex:0];
    }
    cell.delegate = self;
    cell.model = self.dataArr[indexPath.row];
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
    
    if (!self.selectIndex){
        self.selectIndex = indexPath;
    }else{
        KHYComboCell *cell = [tableView cellForRowAtIndexPath:self.selectIndex];
        cell.checkBtn.selected = NO;
    }
    KHYComboCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.checkBtn.selected = YES;
    self.selectIndex = indexPath;
}

- (void)checkBtnClick:(UIButton *)btn
{
    
    KHYComboCell *cell = (KHYComboCell *)btn.superview.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if (!self.selectIndex){
        self.selectIndex = indexPath;
    }else{
        KHYComboCell *cell = [self.tableView cellForRowAtIndexPath:self.selectIndex];
        cell.checkBtn.selected = NO;
    }
    btn.selected = YES;
    self.selectIndex = indexPath;
    
    
}

- (void)sureBtnClick
{
    
    if ([self.isAnswer isEqualToString:@"1"]){
        
        NSArray *array = self.navigationController.viewControllers;
        //从数组中找到上一个界面的对象
        KHYAnswerDetailVC *first = [array objectAtIndex:array.count-2];
        KHYComboModel *currentModel = self.dataArr[self.selectIndex.row];
        first.model = currentModel;
    }
    else{
        
        if (self.choicePackge) {
            KHYComboModel *currentModel = self.dataArr[self.selectIndex.row];
            self.choicePackge(currentModel);
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
