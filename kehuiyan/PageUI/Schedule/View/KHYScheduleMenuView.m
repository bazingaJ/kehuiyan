//
//  KHYScheduleMenuView.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/23.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYScheduleMenuView.h"

@implementation KHYScheduleMenuView

- (id)initWithFrame:(CGRect)frame detailArr:(NSArray *)detailArr{
    self = [super initWithFrame:frame];
    if(self) {
        
        //设置背景色
        self.backgroundColor = [UIColor whiteColor];
        
//        NSArray *titleArr = @[@"本周总任务",@"已完成",@"已逾期"];
        CGFloat tWidth = frame.size.width/3;
        for (int i=0; i<3; i++) {
            
            //创建“背景层”
            UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(tWidth*i, 0, tWidth-1, 90)];
            [self addSubview:btnFunc];
            
            //创建“数量”
            UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake((tWidth-45)/2, 10, 45, 45)];
            [lbMsg setText:@"0"];
            [lbMsg setTextColor:[UIColor whiteColor]];
            [lbMsg setFont:FONT16];
            lbMsg.tag = 20 + i;
            [lbMsg setTextAlignment:NSTextAlignmentCenter];
            [lbMsg setBackgroundColor:GREEN_COLOR];
            [lbMsg.layer setCornerRadius:22.5];
            [lbMsg.layer setMasksToBounds:YES];
            [btnFunc addSubview:lbMsg];
            
            //创建“标题”
            UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, tWidth, 25)];
            [lbMsg2 setText:detailArr[i]];
            [lbMsg2 setTextColor:COLOR3];
            [lbMsg2 setTextAlignment:NSTextAlignmentCenter];
            [lbMsg2 setFont:FONT15];
            [btnFunc addSubview:lbMsg2];
            
        }
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
