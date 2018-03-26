//
//  KHYSubjectSelectedViewController.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/3/6.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYSubjectSelectedViewController.h"
#import "KHYSubjectModel.h"
#import "KHYSubjectCell.h"

@interface KHYSubjectSelectedViewController ()

@end

@implementation KHYSubjectSelectedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择学科";
    
}

/**
 *  关闭窗体
 */
- (void)leftButtonItemClick {
    NSLog(@"关闭窗体");
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"KHYSubjectCell";
    KHYSubjectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[KHYSubjectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    KHYSubjectModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    [cell setSubjectModel:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    KHYSubjectModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    
    if(self.callBack) {
        self.callBack(model.subject_id, model.subject_name,nil);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

/**
 *  完成按钮事件
 */
- (void)getDataList:(BOOL)isMore {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"task" forKey:@"app"];
    [param setValue:@"getSubjectList" forKey:@"act"];
//    [param setValue:self.hospital_id forKey:@"hospital_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSArray *dataList = [json objectForKey:@"data"];
            self.dataArr = [KHYSubjectModel mj_objectArrayWithKeyValuesArray:dataList];
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
