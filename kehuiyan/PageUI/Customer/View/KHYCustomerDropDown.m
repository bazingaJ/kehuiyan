//
//  KHYCustomerDropDown.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/3/14.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYCustomerDropDown.h"
#import "KHYHospitalModel.h"
#import "KHYKeshiModel.h"

@interface CGDropDownMenuItem : UIButton



@end

@implementation CGDropDownMenuItem

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

@interface DistrictModel : NSObject

@property (nonatomic, strong) NSString *district_id;
@property (nonatomic, strong) NSString *district_name;

@end

@interface CityModel : NSObject

@property (nonatomic, strong) NSString *city_id;
@property (nonatomic, strong) NSString *city_name;
@property (nonatomic, strong) NSArray *district_list;

@end

@interface ProvinceModel : NSObject

@property (nonatomic, strong) NSString *province_id;
@property (nonatomic, strong) NSString *province_name;
@property (nonatomic, strong) NSArray  *city_list;

@end

@interface KHYCustomerDropDown ()<UITableViewDelegate, UITableViewDataSource> {
    NSInteger tableNum;
}

@property (nonatomic, strong) CGDropDownMenuItem *currentItem;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableView *tableView1;
@property (nonatomic, strong) UITableView *tableView2;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UIView *popView;
@property (nonatomic, assign) CGFloat tableWidth;

@property(nonatomic, strong) NSArray *provinceArr;
@property(nonatomic, strong) NSArray *cityArr;
@property(nonatomic, strong) NSArray *districtArr;

@property (nonatomic, strong) NSMutableArray *hospitalArr;
@property (nonatomic, strong) NSMutableArray *keshiArr;

@property (nonatomic, strong) NSString *area_idStr;
@property (nonatomic, strong) NSString *cityid;
@property (nonatomic, strong) NSString *hospitalStr;
@property (nonatomic, strong) NSString *officeStr;

@end

@implementation KHYCustomerDropDown

/**
 *  初始化1
 */
- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.tableWidth, 0) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = BACK_COLOR;
    }
    return _tableView;
}

/**
 *  初始化2
 */
- (UITableView *)tableView1 {
    if(!_tableView1) {
        _tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(self.tableWidth, 0, self.tableWidth, 0) style:UITableViewStyleGrouped];
        _tableView1.dataSource = self;
        _tableView1.delegate = self;
        _tableView1.separatorInset = UIEdgeInsetsZero;
        _tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView1.backgroundColor = [UIColor whiteColor];
    }
    return _tableView1;
}

/**
 *  初始化3
 */
- (UITableView *)tableView2 {
    if(!_tableView2) {
        _tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(self.tableWidth*2, 0, self.tableWidth, 0) style:UITableViewStyleGrouped];
        _tableView2.dataSource = self;
        _tableView2.delegate = self;
        _tableView2.separatorInset = UIEdgeInsetsZero;
        _tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView2.backgroundColor = BACK_COLOR;
    }
    return _tableView2;
}

/**
 *  获取当前视图宽度
 */
- (CGFloat)tableWidth {
    return self.frame.size.width/tableNum;
}


/**
 *  地区
 */
