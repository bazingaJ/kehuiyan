//
//  KHYQuestionListViewController.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/10.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYQuestionListViewController.h"
#import "KHYQuestionListCell.h"
#import "KHYQuestionListModel.h"
#import "KHYComboViewController.h"
#import "KHYAskRecordViewController.h"
#import "KHYChatViewController.h"

static NSString *const currentTitle1 = @"患者提问";

static NSString *const currentTitle2 = @"咨询列表";

static NSString *const cellIdentifier = @"KHYQuestionListCell1";

@interface KHYQuestionListViewController ()

@end

@implementation KHYQuestionListViewController

- (void)viewDidLoad {
    
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    self.title = self.characterType == 1 ? currentTitle1 : currentTitle2;
    
    [self initialized];
    
}

- (void)initialized
{
    
    KHYQuestionListModel *model = [KHYQuestionListModel new];
    model.avatar = @"";
    model.name = @"顾平生";
    model.content = @"想咨询一下用药方面的相关问题的......";
    model.isReply = @"2";
    
    KHYQuestionListModel *model1 = [KHYQuestionListModel new];
    model1.avatar = @"";
    model1.name = @"隔壁老王";
    model1.content = @"想咨询一下那方面的相关问题";
    model1.isReply = @"1";
    
    
    [@[@"",@"",@"",@"",@""] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx <= 3)
        {
           [self.dataArr addObject:model];
        }
        else
        {
            [self.dataArr addObject:model1];
        }
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 70.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    KHYQuestionListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([KHYQuestionListCell class]) owner:nil options:nil]objectAtIndex:0];
    }
    cell.model = self.dataArr[indexPath.row];
    return cell;
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
    
    if (indexPath.row % 2 == 0){
        KHYChatViewController *vc = [[KHYChatViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        KHYAskRecordViewController *vc = [[KHYAskRecordViewController alloc] init];
        vc.title = @"提问详情";
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}



@end
