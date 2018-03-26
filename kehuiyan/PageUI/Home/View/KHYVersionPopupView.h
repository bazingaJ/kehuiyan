//
//  KHYVersionPopupView.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/10.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KHYVersionPopupView;

@protocol KHYVersionPopupViewDelegate <NSObject>

@optional

- (void)popupView:(KHYVersionPopupView *)popupView withSender:(UIButton *)sender;
- (void)popupView:(KHYVersionPopupView *)popupView dismissWithSender:(id)sender;

@end

@interface KHYVersionPopupView : UIView

@property (assign) id<KHYVersionPopupViewDelegate> delegate;
- (id)initWithFrame:(CGRect)frame param:(NSMutableDictionary *)param;

@end
