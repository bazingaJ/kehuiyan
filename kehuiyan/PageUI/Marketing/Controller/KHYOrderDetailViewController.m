//
//  KHYOrderUnpayViewController.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/12.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYOrderDetailViewController.h"
#import "KHYDeliverViewController.h"
#import "KHYOrderDetailCell.h"

static NSString *const currentTitle = @"订单详情";

static NSString *const cellIdentifier1 = @"KHYOrderDetailCell1";

static NSString *const cellIdentifier2 = @"KHYOrderDetailCell2";

@interface KHYOrderDetailViewController ()

@end

@implementation KHYOrderDetailViewController

- (void)viewDidLoad
{
    [self setHiddenHeaderRefresh:YES];
//    if ([self.orderType isEqualToString:@"2"])
//    {
//        self.bottomH = 50;
//        [self createUI];
//    }
    
    [super viewDidLoad];
    self.title = currentTitle;
    [self prepareForData];
}

/**
 数据装载
 */
- (void)prepareForData
{
    // 未付款
    if ([_model.status isEqualToString:@"1"])
    {
        [self.dataArr addObject:@[@[@"订单号",[NSString getRightStringByCurrentString:_model.order_num]],@[@"状态",[NSString getRightStringByCurrentString:_model.status_name]],@[@"创建时间",[NSString getRightStringByCurrentString:_model.add_date]]]];
    }
    // 待发货
    else if ([_model.status isEqualToString:@"2"])
    {
        [self.dataArr addObject:@[@[@"订单号",[NSString getRightStringByCurrentString:_model.order_num]],@[@"状态",[NSString getRightStringByCurrentString:_model.status_name]],@[@"创建时间",[NSString getRightStringByCurrentString:_model.add_date]],@[@"付款时间",[NSString getRightStringByCurrentString:_model.pay_date]]]];
    }
    // 已发货
    else if([_model.status isEqualToString:@"3"] || [_model.status isEqualToString:@"4"])
    {
        [self.dataArr addObject:@[@[@"订单号",[NSString getRightStringByCurrentString:_model.order_num]],@[@"状态",[NSString getRightStringByCurrentString:_model.status_name]],@[@"创建时间",[NSString getRightStringByCurrentString:_model.add_date]],@[@"付款时间",[NSString getRightStringByCurrentString:_model.pay_date]],@[@"发货时间",[NSString getRightStringByCurrentString:_model.delivery_date]],@[@"选择物流",[NSString getRightStringByCurrentString:_model.deliver_type_name]],@[@"单号",[NSString getRightStringByCurrentString:_model.deliver_no]]]];
    }
    [self.dataArr addObject:@[@[@"收货人",[NSString getRightStringByCurrentString:_model.receiver_name]],@[@"电话",[NSString getRightStringByCurrentString:_model.receiver_mobile]],@[@"地址",[NSString getRightStringByCurrentString:[NSString stringWithFormat:@"%@%@",_model.receiver_city_name,_model.receiver_address]]]]];
    [self.dataArr addObject:@[@[@"套餐名称",[NSString getRightStringByCurrentString:_model.package_name]],@[@"套餐明细",[NSString getRightStringByCurrentString:_model.package_note]],@[@"商品名称",@""],@[[NSString getRightStringByCurrentString:[NSString stringWithFormat:@"共计%@件商品",_model.total_num]],[NSString getRightStringByCurrentString:[NSString stringWithFormat:@"总价：%@",_model.total_price]]]]];
    [self.dataArr addObject:@[@[@"所属营养顾问",[NSString getRightStringByCurrentString:_model.member_name]],@[@"患者",[NSString getRightStringByCurrentString:_model.patient_name]]]];
    
}

- (void)createUI
{
    
    UIButton *deliverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deliverBtn setTitle:@"发货" forState:UIControlStateNormal];
    [deliverBtn setBackgroundColor:BLUE_COLOR];
    deliverBtn.titleLabel.font = FONT16;
    [deliverBtn addTarget:self action:@selector(deliverBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deliverBtn];
    [deliverBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
}
#pragma mark - table view datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSArray *arr = self.dataArr[section];
    return arr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 2 && indexPath.row == 2){
        if (_model.product_list.count == 1) {
            return 50;
        }else if (_model.product_list.count == 2){
            return 70;
        }else {
            return 90;
        }
    }
    
    return 45.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2 && indexPath.row == 2)
    {
        KHYOrderDetailCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
        if (!cell1)
        {
            cell1 = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([KHYOrderDetailCell class]) owner:nil options:nil]objectAtIndex:0];
            
        }
        if (_model.product_list.count > 0) {
            cell1.productArr = _model.product_list;
        }
        
        return cell1;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIView *lineView = [UIView new];
            lineView.frame = CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5);
            lineView.backgroundColor = LINE_COLOR;
            [cell.contentView addSubview:lineView];
            
        }
        cell.textLabel.text = self.dataArr[indexPath.section][indexPath.row][0];
        cell.textLabel.font = FONT15;
        cell.textLabel.textColor = COLOR3;
        
        cell.detailTextLabel.text = self.dataArr[indexPath.section][indexPath.row][1];
        cell.detailTextLabel.font = FONT15;
        cell.detailTextLabel.textColor = COLOR9;
        
        if (indexPath.section == 2 && indexPath.row == 3)
        {
            
            NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总价：%@",_model.total_price]];
            [attr addAttribute:NSForegroundColorAttributeName value:kRGB(255, 0, 0) range:NSMakeRange(3, _model.total_price.length)];
            [cell.detailTextLabel setAttributedText:attr];
        }
        return cell;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.001f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 10.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    return nil;
}

/**
 发货按钮点击
 */
- (void)deliverBtnClick
{
    
    KHYDeliverViewController *vc = [[KHYDeliverViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}


@end
