//
//  KHYHomeViewController.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/8.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYHomeViewController.h"
#import <zhPopupController/zhPopupController.h>
#import "KHYHomeLeftView.h"
#import "KHYHomeTopView.h"
#import "KHYHomeMenuView.h"
#import "KHYTaskViewController.h"
#import "KHYScheduleViewController.h"
#import "KHYCustomerViewController.h"
#import "KHYMineMessageViewController.h"
#import "KHYMineSettingViewController.h"
#import "KHYMineInfoViewController.h"
#import "KHYStatisticsViewController.h"
#import "KHYHomeViewController+Version.h"
#import "KHYTaskAddViewController.h"
#import "KHYCustomerEditViewController.h"
#import "KHYOrganizationViewController.h"

@interface KHYHomeViewController ()<KHYHomeMenuViewDelegate> {
    NSMutableDictionary *titleDic;
}

@property (nonatomic, strong) KHYHomeTopView *topView;
@property (nonatomic, strong) KHYHomeMenuView *menuView;

@end

@implementation KHYHomeViewController

/**
 *  顶部视图
 */
- (KHYHomeTopView *)topView {
    if(!_topView) {
        _topView = [[KHYHomeTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    }
    return _topView;
}

/**
 *  菜单模块
 */
- (KHYHomeMenuView *)menuView {
    if(!_menuView) {
        _menuView = [[KHYHomeMenuView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180-90)];
        [_menuView setDelegate:self];
    }
    return _menuView;
}

- (void)viewDidLoad {
    [self setHiddenHeaderRefresh:YES];
    [self setLeftButtonItemImageName:@"home_icon_leftMenu"];
    [self setRightButtonItemImageName:@"home_icon_email"];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"玉鹤鸣";
    
    //加载顶部视图
    self.tableView.tableHeaderView = [self topView];
    
    //设置标题
    [self.dataArr removeAllObjects];
//    [self.dataArr addObject:@[@"home_icon_matter",@"待办事项"]];
    [self.dataArr addObject:@[@"home_icon_tongji",@"当日统计"]];
    
    //设置数据源
    titleDic = [NSMutableDictionary dictionary];
    //代办事项
//    [titleDic setValue:@[@"审批代办",@"任务代办"] forKey:@"1"];
    //当日统计
//    [titleDic setValue:@[@"拜访客户数",@"新增用户数",@"销量"] forKey:@"2"];
    [titleDic setValue:@[@"拜访客户数",@"新增用户数"] forKey:@"1"];
    [titleDic setObject:@[@"0",@"0"] forKey:@"info"];
    //获取用户信息
    [self getUserInfo];
    
    //版本检测
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self checkSystemVersion];
    });

    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestData];
}
/**
 *  左侧菜单
 */
- (void)leftButtonItemClick {
    NSLog(@"左侧菜单");
    
    KHYHomeLeftView *leftView = [[KHYHomeLeftView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-40, SCREEN_HEIGHT)];
    leftView.didClickItem = ^(KHYHomeLeftView *view, NSInteger index) {
        NSLog(@"回调成功索引值:%zd",index);
        [self.zh_popupController dismiss];
        
        switch (index) {
            case 0: {
                //任务管理
                KHYTaskViewController *taskView = [[KHYTaskViewController alloc] init];
                [self.navigationController pushViewController:taskView animated:YES];
    
                break;
            }
            case 1: {
                //销售管理
    
                break;
            }
            case 2: {
                //学术会议管理
    
                break;
            }
            case 3: {
                //患教管理
    
                break;
            }
            case 4: {
                //客户管理
                KHYCustomerViewController *customerView = [[KHYCustomerViewController alloc] init];
                [self.navigationController pushViewController:customerView animated:YES];
    
                break;
            }
            case 5: {
                //统计数据
                
                KHYStatisticsViewController *statisticsView = [[KHYStatisticsViewController alloc] init];
                [self.navigationController pushViewController:statisticsView animated:YES];
    
                break;
            }
            case 6: {
                //个人资料管理
                
                KHYMineInfoViewController *infoView = [[KHYMineInfoViewController alloc] init];
                [self.navigationController pushViewController:infoView animated:YES];
    
                break;
            }
            case 7: {
                //组织架构
                
                KHYOrganizationViewController *orgView = [[KHYOrganizationViewController alloc] init];
                orgView.isTask = NO;
                [self.navigationController pushViewController:orgView animated:YES];
    
                break;
            }
            case 8: {
                //设置
                
                KHYMineSettingViewController *settingView = [[KHYMineSettingViewController alloc] init];
                [self.navigationController pushViewController:settingView animated:YES];
    
                break;
            }
    
            default:
                break;
        }
        
    };
    self.zh_popupController = [zhPopupController new];
    self.zh_popupController.layoutType = zhPopupLayoutTypeLeft;
    self.zh_popupController.allowPan = YES;
    [self.zh_popupController presentContentView:leftView];
    
}

/**
 *  右侧邮件
 */
