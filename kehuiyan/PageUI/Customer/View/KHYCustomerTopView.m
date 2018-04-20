//
//  KHYCustomerTopView.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/3/14.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYCustomerTopView.h"

@interface KHYCustomerTopView ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *searchTF;
@end

@implementation KHYCustomerTopView

- (id)initWithFrame:(CGRect)frame
{
    
    if(self = [super initWithFrame:frame])
    {
        //设置背景色
        self.backgroundColor = BACK_COLOR;
        WS(weakSelf);
        NSMutableArray *titleArr = [NSMutableArray array];
        [titleArr addObject:@[@"地区",@"300"]];//三级下拉联动
        [titleArr addObject:@[@"医院",@"100"]];//一级下拉列表
        [titleArr addObject:@[@"科室",@"200"]];//一级下拉联动
        
        UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        vi.backgroundColor = [UIColor whiteColor];
        [self addSubview:vi];
        
        self.searchTF = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-50, 45)];
        self.searchTF.delegate = self;
        self.searchTF.placeholder = @"请输入客户名进行查询";
        self.searchTF.font = [UIFont systemFontOfSize:15];
        self.searchTF.borderStyle = UITextBorderStyleNone;
        [self addSubview:self.searchTF];
        
        UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        searchBtn.frame = CGRectMake(SCREEN_WIDTH - 50, 0, 30, 45);
        [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
        [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:searchBtn];
        
        self.dropDownMenu = [[KHYCustomerDropDown alloc] initWithFrame:CGRectMake(0, 55, self.frame.size.width, 45) titleArr:titleArr];
//        [self.dropDownMenu getKeshiList];
        self.dropDownMenu.callAreaBack = ^(NSString *district_id, NSString *district_name) {
            NSLog(@"地区：%@-%@",district_id,district_name);
            if([weakSelf.delegate respondsToSelector:@selector(KHYCustomerTopViewAreaSelectClick:)]) {
                [weakSelf.delegate KHYCustomerTopViewAreaSelectClick:district_id];
            }
        };
        self.dropDownMenu.callHospitalBack = ^(NSString *hospital_id, NSString *hospital_name) {
            NSLog(@"医院：%@-%@",hospital_id,hospital_name);
            if([weakSelf.delegate respondsToSelector:@selector(KHYCustomerTopViewHospitalSelectClick:)]) {
                [weakSelf.delegate KHYCustomerTopViewHospitalSelectClick:hospital_id];
            }
        };
        self.dropDownMenu.callKeshiBack = ^(NSString *keshi_id, NSString *keshi_name) {
            NSLog(@"科室：%@-%@",keshi_id,keshi_name);
            if([weakSelf.delegate respondsToSelector:@selector(KHYCustomerTopViewKeshiSelectClick:)]) {
                [weakSelf.delegate KHYCustomerTopViewKeshiSelectClick:keshi_id];
            }  
        };
        [self addSubview:self.dropDownMenu];
        
    }
    return self;
}

- (void)searchBtnClick
{
    NSString *searchStr = self.searchTF.text;
    if ([self.delegate respondsToSelector:@selector(KHYCustomerTopViewSearchBarViewClick:)])
    {
        [self.delegate KHYCustomerTopViewSearchBarViewClick:searchStr];
    }
    
}

@end
