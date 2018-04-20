//
//  KBarButtonItem.h
//  YiJiaMao_S
//
//  Created by 相约在冬季 on 2016/12/16.
//  Copyright © 2016年 e-yoga. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SNNavItemStyle) {
    
    SNNavItemStyleLeft, //左侧按钮
    SNNavItemStyleRight, //右侧按钮
    SNNavItemStyleDone,
};

@interface KBarButtonItem : UIBarButtonItem

+ (instancetype)itemWithTitle:(NSString *)title
                        image:(NSString *)imageName
                        Style:(SNNavItemStyle)style
                       target:(id)target
                       action:(SEL)action;

@end