- (void)rightButtonItemClick {
    NSLog(@"右侧邮件");
    
    //登录验证
    if(![[HelperManager CreateInstance] isLogin:NO completion:nil]) return;
    
    KHYMineMessageViewController *messageView = [[KHYMineMessageViewController alloc] init];
    [self.navigationController pushViewController:messageView animated:YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 3;
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==0) {
        return 1;
    }else{
        NSArray *titleArr = [titleDic objectForKey:[NSString stringWithFormat:@"%zd",section]];
        return [titleArr count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section==0) {
        return 10;
    }
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0) {
        return 180-90;
    }
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section==0) return [UIView new];
    
    //创建“背景层”
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    [backView setBackgroundColor:[UIColor whiteColor]];
    
    NSArray *itemArr = [self.dataArr objectAtIndex:section-1];
    
    //创建“图标”
    UIImage *img = [UIImage imageNamed:itemArr[0]];
    CGFloat tW = img.size.width;
    CGFloat tH = img.size.height;
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (45-tH)/2, tW, tH)];
    [imgView setImage:img];
    [backView addSubview:imgView];
    
    //创建“标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(35, 10, SCREEN_WIDTH-45, 25)];
    [lbMsg setText:itemArr[1]];
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
    static NSString *cellID = @"KHYHomeViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
    }
    for (UIView * view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    if(indexPath.section==0) {
        //功能菜单区块
        [cell.contentView addSubview:[self menuView]];
        
    }else{
        
        NSArray *titleArr = [titleDic objectForKey:[NSString stringWithFormat:@"%zd",indexPath.section]];
        
        //创建“标题”
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 150, 25)];
        [lbMsg setText:[titleArr objectAtIndex:indexPath.row]];
        [lbMsg setTextColor:COLOR3];
        [lbMsg setTextAlignment:NSTextAlignmentLeft];
        [lbMsg setFont:FONT16];
        [cell.contentView addSubview:lbMsg];
        
        //创建“内容”
        UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(160, 10, SCREEN_WIDTH-190, 25)];
        [lbMsg2 setTextColor:MAIN_COLOR];
        [lbMsg2 setTextAlignment:NSTextAlignmentRight];
        [lbMsg2 setFont:FONT16];
        [cell.contentView addSubview:lbMsg2];
        
        switch (indexPath.section) {
            case 1: {
                switch (indexPath.row) {
                    case 0: {
                        //审批代办
                        [lbMsg2 setText:titleDic[@"info"][0]];
                        
                        break;
                    }
                    case 1: {
                        //任务代办
                        [lbMsg2 setText:titleDic[@"info"][1]];
                        
                        break;
                    }
                        
                    default:
                        break;
                }
                
                break;
            }
            case 2: {
                switch (indexPath.row) {
                    case 0: {
                        //拜访客户数
                        [lbMsg2 setText:@"12"];
                        
                        break;
                    }
                    case 1: {
                        //新增用户数
                        [lbMsg2 setText:@"13"];
                        
                        break;
                    }
                    case 2: {
                        //销量
                        [lbMsg2 setText:@"14"];
                        
                        break;
                    }
                        
                    default:
                        break;
                }
                
                break;
            }
                
            default:
                break;
        }
        
        //创建“右侧尖头”
        UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20, 17.5, 5.5, 10)];
        [imgView2 setImage:[UIImage imageNamed:@"right_icon_gray"]];
        [cell.contentView addSubview:imgView2];
        
        //创建“分割线”
        if(indexPath.row<[titleArr count]-1) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5)];
            [lineView setBackgroundColor:LINE_COLOR];
            [cell.contentView addSubview:lineView];
        }
        
    }
    
    return cell;
}

/**
 *  菜单点击委托代理
 */
- (void)KHYHomeMenuViewAtIndexClick:(NSInteger)tIndex {
    NSLog(@"菜单点击委托代理：%zd",tIndex);
    
    switch (tIndex) {
        case 0: {
            //新建任务
            
            KHYTaskAddViewController *taskAdd = [[KHYTaskAddViewController alloc] init];
            [self.navigationController pushViewController:taskAdd animated:YES];
            
            break;
        }
        case 1: {
            //新增客户
            
            KHYCustomerEditViewController *addView = [[KHYCustomerEditViewController alloc] init];
            [self.navigationController pushViewController:addView animated:YES];
            
            break;
        }
        case 2: {
            //查看日程
        
            KHYScheduleViewController *scheduleView = [[KHYScheduleViewController alloc] init];
            [self.navigationController pushViewController:scheduleView animated:YES];
            
            break;
        }
        case 3: {
            //发起报销
            
            break;
        }
        case 4: {
            //发起公告
            
            break;
        }
        case 5: {
            //发起请假
            
            break;
        }
            
        default:
            break;
    }
    
}

- (void)requestData
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:@"home" forKey:@"app"];
    [param setObject:@"getHomeInfo" forKey:@"act"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if ([code isEqualToString:SUCCESS])
        {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            [titleDic removeObjectForKey:@"info"];
            [titleDic setObject:@[dataDic[@"visit_count"],dataDic[@"new_count"]] forKey:@"info"];
            [self.tableView reloadData];
        }
        else
        {
            [MBProgressHUD showMessage:msg toView:self.view];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
    }];
}

- (void)getUserInfo
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"getMyInfo" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].user_id forKey:@"user_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            
            NSDictionary *dataDic = [json objectForKey:@"data"];
            //预先清除
            [[HelperManager CreateInstance] clearAcc];
            
            //设置本地缓存
            [self setUserDefaultInfo:dataDic];
            
            
        }else{
            [MBProgressHUD showMessage:msg toView:self.view];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
