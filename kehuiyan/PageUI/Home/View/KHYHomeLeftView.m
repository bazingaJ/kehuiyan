//
//  KHYHomeLeftView.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/8.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYHomeLeftView.h"
#import "KHYHomeLeftTopView.h"
#import "KHYHomeLeftCell.h"

@interface KHYHomeLeftView ()

@property (nonatomic, strong) KHYHomeLeftTopView *topView;
@property (nonatomic, strong) NSMutableArray *titleArr;

@end

@implementation KHYHomeLeftView

/**
 *  顶部视图
 */
- (KHYHomeLeftTopView *)topView {
    if(!_topView) {
        _topView = [[KHYHomeLeftTopView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, self.frame.size.width, 190)];
        [self addSubview:_topView];
    }
    return _topView;
}

/**
 *  菜单数组
 */
- (NSMutableArray *)titleArr {
    if(!_titleArr) {
        _titleArr = [NSMutableArray array];
    }
    return _titleArr;
}

/**
 *  懒加载
 */
- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT+190, self.frame.size.width, self.frame.size.height-(STATUS_BAR_HEIGHT+190)) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.backgroundColor = BACK_COLOR;
        [self addSubview:_tableView];
    }
    return _tableView;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
//        //设置背景色
//        self.backgroundColor = [UIColor whiteColor];
        
        //创建“状态栏背景层”
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, STATUS_BAR_HEIGHT)];
        [backView setBackgroundColor:[UIColor blackColor]];
        [self addSubview:backView];
        
        //设置顶部视图
        [self topView];
        
        //设置数据源
        [self.titleArr addObject:@[@"home_left_task",@"任务管理",@"0"]];
        //[self.titleArr addObject:@[@"home_left_sell",@"销售管理",@"1"]];
        //[self.titleArr addObject:@[@"home_left_huiyi",@"学术会议管理",@"2"]];
        //[self.titleArr addObject:@[@"home_left_huanjiao",@"患教管理",@"3"]];
        [self.titleArr addObject:@[@"home_left_customer",@"客户管理",@"4"]];
        [self.titleArr addObject:@[@"home_left_tongji",@"统计数据",@"5"]];
        [self.titleArr addObject:@[@"home_left_info",@"个人资料管理",@"6"]];
        [self.titleArr addObject:@[@"home_left_organization",@"组织机构",@"7"]];
        [self.titleArr addObject:@[@"home_left_setting",@"设置",@"8"]];
        
        //初始化
        [self tableView];
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
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
    
    static NSString *cellIndentifier = @"KHYHomeLeftCell";
    KHYHomeLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[KHYHomeLeftCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    NSArray *titleArr = [self.titleArr objectAtIndex:indexPath.row];
    [cell setLeftMenuTitleArr:titleArr];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *titleArr = [self.titleArr objectAtIndex:indexPath.row];
    NSInteger tIndex = [titleArr[2] integerValue];
    
    if(self.didClickItem) {
        self.didClickItem(self, tIndex);
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
