//
//  KHYHomeMenuView.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/10.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KHYHomeMenuViewDelegate <NSObject>

- (void)KHYHomeMenuViewAtIndexClick:(NSInteger)tIndex;

@end

@interface KHYHomeMenuView : UIView

@property (assign) id<KHYHomeMenuViewDelegate> delegate;

@end
