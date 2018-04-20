//
//  KHYDatePickerView.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/11.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KHYDatePickerView : UIView<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, assign) CGFloat yPosition;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) UIScrollView *scrollView;

- (void)show;
- (void)dismiss;

/**
 *  回调函数
 */
@property (nonatomic, copy) void(^callBack) (NSString *dateStr);

@end
