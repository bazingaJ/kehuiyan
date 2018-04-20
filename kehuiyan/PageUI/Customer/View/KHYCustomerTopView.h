//
//  KHYCustomerTopView.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/3/14.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHYCustomerDropDown.h"

@protocol KHYCustomerTopViewDelegate <NSObject>

- (void)KHYCustomerTopViewSearchBarViewClick:(NSString *)searchStr;
- (void)KHYCustomerTopViewAreaSelectClick:(NSString *)district_id;
- (void)KHYCustomerTopViewHospitalSelectClick:(NSString *)hospital_id;
- (void)KHYCustomerTopViewKeshiSelectClick:(NSString *)keshi_id;

@end

@interface KHYCustomerTopView : UIView

@property (assign) id<KHYCustomerTopViewDelegate> delegate;
@property (nonatomic, strong) KHYCustomerDropDown *dropDownMenu;

@end
