//
//  KHYHospitalSheetView.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/3/16.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYHospitalSheetView.h"

@interface KHYHospitalSheetView () <UITableViewDataSource,UITableViewDelegate>


@end

@implementation KHYHospitalSheetView

/**
 懒加载

 @return tableview
 */
- (UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, self.frame.size.width, self.yPosition-HOME_INDICATOR_HEIGHT-45) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [_backView addSubview:_tableView];
        }
        return _tableView;
}

/**
*  懒加载
*/
- (NSMutableArray *)dataArr {
if(!_dataArr) {
    _dataArr = [NSMutableArray array];
}
    return _dataArr;
}

- (instancetype)initWithFrame:(CGRect)frame withDataArr:(NSMutableArray *)dataArr
{
    self = [super initWithFrame:frame];
    if(self) {
        
        //设置frame
        CGRect rect = [UIScreen mainScreen].bounds;
        self.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        
        //设置面板高度
        self.yPosition = 180;
        
        //创建“View”背景层
        CGRect frame = self.backView.frame;
        frame.size = CGSizeMake([UIScreen mainScreen].bounds.size.width, self.yPosition);
        frame.origin = CGPointMake(0, self.frame.size.height);
        
        //创建“背景层”
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.userInteractionEnabled = YES;
        _backView.frame = frame;
        [self addSubview:_backView];
        
        //创建“标题”
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 45)];
        [backView setBackgroundColor:[UIColor whiteColor]];
        [_backView addSubview:backView];
        
        //创建“医院级别”
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, backView.frame.size.width-20, 25)];
        [lbMsg setText:@"医院级别(可选)"];
        [lbMsg setTextColor:[UIColor blackColor]];
        [lbMsg setTextAlignment:NSTextAlignmentLeft];
        [lbMsg setFont:[UIFont boldSystemFontOfSize:17]];
        [backView addSubview:lbMsg];
        
        //创建“分割线”
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, backView.frame.size.width, 0.5)];
        [lineView setBackgroundColor:LINE_COLOR];
        [backView addSubview:lineView];
        
        //创建数据源
        [self.dataArr removeAllObjects];
        for (int i = 0; i <dataArr.count; i ++)
        {
            NSDictionary *dic = dataArr[i];
            [self.dataArr addObject:@[dic[@"level_id"],dic[@"level_name"]]];
        }
        
        
        //创建“tableView”
        [self tableView];
        
        //弹层
        [self showAlert];
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
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
    static NSString *cellIdentity = @"CGMannerSheetViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    for(UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    NSArray *itemArr = [self.dataArr objectAtIndex:indexPath.row];
    
    //创建“标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.width-20, 25)];
    [lbMsg setText:itemArr[1]];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT15];
    [cell.contentView addSubview:lbMsg];
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, self.frame.size.width, 0.5)];
    [lineView setBackgroundColor:LINE_COLOR];
    [cell.contentView addSubview:lineView];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *itemArr = [self.dataArr objectAtIndex:indexPath.row];
    
    if(self.hospitalLevelCallBack) {
        self.hospitalLevelCallBack(itemArr[0],itemArr[1]);
        [self dismiss];
    }
}

//显示弹出层
- (void)show {
    [UIView animateWithDuration:.23 animations:^{
        CGRect frame = _backView.frame;
        frame.origin.y -= self.yPosition;
        _backView.frame = frame;
    }];
}

//关闭弹出层
- (void)dismiss {
    [UIView animateWithDuration:.23 animations:^{
        CGRect frame = self.backView.frame;
        frame.origin.y += self.yPosition;
        self.backView.frame = frame;
        [self removeFromSuperview];
    } completion:^(BOOL complete){
        //[self.delegate EYWalletPaySheetSheetPressed:self index:self.index];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self topToDismiss];
}

- (void)btnFuncCloseClick:(UIButton *)btnSender {
    UIButton *btnFunc = (UIButton *)btnSender;
    self.index = (NSInteger)btnFunc.tag;
    [self dismiss];
}

- (void)showAlert {
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
}

- (void)topToDismiss {
    self.index = -1;
    [self dismiss];
}

@end
