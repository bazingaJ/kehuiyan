//
//  KHYPatientInfoViewController.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/10.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYPatientInfoViewController.h"
#import "KHYAskListOutVC.h"
#import "KHYPatientInfoModel.h"
#import "KHYChatViewController.h"
#import "KHYOrderViewController.h"

static NSString *const currentTitle = @"患者资料";

static NSString *const cellIdentifier = @"PatientInfocell1";

@interface KHYPatientInfoViewController ()
@property (nonatomic, strong) KHYPatientInfoModel *model;
@end

@implementation KHYPatientInfoViewController

- (void)viewDidLoad {
    
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    self.title = currentTitle;
    [self prepareForData];
    [self.dataArr addObject:@[@[@"头像",@""],
                              @[@"姓名",@""],
                              @[@"性别",@""],
                              @[@"出生年月",@""],
                              @[@"身高",@""],
                              @[@"患者标签",@""],
                              @[@"联系方式",@""],
                              @[@"邮箱",@""],
                              @[@"联系地址",@""],
                              @[@"",@""]]];
    [self.dataArr addObject:@[@[@"咨询记录",@""],
                              @[@"提问记录",@""],
                              @[@"购买记录",@""]]];
}
- (void)prepareForData
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"app"] = @"home";
    param[@"act"] = @"getUserInfo";
    param[@"patient_id"] = self.patient_id;
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
                               self.model = [KHYPatientInfoModel mj_objectWithKeyValues:dict];
                               [self.dataArr removeAllObjects];
                               
                               [self.dataArr addObject:@[@[@"头像",[NSString getRightStringByCurrentString:_model.avatar]],
                                                         @[@"姓名",[NSString getRightStringByCurrentString:_model.realname]],
                                                         @[@"性别",[NSString getRightStringByCurrentString:_model.gender]],
                                                         @[@"出生年月",[NSString getRightStringByCurrentString:_model.birthday]],
                                                         @[@"身高",[NSString getRightStringByCurrentString:_model.height]],
                                                         @[@"患者标签",[NSString getRightStringByCurrentString:_model.cate_name]],
                                                         @[@"联系方式",[NSString getRightStringByCurrentString:_model.mobile]],
                                                         @[@"邮箱",[NSString getRightStringByCurrentString:_model.email]],
                                                         @[@"联系地址",[NSString getRightStringByCurrentString:_model.area_name]],
                                                         @[@"",[NSString getRightStringByCurrentString:_model.address]]]];
                               [self.dataArr addObject:@[@[@"咨询记录",@""],
                                                         @[@"提问记录",@""],
                                                         @[@"购买记录",@""]]];
                               
                               [self.tableView reloadData];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = self.dataArr[section];
    return arr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0 && indexPath.row == 0) return 80;
    return 45.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell1)
            {
                cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                cell1.selectionStyle = UITableViewCellSelectionStyleNone;
                UIView *view = [UIView new];
                view.frame = CGRectMake(0, 79.5, SCREEN_WIDTH, 0.5);
                view.backgroundColor = LINE_COLOR;
                [cell1.contentView addSubview:view];
            }
            cell1.textLabel.font = FONT15;
            cell1.textLabel.textColor = COLOR3;
            cell1.textLabel.text = self.dataArr[indexPath.section][indexPath.row][0];
            
            UIImageView *avatarImg = [[UIImageView alloc] init];
            avatarImg.frame = CGRectMake(SCREEN_WIDTH - 72, 10, 60, 60);
            [avatarImg sd_setImageWithURL:[NSURL URLWithString:self.dataArr[indexPath.section][indexPath.row][1]] placeholderImage:[UIImage imageNamed:@"default_img_round_list"]];
            avatarImg.layer.masksToBounds = YES;
            avatarImg.layer.cornerRadius = 30;
            [cell1.contentView addSubview:avatarImg];
            
            return cell1;
        }
        else
        {
            UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (!cell2)
            {
                cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
                cell2.selectionStyle = UITableViewCellSelectionStyleNone;
                UIView *view = [UIView new];
                view.frame = CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5);
                view.backgroundColor = LINE_COLOR;
                [cell2.contentView addSubview:view];
            }
            
            cell2.textLabel.font = FONT15;
            cell2.textLabel.textColor = COLOR3;
            cell2.textLabel.text = self.dataArr[indexPath.section][indexPath.row][0];
            
            cell2.detailTextLabel.font = FONT15;
            cell2.detailTextLabel.textColor = COLOR6;
            cell2.detailTextLabel.text = self.dataArr[indexPath.section][indexPath.row][1];
            return cell2;
        }
    }
    else
    {
        UITableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (!cell3)
        {
            cell3 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            cell3.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell3.selectionStyle = UITableViewCellSelectionStyleNone;
            UIView *view = [UIView new];
            view.frame = CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5);
            view.backgroundColor = LINE_COLOR;
            [cell3.contentView addSubview:view];
        }
        cell3.textLabel.font = FONT15;
        cell3.textLabel.textColor = COLOR3;
        cell3.textLabel.text = self.dataArr[indexPath.section][indexPath.row][0];
        
        return cell3;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) return;
    if (indexPath.row == 0)
    {
        // 咨询记录
        KHYChatViewController *vc = [[KHYChatViewController alloc] init];
        vc.title = @"咨询记录";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 1)
    {
        // 提问记录
        KHYAskListOutVC *AskVC = [KHYAskListOutVC new];
        AskVC.patient_id = self.patient_id;
        AskVC.selectIndex = 0;
        AskVC.title = @"提问列表";
        AskVC.menuViewStyle = WMMenuViewStyleLine;
        AskVC.automaticallyCalculatesItemWidths = YES;
        AskVC.progressViewIsNaughty = YES;
        AskVC.progressWidth = 70;
        AskVC.titleSizeSelected = 18;
        AskVC.titleColorSelected = MAIN_COLOR;
        [self.navigationController pushViewController:AskVC animated:YES];
    }
    else
    {
        //销售管理
        KHYOrderViewController *vc = [[KHYOrderViewController alloc] init];
        vc.selectIndex = 0;
        vc.title = @"直销订单管理";
        vc.menuViewStyle = WMMenuViewStyleLine;
        vc.automaticallyCalculatesItemWidths = YES;
        vc.progressViewIsNaughty = YES;
        vc.progressWidth = SCREEN_WIDTH / 4;
        vc.titleSizeSelected = 18;
        vc.titleColorSelected = kRGB(89, 189, 237);
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
