//
//  KHYTaskDropDownMenu.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/3/2.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYTaskDropDownMenu.h"

@interface KHYTaskDropDownMenuItem : UIButton

@end

@implementation KHYTaskDropDownMenuItem

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        //设置图片
        self.imageView.image = [UIImage imageNamed:@"menu_icon_down"];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.imageView.layer.transform = CATransform3DMakeRotation(selected ? M_PI : 0, 0, 0, 1);
    }];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.centerX = self.width * 0.5;
    self.imageView.left = self.titleLabel.right + 5;
    
}

@end

@interface KHYTaskDropDownMenu ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIView *popView;
@property (nonatomic, strong) KHYTaskDropDownMenuItem *currentItem;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *typeArr;
@property (nonatomic, strong) NSMutableArray *cycleArr;
@property (nonatomic, strong) NSMutableArray *statusArr;

@end

@implementation KHYTaskDropDownMenu

/**
 *  任务类型
 */
- (NSMutableArray *)typeArr {
    if(!_typeArr) {
        _typeArr = [NSMutableArray array];
        [_typeArr addObject:@"全部"];
        [_typeArr addObject:@"客户拓展任务客户"];
        [_typeArr addObject:@"学术会议开展任务"];
        [_typeArr addObject:@"患教活动"];
        [_typeArr addObject:@"销量"];
    }
    return _typeArr;
}

/**
 *  任务周期
 */
- (NSMutableArray *)cycleArr {
    if(!_cycleArr) {
        _cycleArr = [NSMutableArray array];
        [_cycleArr addObject:@"全部"];
        [_cycleArr addObject:@"日任务"];
        [_cycleArr addObject:@"周任务"];
        [_cycleArr addObject:@"月任务"];
        [_cycleArr addObject:@"季任务"];
        [_cycleArr addObject:@"年任务"];
    }
    return _cycleArr;
}

/**
 *  任务状态
 */
- (NSMutableArray *)statusArr {
    if(!_statusArr) {
        _statusArr = [NSMutableArray array];
        [_statusArr addObject:@"全部"];
        [_statusArr addObject:@"待完成"];
        [_statusArr addObject:@"按时完成"];
        [_statusArr addObject:@"逾期完成"];
        [_statusArr addObject:@"已过期"];
    }
    return _statusArr;
}

/**
 *  创建“tableView”
 */
- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = BACK_COLOR;
    }
    return _tableView;
}

/**
 *  背景层视图
 */
- (UIView *)popView {
    if(!_popView) {
        WS(weakSelf);
        CGFloat y = [self convertPoint:self.origin toView:kWindow].y;
        _popView = [[UIView alloc] initWithFrame:CGRectMake(0, y+self.height-self.top, SCREEN_WIDTH, SCREEN_HEIGHT-y-HOME_INDICATOR_HEIGHT-self.height+self.top)];
        _popView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [_popView setHidden:YES];
        [_popView addTouch:^{
            NSLog(@"点击了背景层");
            
            [weakSelf dismiss];
            
        }];
        [kWindow addSubview:_popView];
    }
    return _popView;
}


/**
 *  初始化
 */
