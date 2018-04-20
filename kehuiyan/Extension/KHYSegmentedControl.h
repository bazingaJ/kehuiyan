//
//  KHYSegmentedControl.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/23.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSegmentedControl.h"

@protocol KHYSegmentedControlDelegate <NSObject>

- (void)KHYSegmentedControlSegmentClick:(NSInteger)segmentIndex;

@end

@interface KHYSegmentedControl : UIView

@property (assign) id<KHYSegmentedControlDelegate> delegate;
@property (nonatomic, assign) NSInteger segmentIndex;
- (id)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr;

@end
