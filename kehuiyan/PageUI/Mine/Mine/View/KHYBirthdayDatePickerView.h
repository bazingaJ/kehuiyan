//
//  KHYBirthdayDatePickerView.h
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/3/13.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JXDatePickerValueChange <NSObject>

//- (void)datePickerValueChangeWithString:(NSString *)dateStr;

- (void)cancelBtnClick;

- (void)containBtnClickWithDateString:(NSString *)dateStr;

@end

@interface KHYBirthdayDatePickerView : UIView

@property (weak, nonatomic) IBOutlet UIDatePicker *JXDatePicker;
@property (nonatomic, assign) id<JXDatePickerValueChange>delegate;

@end