- (id)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr {
    self = [super initWithFrame:frame];
    if(self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        //设置标题
        NSInteger titleNum = [titleArr count];
        CGFloat tWidth = self.frame.size.width/titleNum;
        for (NSInteger i=0; i<titleNum; i++) {
            KHYTaskDropDownMenuItem *menuItem = [[KHYTaskDropDownMenuItem alloc] initWithFrame:CGRectMake(tWidth*i, 0, tWidth, frame.size.height)];
            [menuItem setTitle:titleArr[i] forState:UIControlStateNormal];
            [menuItem setTitleColor:COLOR3 forState:UIControlStateNormal];
            [menuItem.titleLabel setFont:FONT15];
            [menuItem setImage:[UIImage imageNamed:@"menu_icon_down"] forState:UIControlStateNormal];
            [menuItem setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
            [menuItem setImageEdgeInsets:UIEdgeInsetsMake(0, menuItem.frame.size.width-menuItem.imageView.frame.size.width, 0, 0)];
            [menuItem setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
            [menuItem setTag:100*(i+1)];
            [menuItem addTarget:self action:@selector(menuItemClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:menuItem];
        }
        
        //创建“分割线”
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-0.5, frame.size.width, 0.5)];
        [lineView setBackgroundColor:LINE_COLOR];
        [self addSubview:lineView];
        
    }
    return self;
}

/**
 *  下来菜单点击事件
 */
- (void)menuItemClick:(KHYTaskDropDownMenuItem *)menuItem {
    
    //清除所有视图
    for (UIView *view in self.popView.subviews) {
        [view removeFromSuperview];
    }
    
    if ([_currentItem isEqual:menuItem]) {
        _currentItem.selected = !_currentItem.selected;
    }else{
        _currentItem.selected = NO;
        _currentItem = menuItem;
        _currentItem.selected = YES;
    }
    
    if (menuItem.selected) {
        [self show];
    }else{
        [self dismiss];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.currentItem.tag==100) {
        //任务类型
        return self.typeArr.count;
    }else if(self.currentItem.tag==200) {
        //任务周期
        return self.cycleArr.count;
    }else if(self.currentItem.tag==300) {
        //任务状态
        return self.statusArr.count;
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
    static NSString *cellIndentifier = @"KHYTaskDropDownMenuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    //创建“背景层”
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT15];
    [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btnFunc setBackgroundColor:[UIColor clearColor]];
    [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    if(self.currentItem.tag==100) {
        //任务类型
        NSString *titleStr = [self.typeArr objectAtIndex:indexPath.row];
        [btnFunc setTitle:titleStr forState:UIControlStateNormal];
    }else if(self.currentItem.tag==200){
        //任务周期
        NSString *titleStr = [self.cycleArr objectAtIndex:indexPath.row];
        [btnFunc setTitle:titleStr forState:UIControlStateNormal];
    }else if(self.currentItem.tag==300) {
        //任务状态
        NSString *titleStr = [self.statusArr objectAtIndex:indexPath.row];
        [btnFunc setTitle:titleStr forState:UIControlStateNormal];
    }
    [btnFunc setTag:100+indexPath.row];
    [btnFunc addTarget:self action:@selector(btnFuncCellClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:btnFunc];
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, btnFunc.frame.size.height-0.5, btnFunc.frame.size.width, 0.5)];
    [lineView setBackgroundColor:LINE_COLOR];
    [btnFunc addSubview:lineView];
    
    return cell;
}

/**
 *  单元格选择
 */
- (void)btnFuncCellClick:(UIButton *)btnSender {
    NSLog(@"单元格选择");
    
    switch (self.currentItem.tag) {
        case 100: {
            //任务类型
            
            NSString *titleStr = [self.typeArr objectAtIndex:btnSender.tag-100];
            if([titleStr isEqualToString:@"全部"]) {
                titleStr = @"任务类型";
            }
            [self.currentItem setTitle:titleStr forState:UIControlStateNormal];
            if(self.callTypeBack) {
                self.callTypeBack([NSString stringWithFormat:@"%zd",btnSender.tag-100], titleStr);
                [self dismiss];
            }
            
            break;
        }
        case 200: {
            //任务周期
            
            NSString *titleStr = [self.cycleArr objectAtIndex:btnSender.tag-100];
            if([titleStr isEqualToString:@"全部"]) {
                titleStr = @"任务周期";
            }
            [self.currentItem setTitle:titleStr forState:UIControlStateNormal];
            if(self.callCycleBack) {
                self.callCycleBack([NSString stringWithFormat:@"%zd",btnSender.tag-100], titleStr);
                [self dismiss];
            }
            
            break;
        }
        case 300: {
            //任务状态
            
            NSString *titleStr = [self.statusArr objectAtIndex:btnSender.tag-100];
            if([titleStr isEqualToString:@"全部"]) {
                titleStr = @"任务状态";
            }
            [self.currentItem setTitle:titleStr forState:UIControlStateNormal];
            if(self.callStatusBack) {
                self.callStatusBack([NSString stringWithFormat:@"%zd",btnSender.tag-100], titleStr);
                [self dismiss];
            }
            
            break;
        }
            
        default:
            break;
    }
    
}

/**
 *  显示
 */
- (void)show {
    
    _tableView.width = self.frame.size.width;
    [self.tableView reloadData];
    [self.popView addSubview:[self tableView]];
    
    [UIView animateWithDuration:0.2 animations:^{
        NSInteger rowNum = 0;
        if(self.currentItem.tag==100) {
            //任务类型
            rowNum = self.typeArr.count;
        }else if(self.currentItem.tag==200) {
            //任务周期
            rowNum = self.cycleArr.count;
        }else if(self.currentItem.tag==300) {
            //任务状态
            rowNum = self.statusArr.count;
        }
        _tableView.height = (rowNum*45 > SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-self.height) ? (SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-self.height) : rowNum*45;
    }completion:^(BOOL finished) {
        //self.isShow = YES;
    }];
    
    [self.popView setHidden:NO];

}

/**
 *  隐藏
 */
- (void)dismiss {
    _currentItem = nil;
    [UIView animateWithDuration:0.2 animations:^{
        //        _tableView.height = 0;
        //        _tableView1.height = 0;
        //        _tableView2.height = 0;
        //        _pinyinView.height = 0;
    } completion:^(BOOL finished) {
        //清除所有视图
        for (UIView *view in self.popView.subviews) {
            [view removeFromSuperview];
        }
        [self.popView setHidden:YES];
    }];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
