//
//  MHSelectPickerView.h
//  AIYISHU
//
//  Created by 相约在冬季 on 16/4/11.
//  Copyright © 2016年 AIYISHU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHSelectPickerView : UIView
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHeight;

@end
