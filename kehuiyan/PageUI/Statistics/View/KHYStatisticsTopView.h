//
//  KHYStatisticsTopView.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/24.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JXStatisticsTopViewDelegate <NSObject>

- (void)selectedTopViewIndex:(NSInteger)index;

@end

@interface KHYStatisticsTopView : UIView

@property (nonatomic, assign) id<JXStatisticsTopViewDelegate>delegate;

@end
