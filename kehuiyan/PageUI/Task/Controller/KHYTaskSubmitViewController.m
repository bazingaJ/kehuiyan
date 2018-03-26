//
//  KHYTaskSubmitViewController.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/3/9.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYTaskSubmitViewController.h"

@interface KHYTaskSubmitViewController () {
    //基本信息
    NSMutableArray *titleArr;
}

//任务目标
@property (nonatomic, strong) ZTELimitTextView *limitView;

@end

@implementation KHYTaskSubmitViewController

- (void)viewDidLoad {
    [self setBottomH:45];
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"任务提交";
    
    //设置数据源
    titleArr = [NSMutableArray array];
    [titleArr addObject:@[@"任务类型",@"0"]];
    [titleArr addObject:@[@"任务周期",@"0"]];
    [titleArr addObject:@[@"任务责任人",@"1"]];
    [titleArr addObject:@[@"任务参与人",@"1"]];
    [titleArr addObject:@[@"任务地区",@"0"]];
    
    //创建“任务提交”按钮
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-45, SCREEN_WIDTH,45)];
    [btnFunc setTitle:@"确定" forState:UIControlStateNormal];
    [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT17];
    [btnFunc setBackgroundColor:GREEN_COLOR];
    [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnFunc];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(!self.taskModel) return 0;
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==0) {
        return titleArr.count;
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
    switch (indexPath.section) {
        case 0:
            return 45;
            
            break;
        case 1:
            return self.taskModel.cellH;
            
            break;
        case 2:
            return self.taskModel.cellH2;
            
            break;
        case 3:
            return 105;
            
            break;
            
        default:
            break;
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
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, backView.frame.size.width-20, 25)];
    if(section==1) {
        [lbMsg setText:@"任务目标"];
    }else if(section==2) {
        [lbMsg setText:@"任务计划"];
    }else if(section==3) {
        [lbMsg setText:@"任务小结"];
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
    static NSString *cellIndentifier = @"KHYTaskSubmitViewControllerCell";
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
            
            NSArray *itemArr = [titleArr objectAtIndex:indexPath.row];
            
            //创建“标题”
            UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 25)];
            [lbMsg setText:itemArr[0]];
            [lbMsg setTextColor:COLOR3];
            [lbMsg setTextAlignment:NSTextAlignmentLeft];
            [lbMsg setFont:FONT16];
            [cell.contentView addSubview:lbMsg];
            
            //创建“内容”
            UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, SCREEN_WIDTH-110, 25)];
            [lbMsg2 setTextColor:COLOR9];
            [lbMsg2 setTextAlignment:NSTextAlignmentRight];
            [lbMsg2 setFont:FONT16];
            [lbMsg2 setTag:100+indexPath.row];
            [cell.contentView addSubview:lbMsg2];
            
            switch (indexPath.row) {
                case 0: {
                    //任务类型
                    [lbMsg2 setText:self.taskModel.task_type_text];
                    
                    break;
                }
                case 1: {
                    //任务周期
                    [lbMsg2 setText:self.taskModel.task_cycle_text];
                    
                    break;
                }
                case 2: {
                    //任务责任人
                    [lbMsg2 setText:self.taskModel.leader_name];
                    
                    break;
                }
                case 3: {
                    //任务参与人
                    [lbMsg2 setText:self.taskModel.takeIner_name];
                    
                    break;
                }
                case 4: {
                    //任务地区
                    [lbMsg2 setText:self.taskModel.city_name];
                    
                    break;
                }
                    
                default:
                    break;
            }
            
            //创建“分割线”
            if(indexPath.row<[titleArr count]-1) {
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5)];
                [lineView setBackgroundColor:LINE_COLOR];
                [cell.contentView addSubview:lineView];
            }
            
            break;
        }
        case 1: {
            //任务目标
            
            NSString *contentStr = self.taskModel.task_target;
            UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, self.taskModel.cellH-20)];
            [lbMsg setTextAlignment:NSTextAlignmentLeft];
            [lbMsg setTextColor:COLOR9];
            [lbMsg setFont:FONT14];
            [lbMsg setNumberOfLines:0];
            if(!IsStringEmpty(contentStr)) {
                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
                NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
                [style setLineSpacing:5.0f];
                [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, contentStr.length)];
                [lbMsg setAttributedText:attStr];
            }
            [cell.contentView addSubview:lbMsg];
            
            break;
        }
        case 2: {
            //行动计划
            
            NSString *contentStr = self.taskModel.task_plain;
            UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, self.taskModel.cellH2-20)];
            [lbMsg setTextAlignment:NSTextAlignmentLeft];
            [lbMsg setTextColor:COLOR9];
            [lbMsg setFont:FONT14];
            [lbMsg setNumberOfLines:0];
            if(!IsStringEmpty(contentStr)) {
                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
                NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
                [style setLineSpacing:5.0f];
                [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, contentStr.length)];
                [lbMsg setAttributedText:attStr];
            }
            [cell.contentView addSubview:lbMsg];
            
            break;
        }
        case 3: {
            //任务小结
            
            WS(weakSelf);
            self.limitView = [[ZTELimitTextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 105)];
            self.limitView.limitNum = 200;
            if(IsStringEmpty(self.taskModel.task_summary)) {
                self.limitView.placeHolder = @"请输入任务小结";
            }else{
                self.limitView.placeHolder = @"";
                self.limitView.textView.text = self.taskModel.task_summary;
            }
            self.limitView.textViewDidChange = ^(NSString *content) {
                NSLog(@"当前输入的文本:%@",content);
                
                weakSelf.taskModel.task_summary = content;
            };
            [cell.contentView addSubview:self.limitView];
            
            break;
        }
            
        default:
            break;
    }
    
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

/**
 *  确定按钮事件
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"确定");
    [self.view endEditing:YES];
    
    //任务ID
    if(IsStringEmpty(self.taskModel.task_id)) {
        [MBProgressHUD showError:@"任务ID不能为空" toView:self.view];
        return;
    }
    //任务小结
    if(IsStringEmpty(self.taskModel.task_summary)) {
        [MBProgressHUD showError:@"请输入任务小结" toView:self.view];
        return;
    }

    [MBProgressHUD showMsg:@"任务提交中..." toView:self.view];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"task" forKey:@"app"];
    [param setValue:@"submitTask" forKey:@"act"];
    [param setValue:self.taskModel.task_id forKey:@"task_id"];
    [param setValue:self.taskModel.task_summary forKey:@"summary"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        [MBProgressHUD hideHUD:self.view];
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            [MBProgressHUD showSuccess:@"任务提交成功" toView:self.view];
            
            //延迟0.5秒返回
            kDISPATCH_MAIN_AFTER(0.5, ^{
                
                if(self.callBack) {
                    self.callBack();
                    [self.navigationController popViewControllerAnimated:YES];
                }
                
            });
            
        }else{
            [MBProgressHUD showError:msg toView:self.view];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        [MBProgressHUD hideHUD:self.view];
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
