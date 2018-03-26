//
//  KHYCityPickerView.h
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/3/16.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JXAreaViewDelegate <NSObject>

- (void)leftBtnClick;
- (void)rightBtnClickWithIDs:(NSArray *)ids Strings:(NSArray *)strs;

@end

@interface JXDistrictModel : NSObject

@property (nonatomic, strong) NSString *district_id;
@property (nonatomic, strong) NSString *district_name;

@end

@interface JXCityModel : NSObject

@property (nonatomic, strong) NSString *city_id;
@property (nonatomic, strong) NSString *city_name;
@property (nonatomic, strong) NSArray *district_list;

@end

@interface JXProvinceModel : NSObject

@property (nonatomic, strong) NSString *province_id;
@property (nonatomic, strong) NSString *province_name;
@property (nonatomic, strong) NSArray  *city_list;

@end

@interface KHYCityPickerView : UIView <UIPickerViewDataSource,UIPickerViewDelegate>

//回调
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) NSDictionary *pickerDic;
@property (nonatomic, strong) NSArray *provinceArr;
@property (nonatomic, strong) NSArray *cityArr;
@property (nonatomic, strong) NSArray *districtArr;
@property (nonatomic, strong) UIView *bottomView;//包括导航视图和地址选择视图
@property (nonatomic, strong) UIPickerView *pickView;//地址选择视图
@property (nonatomic, strong) UIView *navigationView;//上面的导航视图
@property (nonatomic, assign) id<JXAreaViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame withDataArr:(NSArray *)arr;

@end
