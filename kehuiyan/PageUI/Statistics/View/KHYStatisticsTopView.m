//
//  KHYStatisticsTopView.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/24.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYStatisticsTopView.h"
#import "KHYSegmentedControl.h"

@interface KHYStatisticsTopView ()<KHYSegmentedControlDelegate> {
    NSArray *titleArr;
}

@property (nonatomic, strong) KHYSegmentedControl *segmentView;
@property (nonatomic, strong) UILabel *lbMsg;

@end

@implementation KHYStatisticsTopView

/**
 *  切换视图
 */
- (KHYSegmentedControl *)segmentView {
    if(!_segmentView) {
        _segmentView = [[KHYSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45) titleArr:titleArr];
        [_segmentView setDelegate:self];
        [self addSubview:_segmentView];
    }
    return _segmentView;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
        //设置背景层
        self.backgroundColor = BACK_COLOR;
        
        //设置数据源
        titleArr = @[@"日",@"周",@"月",@"季",@"年"];
        
        //顶部视图
        [self segmentView];
        
        //创建“背景层”
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 55, frame.size.width, 45)];
        [backView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:backView];
        
        //创建“数据纬度”
        self.lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, frame.size.width-20, 25)];
        [self.lbMsg setText:@"当月数据"];
        [self.lbMsg setTextColor:COLOR3];
        [self.lbMsg setTextAlignment:NSTextAlignmentLeft];
        [self.lbMsg setFont:FONT17];
        [backView addSubview:self.lbMsg];
        
    }
    return self;
}

/**
 *  切换按钮委托代理
 */
- (void)KHYSegmentedControlSegmentClick:(NSInteger)segmentIndex {
    NSLog(@"切换按钮委托代理：%zd",segmentIndex);
    if ([self.delegate respondsToSelector:@selector(selectedTopViewIndex:)])
    {
        [self.delegate selectedTopViewIndex:segmentIndex];
    }
    NSString *titleStr = [NSString stringWithFormat:@"当%@数据",titleArr[segmentIndex]];
    [self.lbMsg setText:titleStr];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
