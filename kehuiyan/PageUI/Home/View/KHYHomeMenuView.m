//
//  KHYHomeMenuView.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/10.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYHomeMenuView.h"

@implementation KHYHomeMenuView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
        //设置背景色
        self.backgroundColor = [UIColor whiteColor];
        
        //设置数据源
        NSMutableArray *titleArr = [NSMutableArray array];
        [titleArr addObject:@[@"home_icon_task",@"新建任务",@"0"]];
        [titleArr addObject:@[@"home_icon_customer",@"新增客户",@"1"]];
        if ([[HelperManager CreateInstance].position_id isEqualToString:@"20"])
        {
            [titleArr addObject:@[@"home_ExpertsQuestions",@"专家提问",@"2"]];
        }
        else
        {
            [titleArr addObject:@[@"home_ExpertsQuestions",@"咨询列表",@"2"]];
        }
        [titleArr addObject:@[@"home_patientActivity",@"患教活动",@"3"]];
        [titleArr addObject:@[@"home_icon_schedule",@"查看日程",@"4"]];
        
//        [titleArr addObject:@[@"home_icon_qingjia",@"发起请假",@"5"]];
        
        //布局渲染
        CGFloat tWidth = SCREEN_WIDTH/3;
        for (int i=0; i<2; i++) {
            for (int k=0; k<3; k++) {
                NSInteger tIndex = 3*i+k;
                if(tIndex>[titleArr count]-1) continue;
                
                NSArray *itemArr = [titleArr objectAtIndex:tIndex];
                
                //创建“背景层”
                UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(tWidth*k, 90*i, tWidth-1, 89)];
                [btnFunc setBackgroundColor:[UIColor whiteColor]];
                [btnFunc addTouch:^{
                    NSLog(@"点击");
                    
                    if([self.delegate respondsToSelector:@selector(KHYHomeMenuViewAtIndexClick:)]) {
                        [self.delegate KHYHomeMenuViewAtIndexClick:tIndex];
                    }
                    
                }];
                [self addSubview:btnFunc];
                
                //创建“图标”
                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((tWidth-45)/2, 10, 45, 45)];
                [imgView setImage:[UIImage imageNamed:itemArr[0]]];
                [btnFunc addSubview:imgView];
                
                //创建“标题”
                UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 65, tWidth-20, 20)];
                [lbMsg setText:itemArr[1]];
                [lbMsg setTextColor:COLOR3];
                [lbMsg setTextAlignment:NSTextAlignmentCenter];
                [lbMsg setFont:FONT14];
                [btnFunc addSubview:lbMsg];
                
            }
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
