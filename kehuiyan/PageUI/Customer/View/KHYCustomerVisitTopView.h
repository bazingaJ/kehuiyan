//
//  KHYCustomerVisitTopView.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/24.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KHYCustomerVisitTopViewDelegate <NSObject>

- (void)KHYCustomerVisitTopViewConfirmClick:(NSString *)startTime endTime:(NSString *)endTime;

@end

@interface KHYCustomerVisitTopView : UIView

@property (assign) id<KHYCustomerVisitTopViewDelegate> delegate;

@end
