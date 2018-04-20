//
//  KHYScheduleDayTopView.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/23.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YJXDayTopViewDelegate <NSObject>

/**
 左边的箭头按钮点击事件

 @param dateStr 获取到点击过后的字符串
 */
- (void)leftArrowClickGetDateString:(NSDate *)dateStr;

- (void)rightArrowClickGetDateString:(NSDate *)dateStr;

@end

@interface KHYScheduleDayTopView : UIView
@property (nonatomic, assign) id<YJXDayTopViewDelegate> delegate;
@end
