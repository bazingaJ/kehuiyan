//
//  KHYFilterListViewController.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/20.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYFilterListViewController.h"
#import "KHYOrganizationModel.h"
#import "KHYFilterDetailListViewController.h"
#import "KHYFilterMemberViewController.h"

static NSString *const currentTitle = @"选择查看人员";

static NSString *const cellIdentifier = @"KHYFilterListCell1";

// 设置区头高度
static const CGFloat headerViewHeigh = 50;

@interface KHYFilterListViewController ()
@property (nonatomic, strong) NSMutableDictionary *sectionHeaderViewStatusDict;
@end

@implementation KHYFilterListViewController

- (void)viewDidLoad {
    
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    
    self.title = currentTitle;
    
    [self prepareForData];
    
}

- (void)prepareForData
{
    
    // 请求数据
    [self requestData];
}

- (void)requestData
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"memberByDep" forKey:@"act"];
    [HttpRequestEx postWithURL:SERVICE_URL
                        params:param
                       success:^(id json) {
                           NSString *msg = [json objectForKey:@"msg"];
                           NSString *code = [json objectForKey:@"code"];
                           if([code isEqualToString:SUCCESS]) {
                               
                               NSArray *arr = [json objectForKey:@"data"];
                               self.dataArr = [KHYOrganizationModel mj_objectArrayWithKeyValuesArray:arr];
                               self.sectionHeaderViewStatusDict = [NSMutableDictionary dictionaryWithCapacity:self.dataArr.count];
                               for (int i = 0; i < self.dataArr.count; i++)
                               {
                                   self.sectionHeaderViewStatusDict[@(i)] = @(0).stringValue;

                               }
                               [self.tableView reloadData];
                               
                           }else{
                               [MBProgressHUD showError:msg toView:self.view];
                           }
                       }
                       failure:^(NSError *error) {
                           NSLog(@"%@",[error description]);
                           [MBProgressHUD hideHUD:self.view];
                       }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    KHYOrganizationModel *model = self.dataArr[section];
    if ([self.sectionHeaderViewStatusDict[@(section)] isEqualToString:@"0"])
    {
        return 0;
    }
    else
    {
        
        return model.list.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIView *lineView = [UIView new];
        lineView.frame = CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5);
        lineView.backgroundColor = LINE_COLOR;
        [cell.contentView addSubview:lineView];
    }
    
    KHYOrganizationModel *model = self.dataArr[indexPath.section];
    NSArray *arr = [KHYOrganizationModel mj_objectArrayWithKeyValuesArray:model.list];
    KHYOrganizationModel *model2 = arr[indexPath.row];
    cell.textLabel.text = model2.name;
    cell.textLabel.font = FONT16;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return headerViewHeigh;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    KHYOrganizationModel *model = self.dataArr[section];
    UIView *headerView = [UIView new];
    headerView.backgroundColor = kRGB(240, 240, 240);
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 120, headerViewHeigh)];
    titleLab.text = model.name;
    titleLab.font = [UIFont systemFontOfSize:16];
    titleLab.textColor = [UIColor colorWithRed:26/255.0 green:26/255.0 blue:26/255.0 alpha:1.0];
    [headerView addSubview:titleLab];
    
    UIButton *coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    coverBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH, headerViewHeigh);
    [coverBtn setBackgroundColor:[UIColor clearColor]];
    coverBtn.tag = section;
    [coverBtn addTarget:self action:@selector(sectionHeaderViewClick:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:coverBtn];
    
    UIImageView *arrowImgView = [[UIImageView alloc] init];
    arrowImgView.frame = [self.sectionHeaderViewStatusDict[@(section)] isEqualToString:@"0"] ? CGRectMake(SCREEN_WIDTH - 25, 25, 6.f, 10.f) : CGRectMake(SCREEN_WIDTH - 27, 25, 10.f, 6.f);
    arrowImgView.image = [self.sectionHeaderViewStatusDict[@(section)] isEqualToString:@"0"] ? [UIImage imageNamed:@"right_icon_gray"] : [UIImage imageNamed:@"right_icon_gray_down"];
    [headerView addSubview:arrowImgView];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(0, headerViewHeigh - 1, SCREEN_WIDTH, 0.5);
    lineView.backgroundColor = kRGB(204, 204, 204);
    [headerView addSubview:lineView];
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    KHYOrganizationModel *model = self.dataArr[indexPath.section];
    NSArray *arr = [KHYOrganizationModel mj_objectArrayWithKeyValuesArray:model.list];
    KHYOrganizationModel *model2 = arr[indexPath.row];
    // 首先判断是否还存在下级部门
    // 存在 展开列表再本页面展示
    // 不存在 直接跳转下一个页面展示成员列表
    if (model2.list.count != 0 && model2.list != nil)
    {
        // 存在子部门 展开列表展示信息
        KHYFilterDetailListViewController *detailVC = [[KHYFilterDetailListViewController alloc] init];
        detailVC.model = model2;
        detailVC.filterType = self.filterType;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    if (model2.list.count == 0 && model2.list != nil)
    {
        // 不存在子部门 直接跳转新的成员信息列表
        KHYFilterMemberViewController *memberVC = [[KHYFilterMemberViewController alloc] init];
        NSInteger dep_id = model2.dep_id;
        memberVC.dep_id = @(dep_id).stringValue;
        memberVC.titleName = model2.name;
        memberVC.filterType = self.filterType;
        [self.navigationController pushViewController:memberVC animated:YES];
    }
}

- (void)sectionHeaderViewClick:(UIButton *)button
{
    NSInteger sectionNumber = button.tag;
    // 首先判断是否还存在下级部门
    // 存在 展开列表再本页面展示
    // 不存在 直接跳转下一个页面展示成员列表
    KHYOrganizationModel *model = self.dataArr[sectionNumber];
    if (model.list.count != 0 && model.list != nil)
    {
        // 存在子部门 展开列表展示信息
        self.sectionHeaderViewStatusDict[@(sectionNumber)] = [self.sectionHeaderViewStatusDict[@(sectionNumber)] isEqualToString:@"0"] ? @"1" : @"0";
        UIView *headView = button.superview;
        NSArray *arr = headView.subviews;
        for (UIView *vi in arr)
        {
            if ([vi isKindOfClass:[UIImageView class]])
            {
                if ([self.sectionHeaderViewStatusDict[@(sectionNumber)] isEqualToString:@"0"])
                {
                    [UIView animateWithDuration:.1f animations:^{
                        [self.tableView reloadData];
                        vi.transform = CGAffineTransformMakeRotation(M_PI / 2);
                    } completion:^(BOOL finished) {
                        
                    }];
                }
                else
                {
                    [UIView animateWithDuration:.1f animations:^{
                        [self.tableView reloadData];
                        vi.transform = CGAffineTransformIdentity;
                    } completion:^(BOOL finished) {
                        
                    }];
                }
            }
        }
    }
    if (model.list.count == 0 || model.list == nil)
    {
        // 不存在子部门 直接跳转新的成员信息列表
        KHYFilterMemberViewController *memberVC = [[KHYFilterMemberViewController alloc] init];
        NSInteger dep_id = model.dep_id;
        memberVC.dep_id = @(dep_id).stringValue;
        memberVC.titleName = model.name;
        memberVC.filterType = self.filterType;
        [self.navigationController pushViewController:memberVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}



@end
