//
//  KHYCustomerVisitTopView.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/24.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYCustomerVisitTopView.h"
#import "MHDatePicker.h"

@interface KHYCustomerVisitTopView () {
    NSString *startTime;
    NSString *endTime;
    
    NSDate *startDate;
    NSDate * endDate;
}

@end

@implementation KHYCustomerVisitTopView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
        //设置背景色
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat tWidth = (SCREEN_WIDTH-75-40-30)/2;
        for (int i=0; i<2; i++) {
            
            //创建“背景层”
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(10+(tWidth+40)*i, 7.5, tWidth, 30)];
            [backView.layer setCornerRadius:4.0];
            [backView.layer setBorderWidth:0.5];
            [backView.layer setBorderColor:LINE_COLOR.CGColor];
            [backView.layer setMasksToBounds:YES];
            [backView setUserInteractionEnabled:YES];
            [self addSubview:backView];
            
            //创建“内容框”
            UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, backView.frame.size.width-20, 30)];
            if(i==0) {
                [btnFunc setTitle:@"开始时间" forState:UIControlStateNormal];
            }else if(i==1) {
                [btnFunc setTitle:@"结束时间" forState:UIControlStateNormal];
            }
            [btnFunc setTitleColor:COLOR9 forState:UIControlStateNormal];
            [btnFunc.titleLabel setFont:FONT15];
            [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [btnFunc addTouch:^{
                NSLog(@"选择时间");
                
                if(i==0) {
                    //开始时间
                    
                    MHDatePicker *selectDatePicker = [[MHDatePicker alloc] init];
                    selectDatePicker.isBeforeTime = YES;
                    selectDatePicker.datePickerMode = UIDatePickerModeDate;
                    [selectDatePicker didFinishSelectedDate:^(NSDate *selectedDate) {
                        startDate = selectedDate;
                        
                        //MM月dd日 HH:mm
                        startTime = [NSString dateStringWithDate:selectedDate DateFormat:@"yyyy-MM-dd"];
                        [btnFunc setTitle:startTime forState:UIControlStateNormal];
                        [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
                        
                    }];
                    
                }else if(i==1) {
                    //结束时间
                    
                    MHDatePicker *selectDatePicker = [[MHDatePicker alloc] init];
                    selectDatePicker.isBeforeTime = YES;
                    selectDatePicker.datePickerMode = UIDatePickerModeDate;
                    [selectDatePicker didFinishSelectedDate:^(NSDate *selectedDate) {
                        
                        //开始时间和结束时间验证
                        if([selectedDate timeIntervalSince1970] <[startDate timeIntervalSince1970]) {
                            [MBProgressHUD showMessage:@"结束时间必须大于开始时间" toView:nil];
                            return ;
                        }
                        
                        //MM月dd日 HH:mm
                        endTime = [NSString dateStringWithDate:selectedDate DateFormat:@"yyyy-MM-dd"];
                        [btnFunc setTitle:endTime forState:UIControlStateNormal];
                        [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
                        
                    }];
                    
                }
                
            }];
            [backView addSubview:btnFunc];
            
        }
        
        //创建“中间的分割线”
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(10+tWidth+5, 22, 30, 1)];
        [lineView2 setBackgroundColor:COLOR3];
        [self addSubview:lineView2];
        
        //创建“确认按钮”
        UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-85, 7.5, 75, 30)];
        [btnFunc setTitle:@"确认" forState:UIControlStateNormal];
        [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnFunc.titleLabel setFont:FONT16];
        [btnFunc setBackgroundColor:MAIN_COLOR];
        [btnFunc.layer setCornerRadius:4.0];
        [btnFunc addTouch:^{
            NSLog(@"确认");
            
            if([self.delegate respondsToSelector:@selector(KHYCustomerVisitTopViewConfirmClick:endTime:)]) {
                [self.delegate KHYCustomerVisitTopViewConfirmClick:startTime endTime:endTime];
            }
            
        }];
        [self addSubview:btnFunc];
        
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
