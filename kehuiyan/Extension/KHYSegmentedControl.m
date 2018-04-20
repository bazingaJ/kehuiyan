//
//  KHYSegmentedControl.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/23.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYSegmentedControl.h"

@interface KHYSegmentedControl () {
    HMSegmentedControl *segmentedControl;
}

@end

@implementation KHYSegmentedControl

- (id)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr {
    self = [super initWithFrame:frame];
    if(self) {
        
        WS(weakSelf);
        segmentedControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [segmentedControl setSectionTitles:titleArr];
        [segmentedControl setSelectedSegmentIndex:self.segmentIndex];
        [segmentedControl setTextColor:COLOR9];
        [segmentedControl setFont:FONT16];
        [segmentedControl setSelectedTextColor:MAIN_COLOR];
        [segmentedControl setSelectionIndicatorColor:MAIN_COLOR];
        //[self.segmentedControl setSelectionStyle:HMSegmentedControlSelectionStyleBox];
        //[self.segmentedControl setSelectionIndicatorLocation:HMSegmentedControlSelectionIndicatorLocationUp];
        [segmentedControl setSelectionIndicatorLocation:HMSegmentedControlSelectionIndicatorLocationDown];
        [segmentedControl setSelectionIndicatorHeight:2];
        [segmentedControl setSelectionStyle:HMSegmentedControlSelectionStyleFullWidthStripe];
        [segmentedControl setBackgroundColor:[UIColor whiteColor]];
        [segmentedControl setIndexChangeBlock:^(NSInteger index) {
            if([weakSelf.delegate respondsToSelector:@selector(KHYSegmentedControlSegmentClick:)]) {
                [weakSelf.delegate KHYSegmentedControlSegmentClick:index];
            }
        }];
        [self addSubview:segmentedControl];
        
        //创建“下划线”
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-0.5, frame.size.width, 0.5)];
        [lineView setBackgroundColor:BACK_COLOR];
        [self addSubview:lineView];
        
    }
    return self;
}

- (void)setSegmentIndex:(NSInteger)segmentIndex {
    _segmentIndex = segmentIndex;
    [segmentedControl setSelectedSegmentIndex:segmentIndex];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
