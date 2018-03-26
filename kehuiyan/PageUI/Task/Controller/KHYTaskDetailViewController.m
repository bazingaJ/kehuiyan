//
//  KHYTaskDetailViewController.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/3/8.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYTaskDetailViewController.h"
#import "KHYTaskModel.h"
#import "KHYTaskSubmitViewController.h"

@interface KHYTaskDetailViewController () {
    KHYTaskModel *taskModel;
    
    //基本信息
    NSMutableArray *titleArr;
}

@property (nonatomic, strong) UIButton *btnFunc;

@property (nonatomic, assign) NSInteger sectionNum;

@end

@implementation KHYTaskDetailViewController

- (void)viewDidLoad {
    [self setBottomH:45];
    [super viewDidLoad];
    // 设置初始section 为3个
    self.sectionNum = 3;
    self.title = @"任务详情";

    //设置数据源
    titleArr = [NSMutableArray array];
    [titleArr addObject:@[@"任务类型",@"0"]];
    [titleArr addObject:@[@"任务周期",@"0"]];
    [titleArr addObject:@[@"任务责任人",@"1"]];
    [titleArr addObject:@[@"任务参与人",@"1"]];
    [titleArr addObject:@[@"任务地区",@"0"]];
    
    //创建“任务提交”按钮
    self.btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-45, SCREEN_WIDTH,45)];
    [self.btnFunc setTitle:@"任务提交" forState:UIControlStateNormal];
    [self.btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnFunc.titleLabel setFont:FONT17];
    [self.btnFunc setBackgroundColor:GREEN_COLOR];
    [self.btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnFunc];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(!taskModel) return 0;
    return self.sectionNum;
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
            return taskModel.cellH;
            
            break;
        case 2:
            return taskModel.cellH2;
            
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
    if(section==1)
    {
        [lbMsg setText:@"任务目标"];
    }
    else if(section==2)
    {
        [lbMsg setText:@"任务计划"];
    }
    else if (section == 3)
    {
        lbMsg.text = @"任务小结";
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
    static NSString *cellIndentifier = @"KHYTaskDetailViewControllerCell";
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
                    [lbMsg2 setText:taskModel.task_type_text];
                    
                    break;
                }
                case 1: {
                    //任务周期
                    [lbMsg2 setText:taskModel.task_cycle_text];
                    
                    break;
                }
                case 2: {
                    //任务责任人
                    [lbMsg2 setText:taskModel.leader_name];
                    
                    break;
                }
                case 3: {
                    //任务参与人
                    [lbMsg2 setText:taskModel.takeIner_name];
                    
                    break;
                }
                case 4: {
                    //任务地区
                    [lbMsg2 setText:taskModel.city_name];
                    
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
            
            NSString *contentStr = taskModel.task_target;
            UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, taskModel.cellH-20)];
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

            NSString *contentStr = taskModel.task_plain;
            UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, taskModel.cellH2-20)];
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
            //行动计划
            
            NSString *contentStr = taskModel.task_summary;
            UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, taskModel.cellH3-20)];
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
            
        default:
            break;
    }
    
    return cell;
}

/**
 *  任务提交
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"任务提交");
    
    KHYTaskSubmitViewController *submitView = [[KHYTaskSubmitViewController alloc] init];
    submitView.taskModel = taskModel;
    submitView.callBack = ^{
        NSLog(@"回调成功");
        
        //隐藏任务提交按钮
        [self.btnFunc setHidden:YES];
        //重置tableView高度
        [self.tableView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT)];
        
    };
    [self.navigationController pushViewController:submitView animated:YES];
    
}

/**
 *  获取信息
 */
- (void)getDataList:(BOOL)isMore {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"task" forKey:@"app"];
    [param setValue:@"getTaskInfo" forKey:@"act"];
    [param setValue:self.task_id forKey:@"task_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            taskModel = [KHYTaskModel mj_objectWithKeyValues:dataDic];
            if (taskModel.status == 1 || taskModel.status == 4)
            {
                self.sectionNum = 3;
                self.btnFunc.hidden = NO;
                self.tableView.height = SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-45;
            }
            else
            {
                self.sectionNum = 4;
                self.btnFunc.hidden = YES;
                self.tableView.height = SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT;
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
