//
//  KHYComboViewController.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/13.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYComboViewController.h"
#import "KHYComboCell.h"


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
}

- (void)createUI
{
    
    UIButton *containBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [containBtn setTitle:@"发布" forState:UIControlStateNormal];
    [containBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [containBtn setBackgroundColor:kRGB(89, 189, 237)];
    [containBtn addTarget:self action:@selector(containBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:containBtn];
    [containBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 5;
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

- (void)containBtnClick
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
