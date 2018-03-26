//
//  KHYCustomerDetailViewController.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/23.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYCustomerDetailViewController.h"
#import "KHYCustomerModel.h"
#import "KHYCustomerEditViewController.h"
#import "KHYCustomerVisitViewController.h"

@interface KHYCustomerDetailViewController () {
    NSMutableArray *titleArr;
    KHYCustomerModel *customerModel;
}

@end

@implementation KHYCustomerDetailViewController

- (void)viewDidLoad {
    [self setBottomH:45];
    [self setRightButtonItemTitle:@"编辑"];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"客户详情";
    
    //设置数据源
    titleArr = [NSMutableArray array];
    [titleArr addObject:@"姓名"];
    [titleArr addObject:@"性别"];
    [titleArr addObject:@"出生年月"];
    [titleArr addObject:@"职级"];
    [titleArr addObject:@"所在地区"];
    [titleArr addObject:@"所在医院"];
    [titleArr addObject:@"学科"];
    [titleArr addObject:@"所在科室"];
    [titleArr addObject:@"所在治疗组"];
    [titleArr addObject:@"电话"];
    [titleArr addObject:@"邮箱"];
    [titleArr addObject:@"微信"];
    [titleArr addObject:@"QQ"];
    
    //创建“查看拜访记录”
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-45, SCREEN_WIDTH, 45)];
    [btnFunc setTitle:@"查看拜访记录" forState:UIControlStateNormal];
    [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT17];
    [btnFunc setBackgroundColor:GREEN_COLOR];
    [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnFunc];
    
}

/**
 *  编辑
 */
- (void)rightButtonItemClick {
    NSLog(@"编辑");
    
    KHYCustomerEditViewController *editView = [[KHYCustomerEditViewController alloc] init];
    editView.customerModel = customerModel;
    editView.callBack = ^(KHYCustomerModel *customerModel) {
        NSLog(@"回调成功");
        [self.tableView.mj_header beginRefreshing];
    };
    [self.navigationController pushViewController:editView animated:YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(!customerModel) return 0;
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==0) {
        return [titleArr count];
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section==0) {
        return 0.0001;
    }
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0) {
        return 45;
    }else if(indexPath.section==1) {
        return customerModel.cellH;
    }else if(indexPath.section==2) {
        return customerModel.cellH2;
    }
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section==0) return [UIView new];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    [backView setBackgroundColor:[UIColor whiteColor]];
    
    //创建“标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 25)];
    if(section==1) {
        [lbMsg setText:@"客户简介"];
    }else if(section==2) {
        [lbMsg setText:@"备注信息"];
    }
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT16];
    [backView addSubview:lbMsg];
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5)];
    [lineView setBackgroundColor:LINE_COLOR];
    [backView addSubview:lineView];
    
    return backView;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"KHYCustomerDetailViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    switch (indexPath.section) {
        case 0: {
            //基本信息
            
            UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 25)];
            [lbMsg setText:[titleArr objectAtIndex:indexPath.row]];
            [lbMsg setTextColor:COLOR3];
            [lbMsg setTextAlignment:NSTextAlignmentLeft];
            [lbMsg setFont:FONT16];
            [cell.contentView addSubview:lbMsg];
            
            //创建“内容”
            UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, SCREEN_WIDTH-130, 25)];
            [lbMsg2 setTextColor:COLOR9];
            [lbMsg2 setTextAlignment:NSTextAlignmentRight];
            [lbMsg2 setFont:FONT16];
            [cell.contentView addSubview:lbMsg2];
            
            switch (indexPath.row) {
                case 0: {
                    //姓名
                    [lbMsg2 setText:customerModel.realname];
                    
                    break;
                }
                case 1: {
                    //性别
                    [lbMsg2 setText:customerModel.gender_name];
                    
                    break;
                }
                case 2: {
                    //出生年月
                    [lbMsg2 setText:customerModel.birthday];
                    
                    break;
                }
                case 3: {
                    //职级
                    [lbMsg2 setText:customerModel.position_name];
                    
                    break;
                }
                case 4: {
                    //所在地区
                    [lbMsg2 setText:customerModel.city_name];
                    
                    break;
                }
                case 5: {
                    //所在医院
                    [lbMsg2 setText:customerModel.hospital_name];
                    
                    break;
                }
                case 6: {
                    //学科
                    [lbMsg2 setText:customerModel.subject_name];
                    
                    break;
                }
                case 7: {
                    //所在科室
                    [lbMsg2 setText:customerModel.keshi_name];
                    
                    break;
                }
                case 8: {
                    //治疗一组
                    [lbMsg2 setText:customerModel.treat_group];
                    
                    break;
                }
                case 9: {
                    //电话
                    [lbMsg2 setText:customerModel.mobile];
                    
                    break;
                }
                case 10: {
                    //邮箱
                    [lbMsg2 setText:customerModel.email];
                    
                    break;
                }
                case 11: {
                    //微信
                    [lbMsg2 setText:customerModel.weixin];
                    
                    break;
                }
                case 12: {
                    //QQ
                    [lbMsg2 setText:customerModel.qq];
                    
                    break;
                }
                    
                default:
                    break;
            }
            
            //创建“分割线”
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5)];
            [lineView setBackgroundColor:LINE_COLOR];
            [cell.contentView addSubview:lineView];
            
            break;
        }
        case 1: {
            //医生简介
            
            NSString *contentStr = customerModel.intro;
            UILabel *lbMsg4 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, customerModel.cellH-20)];
            [lbMsg4 setTextAlignment:NSTextAlignmentLeft];
            [lbMsg4 setTextColor:COLOR9];
            [lbMsg4 setFont:FONT14];
            [lbMsg4 setNumberOfLines:0];
            if(!IsStringEmpty(contentStr)) {
                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
                NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
                [style setLineSpacing:5.0f];
                [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, contentStr.length)];
                [lbMsg4 setAttributedText:attStr];
            }
            [cell.contentView addSubview:lbMsg4];
            
            break;
        }
        case 2: {
            //备注信息
            
            NSString *contentStr = customerModel.note;
            UILabel *lbMsg4 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, customerModel.cellH2-20)];
            [lbMsg4 setTextAlignment:NSTextAlignmentLeft];
            [lbMsg4 setTextColor:COLOR9];
            [lbMsg4 setFont:FONT12];
            [lbMsg4 setNumberOfLines:0];
            if(!IsStringEmpty(contentStr)) {
                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
                NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
                [style setLineSpacing:8.0f];
                [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, contentStr.length)];
                [lbMsg4 setAttributedText:attStr];
            }
            [cell.contentView addSubview:lbMsg4];
            
            break;
        }
            
        default:
            break;
    }
    
    return cell;
}

/**
 *  查看拜访记录
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"查看拜访记录");
    
    KHYCustomerVisitViewController *visitView = [[KHYCustomerVisitViewController alloc] init];
    visitView.customerModel = customerModel;
    [self.navigationController pushViewController:visitView animated:YES];
    
}

/**
 *  获取数据
 */
- (void)getDataList:(BOOL)isMore {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"customer" forKey:@"app"];
    [param setValue:@"getCustomerInfo" forKey:@"act"];
    [param setValue:self.customer_id forKey:@"doctor_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            customerModel = [KHYCustomerModel mj_objectWithKeyValues:dataDic];
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
