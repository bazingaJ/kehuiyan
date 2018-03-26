//
//  KHYCityPickerView.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/3/16.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYCityPickerView.h"

@interface KHYCityPickerView ()

@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, strong) NSMutableArray *selectedArr;

@property (nonatomic, strong) NSMutableArray *idArr;

@property (nonatomic, strong) NSMutableArray *nameArr;

@end

static const CGFloat yPosition = 300;

@implementation KHYCityPickerView

- (instancetype)initWithFrame:(CGRect)frame withDataArr:(NSArray *)arr
{
    if (self = [super initWithFrame:frame])
    {
        self.idArr = [NSMutableArray array];
        self.nameArr = [NSMutableArray array];
        
        // 获取数据传递进来的初始值 - 不用滚动选择的所有都是第一行的值
        //第一个id
        NSDictionary *dic= arr[0];
        NSString *firstID = dic[@"province_id"];
        NSString *firstName = dic[@"province_name"];

        NSArray *arr1 = dic[@"city_list"];
        NSDictionary *secondDic = arr1[0];
        NSString *secondID = secondDic[@"city_id"];
        NSString *secondName = secondDic[@"city_name"];
        
        NSArray *arr2 = secondDic[@"district_list"];
        NSDictionary *thirdDic = arr2[0];
        NSString *thirdID = thirdDic[@"district_id"];
        NSString *thirdName = thirdDic[@"district_name"];
        
        [self.idArr addObject:firstID];
        [self.idArr addObject:secondID];
        [self.idArr addObject:thirdID];
        
        [self.nameArr addObject:firstName];
        [self.nameArr addObject:secondName];
        [self.nameArr addObject:thirdName];
        
        self.selectedArr = [NSMutableArray array];
        [self.selectedArr addObject:@"0"];
        [self.selectedArr addObject:@"0"];
        [self.selectedArr addObject:@"0"];
        //设置frame
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        self.userInteractionEnabled = YES;
        
        UIView *vi = [[UIView alloc] init];
        vi.frame = CGRectMake(0, self.height-yPosition, SCREEN_WIDTH, 50);
        vi.backgroundColor = kRGB(240, 240, 240);
        [self addSubview:vi];
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CGRectMake(10, 0, 80, 50);
        [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [leftBtn setTitleColor:COLOR3 forState:UIControlStateNormal];
        leftBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [vi addSubview:leftBtn];
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(SCREEN_WIDTH - 90, 0, 80, 50);
        [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
        [rightBtn setTitleColor:COLOR3 forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [vi addSubview:rightBtn];
        
        
        self.pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.height-250, SCREEN_WIDTH, 250)];
        self.pickView.backgroundColor = [UIColor whiteColor];
        self.pickView.dataSource = self;
        self.pickView.delegate = self;
        [self addSubview:self.pickView];
        
        self.dataArr = arr;
        
    }
    
    return self;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
    {
        return self.dataArr.count;
    }
    else if (component == 1)
    {
        NSString *sele2 = self.selectedArr[0];
        NSDictionary *dic = self.dataArr[[sele2 integerValue]];
        NSArray *arr = dic[@"city_list"];
        return arr.count;
    }
    else
    {
        NSString *sele2 = self.selectedArr[0];
        NSString *sele3 = self.selectedArr[1];
        NSDictionary *dic = self.dataArr[[sele2 integerValue]];
        NSArray *arr = dic[@"city_list"];
        NSDictionary *dic1 = arr[[sele3 integerValue]];
        NSArray *arr1 = dic1[@"district_list"];
        return arr1.count;
    }
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return SCREEN_WIDTH / 3 - 20;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.f;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    UILabel *lable = [[UILabel alloc]init];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = [UIFont systemFontOfSize:17.0f];
    
    if (component == 0)
    {
        NSDictionary *dic= self.dataArr[row];
        lable.text = dic[@"province_name"];
    }
    else if (component == 1)
    {
        NSString *sele1 = self.selectedArr[0];
        NSDictionary *dic= self.dataArr[[sele1 integerValue]];
        
        NSArray *arr = dic[@"city_list"];
        NSDictionary *dic2 = arr[row];
        lable.text = dic2[@"city_name"];
    }
    else
    {
        NSString *sele1 = self.selectedArr[0];
        NSDictionary *dic= self.dataArr[[sele1 integerValue]];
        
        
        NSString *sele2 = self.selectedArr[1];
        NSArray *arr = dic[@"city_list"];
        NSDictionary *dic2 = arr[[sele2 integerValue]];
        
        NSArray *arr2 = dic2[@"district_list"];
        NSDictionary *dic3 = arr2[row];
        lable.text = dic3[@"district_name"];
        
    }
    
    return lable;

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self.idArr removeAllObjects];
    [self.nameArr removeAllObjects];
    if (component == 0)
    {
        [self.selectedArr replaceObjectAtIndex:0 withObject:@(row).stringValue];
        
        [self.selectedArr replaceObjectAtIndex:1 withObject:@(0).stringValue];
        [self.pickView reloadComponent:1];
        [self.pickView selectRow:0 inComponent:1 animated:YES];
        
        [self.pickView reloadComponent:2];
        [self.pickView selectRow:0 inComponent:2 animated:YES];
    }
    else if (component == 1)
    {
        [self.selectedArr replaceObjectAtIndex:1 withObject:@(row).stringValue];
        [self.pickView reloadComponent:2];
        [self.pickView selectRow:0 inComponent:2 animated:YES];
    }
    else
    {
        [self.selectedArr replaceObjectAtIndex:2 withObject:@(row).stringValue];
    }
    
}

- (void)leftBtnClick
{
    if ([self.delegate respondsToSelector:@selector(leftBtnClick)])
    {
        [self.delegate leftBtnClick];
    }
    
}

- (void)rightBtnClick
{
    // 省的id 和name
    NSString *firstRow = self.selectedArr[0];
    NSDictionary *firstDic = self.dataArr[[firstRow integerValue]];
    
    NSString *firstID = firstDic[@"province_id"];
    NSString *firstName = firstDic[@"province_name"];
    
    // 市的id 和name
    NSString *secondRow = self.selectedArr[1];
    NSArray *arr = firstDic[@"city_list"];
    NSDictionary *secondDic = arr[[secondRow integerValue]];
    
    NSString *secondID = secondDic[@"city_id"];
    NSString *secondName = secondDic[@"city_name"];
    
    // 区的id 和name
    NSString *thirdRow = self.selectedArr[2];
    NSArray *arr2 = secondDic[@"district_list"];
    NSDictionary *thirdDic = arr2[[thirdRow integerValue]];
    
    NSString *thirdID = thirdDic[@"district_id"];
    NSString *thirdName = thirdDic[@"district_name"];
    
    
    NSLog(@"===ID是%@=====NAME是%@",@[firstID,secondID,thirdID],@[firstName,secondName,thirdName]);
    [self.idArr addObject:firstID];
    [self.idArr addObject:secondID];
    [self.idArr addObject:thirdID];
    
    [self.nameArr addObject:firstName];
    [self.nameArr addObject:secondName];
    [self.nameArr addObject:thirdName];
    
    if ([self.delegate respondsToSelector:@selector(rightBtnClickWithIDs:Strings:)])
    {
        [self.delegate rightBtnClickWithIDs:self.idArr Strings:self.nameArr];
    }
    
}

@end
