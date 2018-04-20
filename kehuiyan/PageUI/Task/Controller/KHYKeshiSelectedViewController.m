//
//  KHYKeshiSelectedViewController.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/23.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYKeshiSelectedViewController.h"
#import "KHYKeshiCell.h"

@interface KHYKeshiSelectedViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView1;
@property (nonatomic, strong) UITableView *tableView2;
@property (nonatomic, strong) NSMutableArray *dataArr1;
@property (nonatomic, strong) NSMutableArray *dataArr2;

@end

@implementation KHYKeshiSelectedViewController

/**
 *  懒加载“tableView1”
 */
- (UITableView *)tableView1 {
    if(!_tableView1) {
        _tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT) style:UITableViewStyleGrouped];
        _tableView1.dataSource = self;
        _tableView1.delegate = self;
        _tableView1.separatorInset = UIEdgeInsetsZero;
        _tableView1.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView1.backgroundColor = BACK_COLOR;
        [self.view addSubview:_tableView1];
    }
    return _tableView1;
}

/**
 *  懒加载“tableView2”
 */
- (UITableView *)tableView2 {
    if(!_tableView2) {
        _tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT) style:UITableViewStyleGrouped];
        _tableView2.dataSource = self;
        _tableView2.delegate = self;
        _tableView2.separatorInset = UIEdgeInsetsZero;
        _tableView2.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView2.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_tableView2];
    }
    return _tableView2;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"选择学科";
    
    [self tableView1];
    [self tableView2];
    
    //获取科室列表
    [self getKeshiList];
    
}

/**
 *  关闭窗体
 */
- (void)leftButtonItemClick {
    NSLog(@"关闭窗体");
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView==_tableView1) {
        return self.dataArr1.count;
    }else if(tableView==_tableView2) {
        return self.dataArr2.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"KHYKeshiCell";
    KHYKeshiCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[KHYKeshiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    KHYKeshiModel *model;
    if(tableView==_tableView1 && self.dataArr1.count) {
        model = [self.dataArr1 objectAtIndex:indexPath.row];
    }else if(tableView==_tableView2 && self.dataArr2.count) {
        model = [self.dataArr2 objectAtIndex:indexPath.row];
    }
    [cell setKeshiModel:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView==_tableView1) {
        
        //设置底色
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        //预先清除所有底色
        for (UIView *view in cell.superview.subviews) {
            if([view isKindOfClass:[UITableViewCell class]]) {
                UITableViewCell *cell = (UITableViewCell *)view;
                cell.backgroundColor = BACK_COLOR;
            }
        }
        cell.backgroundColor = [UIColor whiteColor];
        
        //当前选择项
        if(self.dataArr1.count) {
            KHYKeshiModel *model = [self.dataArr1 objectAtIndex:indexPath.row];
            self.dataArr2 = model.child_list;
        }
        [self.tableView2 reloadData];
        
    }else if(tableView==_tableView2){
        
        KHYKeshiModel *model;
        if(self.dataArr2.count) {
            model = [self.dataArr2 objectAtIndex:indexPath.row];
        }
        
        if(self.callBack) {
            self.callBack(model.keshi_id, model.name);
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }
    
}

/**
 *  获取数据
 */
- (void)getKeshiList {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"task" forKey:@"app"];
    [param setValue:@"getKeshiList" forKey:@"act"];
    [param setValue:self.hospital_id forKey:@"hospital_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSArray *dataList = [json objectForKey:@"data"];
            self.dataArr1 = [KHYKeshiModel mj_objectArrayWithKeyValuesArray:dataList];
        }
        [self.tableView1 reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
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
