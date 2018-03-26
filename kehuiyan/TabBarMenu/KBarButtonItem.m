//
//  KBarButtonItem.m
//  YiJiaMao_S
//
//  Created by 相约在冬季 on 2016/12/16.
//  Copyright © 2016年 e-yoga. All rights reserved.
//

#import "KBarButtonItem.h"

@implementation KBarButtonItem

+ (instancetype)itemWithTitle:(NSString *)title
                        image:(NSString *)imageName
                        Style:(SNNavItemStyle)style
                       target:(id)target
                       action:(SEL)action {
    if (style == SNNavItemStyleLeft) {
        //左侧按钮
        UIButton *btnLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        btnLeftButton.backgroundColor = [UIColor clearColor];
        if(!IsStringEmpty(imageName)) {
            [btnLeftButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            [btnLeftButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
        }else if(IsStringEmpty(title)) {
            [btnLeftButton setImage:[UIImage imageNamed:@"left_arrow_white"] forState:UIControlStateNormal];
            [btnLeftButton setImage:[UIImage imageNamed:@"left_arrow_white"] forState:UIControlStateHighlighted];
        }else{
            [btnLeftButton setTitle:title forState:UIControlStateNormal];
            [btnLeftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        //[btnLeftButton setBackgroundColor:[UIColor redColor]];
        btnLeftButton.frame = CGRectMake(0, 0, 30, 40);
        btnLeftButton.titleLabel.font = FONT15;
        btnLeftButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        [btnLeftButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        KBarButtonItem *item = [[KBarButtonItem alloc] initWithCustomView:btnLeftButton];
        return item;
    }else if(style == SNNavItemStyleRight) {
        //右侧按钮
        UIButton *btnRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        btnRightButton.backgroundColor = [UIColor clearColor];
        btnRightButton.frame = CGRectMake(0, 0, 60, 30);
        btnRightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
        [btnRightButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        if(!IsStringEmpty(imageName)) {
            [btnRightButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            [btnRightButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
        }else if(IsStringEmpty(title)) {
            [btnRightButton setImage:[UIImage imageNamed:@"left_arrow_white"] forState:UIControlStateNormal];
            [btnRightButton setImage:[UIImage imageNamed:@"left_arrow_white"] forState:UIControlStateHighlighted];
        }else{
            [btnRightButton setTitle:title forState:UIControlStateNormal];
            [btnRightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btnRightButton.titleLabel setFont:FONT15];
            [btnRightButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
            btnRightButton.frame = CGRectMake(0, 0, 100, 30);
        }
//        [btnRightButton setBackgroundColor:[UIColor redColor]];
//        btnRightButton.frame = CGRectMake(0, 0, 30, 40);
//        btnRightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        [btnRightButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        KBarButtonItem *item = [[KBarButtonItem alloc] initWithCustomView:btnRightButton];
        return item;
    }else {
        return nil;
    }
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    
    if ([self.customView isKindOfClass:[UIControl class]]) {
        UIControl *ctrl = (UIControl *)self.customView;
        ctrl.enabled = enabled;
    }
}

@end