- (NSMutableArray *)dataArr {
    if(!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

/**
 *  医院
 */
- (NSMutableArray *)hospitalArr {
    if(!_hospitalArr) {
        _hospitalArr = [NSMutableArray array];
    }
    return _hospitalArr;
}

/**
 *  科室
 */
- (NSMutableArray *)keshiArr {
    if(!_keshiArr) {
        _keshiArr = [NSMutableArray array];
    }
    return _keshiArr;
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
- (id)initWithFrame:(CGRect)frame titleArr:(NSMutableArray *)titleArr {
    self = [super initWithFrame:frame];
    if(self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.area_idStr = @"";
        self.hospitalStr = @"";
        self.officeStr = @"";
        //设置默认值
        tableNum = 1;
        //设置标题
        NSInteger titleNum = [titleArr count];
        CGFloat tWidth = self.frame.size.width/titleNum;
        for (NSInteger i=0; i<titleNum; i++) {
            NSArray *itemArr = [titleArr objectAtIndex:i];
            CGDropDownMenuItem *menuItem = [[CGDropDownMenuItem alloc] initWithFrame:CGRectMake(tWidth*i, 0, tWidth-1, frame.size.height)];
            [menuItem setTitle:itemArr[0] forState:UIControlStateNormal];
            [menuItem setTitleColor:COLOR3 forState:UIControlStateNormal];
            [menuItem.titleLabel setFont:FONT15];
            [menuItem setImage:[UIImage imageNamed:@"menu_icon_down"] forState:UIControlStateNormal];
            [menuItem setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
            [menuItem setImageEdgeInsets:UIEdgeInsetsMake(0, menuItem.frame.size.width-menuItem.imageView.frame.size.width, 0, 0)];
            [menuItem setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
            [menuItem setTag:[itemArr[1] integerValue]];
            [menuItem addTarget:self action:@selector(menuItemClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:menuItem];
        }
        
        //创建“分割线”
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-0.5, frame.size.width, 0.5)];
        [lineView setBackgroundColor:LINE_COLOR];
        [self addSubview:lineView];
        
        //获取区域列表
        [self getCityList];
        
        
    }
    return self;
}

/**
 *  下来菜单点击事件
 */
- (void)menuItemClick:(CGDropDownMenuItem *)menuItem {
    NSLog(@"点击了菜单");
    
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

/**
 *  显示
 */
- (void)show {
    
    NSInteger itemTag = self.currentItem.tag;
    if(itemTag==100) {
        //医院
        
        //治疗组验证
        if(IsStringEmpty(self.area_idStr)) {
            [MBProgressHUD showError:@"请选择地区" toView:self.superview.superview];
            self.currentItem.selected = NO;
            return;
        }
        
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setObject:@"task" forKey:@"app"];
        [param setObject:@"getHospitalList" forKey:@"act"];
//        [param setObject:self.cityid forKey:@"city_id"];
        [param setObject:self.area_idStr forKey:@"area_id"];
        [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
            NSString *code = [json objectForKey:@"code"];
            NSString *msg= [json objectForKey:@"msg"];
            if ([code isEqualToString:SUCCESS])
            {
                NSDictionary *dic = [json objectForKey:@"data"];
                [self.hospitalArr removeAllObjects];
                [self.hospitalArr addObjectsFromArray:[KHYHospitalModel mj_objectArrayWithKeyValuesArray:dic[@"list"]]];
                tableNum = 1;
                _tableView.width = self.frame.size.width;
                
                [self.tableView reloadData];
                [self.popView addSubview:[self tableView]];
                
                [UIView animateWithDuration:0.2 animations:^{
                    
                    NSInteger rowNum = 0;
                    if(self.currentItem.tag==100) {
                        //单列
                        rowNum = self.hospitalArr.count;
                    }
                    else
                    {
                        rowNum = 10;
                    }
                    
                    _tableView.height = (rowNum*45 > SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-100) ? (SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-100) : rowNum*45;
                }completion:^(BOOL finished) {
                    //self.isShow = YES;
                }];
            }
            else
            {
//                [MBProgressHUD showMessage:msg toView:self];
                
            }
        } failure:^(NSError *error) {
            
        }];
        
        
    }else if(itemTag==200) {
        //科室
        
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setObject:@"task" forKey:@"app"];
        [param setObject:@"getKeshiList" forKey:@"act"];
//        [param setObject:self.hospitalStr forKey:@"hospital_id"];
        [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
            NSString *code = [json objectForKey:@"code"];
            NSString *msg= [json objectForKey:@"msg"];
            if ([code isEqualToString:SUCCESS])
            {
                NSArray *arr = [json objectForKey:@"data"];
                [self.keshiArr removeAllObjects];
                [self.keshiArr addObjectsFromArray:[KHYKeshiModel mj_objectArrayWithKeyValuesArray:arr]];
                tableNum = 1;
                _tableView.width = self.frame.size.width/tableNum;
                
                [self.popView addSubview:[self tableView]];
                [self.popView addSubview:[self tableView1]];
                
                NSInteger rowNum = self.keshiArr.count;
                
                [self.tableView reloadData];
                [UIView animateWithDuration:0.2 animations:^{
                    self.tableView.height = (rowNum*45 > SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-100) ? (SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-100) : rowNum*45;
                }completion:^(BOOL finished) {
                    //self.isShow = YES;
                }];
            }
            else
            {
//                [MBProgressHUD showMessage:msg toView:self];
                
            }
        } failure:^(NSError *error) {
            
        }];
        
        
        
    }else if(itemTag==300) {
        //地区
        
        tableNum = 3;
        _tableView.width = self.frame.size.width/tableNum;
        
        [self.popView addSubview:[self tableView]];
        [self.popView addSubview:[self tableView1]];
        [self.popView addSubview:[self tableView2]];
        
        NSInteger rowNum = self.provinceArr.count;
        
        [self.tableView reloadData];
        [UIView animateWithDuration:0.2 animations:^{
            self.tableView.height = (rowNum*45 > SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-100) ? (SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-100) : rowNum*45;
        }completion:^(BOOL finished) {
            //self.isShow = YES;
        }];
        
    }
    
    [self.popView setHidden:NO];
    
}

/**
 *  隐藏
 */
- (void)dismiss {
    _currentItem = nil;
    [UIView animateWithDuration:0.2 animations:^{
        _tableView.height = 0;
        _tableView1.height = 0;
        _tableView2.height = 0;
    } completion:^(BOOL finished) {
        //清除所有视图
        _tableView = nil;
        _tableView1 = nil;
        _tableView2 = nil;
        for (UIView *view in self.popView.subviews) {
            [view removeFromSuperview];
        }
        [self.popView setHidden:YES];
        //_isShow = NO;
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView==_tableView) {
        if(self.currentItem.tag==100) {
            //医院
            return self.hospitalArr.count;
        }else if(self.currentItem.tag==200) {
            //科室
            return self.keshiArr.count;
        }else if(self.currentItem.tag==300) {
            //省份
            return self.provinceArr.count;
        }
    }else if(tableView==_tableView1) {
        if(self.currentItem.tag==300) {
            //城市
            return self.cityArr.count;
        }
    }else if(tableView==_tableView2) {
        if(self.currentItem.tag==300) {
            //县区
            return self.districtArr.count;
        }
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
    static NSString *cellIndentifier = @"KHYCustomerDropDownCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    //创建“背景层”
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.tableWidth, 45)];
    [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT15];
    [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btnFunc setBackgroundColor:[UIColor clearColor]];
    [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    if(tableView==_tableView) {
        
        if(self.currentItem.tag==100) {
            //医院
            KHYHospitalModel *model;
            if(self.hospitalArr.count) {
                model = [self.hospitalArr objectAtIndex:indexPath.row];
            }
            [btnFunc setTitle:model.name forState:UIControlStateNormal];
            
        }else if(self.currentItem.tag==200) {
            //科室
            KHYKeshiModel *model;
            if(self.keshiArr.count) {
                model = [self.keshiArr objectAtIndex:indexPath.row];
            }
            [btnFunc setTitle:model.name forState:UIControlStateNormal];
            
        }else if(self.currentItem.tag==300) {
            //省份
            ProvinceModel *model;
            if(self.provinceArr.count) {
                model = [self.provinceArr objectAtIndex:indexPath.row];
            }
            [btnFunc setTitle:model.province_name forState:UIControlStateNormal];
        }
        [btnFunc setTag:100+indexPath.row];
    }else if(tableView==_tableView1) {
        cell.backgroundColor = [UIColor whiteColor];
        
        if(self.currentItem.tag==300) {
            //城市
            CityModel *model;
            if(self.cityArr.count) {
                model = [self.cityArr objectAtIndex:indexPath.row];
            }
            
            [btnFunc setTitle:model.city_name forState:UIControlStateNormal];
            self.cityid = model.city_id;
        }
        [btnFunc setImage:nil forState:UIControlStateNormal];
        [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(0, 25, 0, 0)];
        [btnFunc setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
        [btnFunc setTag:1000+indexPath.row];
    }else if(tableView==_tableView2) {
        
        if(self.currentItem.tag==300) {
            DistrictModel *model;
            if(self.districtArr.count) {
                model = [self.districtArr objectAtIndex:indexPath.row];
            }
            [btnFunc setTitle:model.district_name forState:UIControlStateNormal];
        }
        [btnFunc setImage:nil forState:UIControlStateNormal];
        [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(0, 25, 0, 0)];
        [btnFunc setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
        [btnFunc setTag:10000+indexPath.row];
    }
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
    
    if(btnSender.tag<1000) {
        //第一区块
        
        //清除背景色
        UITableViewCell *cell = (UITableViewCell *)btnSender.superview.superview;
        for (UIView *view in cell.superview.subviews) {
            if([view isKindOfClass:[UITableViewCell class]]) {
                UITableViewCell *cell = (UITableViewCell *)view;
                cell.backgroundColor = BACK_COLOR;
            }
        }
        cell.backgroundColor = [UIColor whiteColor];
        
        switch (self.currentItem.tag) {
            case 100: {
                //医院
                KHYHospitalModel *model;
                if(self.hospitalArr.count) {
                    model = [self.hospitalArr objectAtIndex:btnSender.tag-100];
                }
                if(self.callHospitalBack) {
                    self.hospitalStr = model.hospital_id;
                    self.callHospitalBack(model.hospital_id, model.name);
                    [self dismiss];
                }
                
                break;
            }
            case 200: {
                //科室
                KHYKeshiModel *model;
                if(self.keshiArr.count) {
                    model = [self.keshiArr objectAtIndex:btnSender.tag-100];
                }
                if(self.callKeshiBack) {
                    self.callKeshiBack(model.keshi_id, model.name);
                    [self dismiss];
                }
                
                break;
            }
            case 300: {
                //地区
                
                ProvinceModel *model = [self.provinceArr objectAtIndex:btnSender.tag-100];
                self.cityArr = model.city_list;
                
                //清空县区数据
                self.districtArr = [NSArray new];
                
                break;
            }
                
            default:
                break;
        }
        
        [self.tableView1 reloadData];
        [self.tableView2 reloadData];
        self.tableView1.height = self.tableView.height;
        
    }else if(btnSender.tag<10000) {
        //第二区块
        
        //清除背景色
        UITableViewCell *cell = (UITableViewCell *)btnSender.superview.superview;
        for (UIView *view in cell.superview.subviews) {
            if([view isKindOfClass:[UITableViewCell class]]) {
                UITableViewCell *cell = (UITableViewCell *)view;
                cell.backgroundColor = [UIColor whiteColor];
                UIButton *btnFunc = (UIButton *)cell.contentView.subviews[0];
                [btnFunc setImage:nil forState:UIControlStateNormal];
            }
        }
        [btnSender setImage:[UIImage imageNamed:@"cell_icon_select"] forState:UIControlStateNormal];
        
        
        switch (self.currentItem.tag) {
            case 300: {
                //地区
                CityModel *model = [self.cityArr objectAtIndex:btnSender.tag-1000];
                self.districtArr = model.district_list;
                
                break;
            }
                
            default:
                break;
        }
        
        [self.tableView2 reloadData];
        self.tableView2.height = self.tableView.height;
        
    }else if(btnSender.tag>=10000) {
        //第三区块
        
        //清除背景色
        UITableViewCell *cell = (UITableViewCell *)btnSender.superview.superview;
        for (UIView *view in cell.superview.subviews) {
            if([view isKindOfClass:[UITableViewCell class]]) {
                UITableViewCell *cell = (UITableViewCell *)view;
                cell.backgroundColor = BACK_COLOR;
                UIButton *btnFunc = (UIButton *)cell.contentView.subviews[0];
                [btnFunc setImage:nil forState:UIControlStateNormal];
            }
        }
        cell.backgroundColor = [UIColor whiteColor];
        [btnSender setImage:[UIImage imageNamed:@"cell_icon_select"] forState:UIControlStateNormal];
        
        DistrictModel *model = [self.districtArr objectAtIndex:btnSender.tag-10000];
        [self.currentItem setTitle:model.district_name forState:UIControlStateNormal];
        if(self.callAreaBack) {
            self.area_idStr = model.district_id;
            self.callAreaBack(model.district_id, model.district_name);
            [self dismiss];
        }
        
    }

}

/**
 *  获取城市列表
 */
- (void)getCityList {
    
    self.provinceArr = [ProvinceModel mj_objectArrayWithFilename:@"address.plist"];
    if(self.provinceArr.count) {
        self.cityArr = ((ProvinceModel *)[self.provinceArr objectAtIndex:0]).city_list;
    }
    if(self.cityArr.count) {
        self.districtArr = ((CityModel *)[self.cityArr objectAtIndex:0]).district_list;
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
