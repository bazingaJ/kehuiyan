//
//  KHYStatisticsCell.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/24.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYStatisticsCell.h"

@implementation KHYStatisticsCell

- (void)setStatisticsCell:(NSArray *)titleArr {
    
    //创建“图标”
    UIImage *img = [UIImage imageNamed:titleArr[0]];
    CGFloat tW = img.size.width;
    CGFloat tH = img.size.height;
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10+(55-tW)/2, (50-tH)/2, tW, tH)];
    [imgView setImage:img];
    [self.contentView addSubview:imgView];
    
    //创建“标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 55, 15)];
    [lbMsg setText:titleArr[1]];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentCenter];
    [lbMsg setFont:FONT11];
    [self.contentView addSubview:lbMsg];
    
    CGFloat tWidth = (SCREEN_WIDTH-70*2)/2;
    for (int i=0; i<2; i++) {
        
        //创建“背景层”
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(70+tWidth*i, 0, tWidth-1, 75)];
        [self.contentView addSubview:backView];
        
        //创建“数量”
        NSString *titleStr = @"120家";
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, tWidth-20, 30)];
        [lbMsg setText:titleStr];
        [lbMsg setTextColor:MAIN_COLOR];
        [lbMsg setTextAlignment:NSTextAlignmentCenter];
        [lbMsg setFont:FONT17];
        lbMsg.tag = i + 30;
        [backView addSubview:lbMsg];
        if(!IsStringEmpty(titleStr)) {
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:titleStr];
            //字体颜色
            [attrStr addAttribute:NSForegroundColorAttributeName
                            value:COLOR3
                            range:NSMakeRange([titleStr length]-1, 1)];
            //字体大小
            [attrStr addAttribute:NSFontAttributeName
                            value:FONT11
                            range:NSMakeRange([titleStr length]-1, 1)];
            
            lbMsg.attributedText = attrStr;
        }
        
        //创建“描述”
        UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, tWidth-20, 15)];
        if(i==0) {
            [lbMsg2 setText:@"上月"];
        }else if(i==1) {
            [lbMsg2 setText:@"本月"];
        }
        [lbMsg2 setTextColor:COLOR3];
        [lbMsg2 setTextAlignment:NSTextAlignmentCenter];
        [lbMsg2 setFont:FONT11];
        [backView addSubview:lbMsg2];
        
    }
    
    //创建“百分比”
//    NSString *titleStr = @"102%";
//    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-70, 25, 45, 25)];
//    [lbMsg2 setText:titleStr];
//    [lbMsg2 setTextColor:MAIN_COLOR];
//    [lbMsg2 setTextAlignment:NSTextAlignmentRight];
//    [lbMsg2 setFont:FONT16];
//    [self.contentView addSubview:lbMsg2];
//    if(!IsStringEmpty(titleStr)) {
//        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:titleStr];
//        //字体颜色
//        [attrStr addAttribute:NSForegroundColorAttributeName
//                        value:COLOR3
//                        range:NSMakeRange([titleStr length]-1, 1)];
//        //字体大小
//        [attrStr addAttribute:NSFontAttributeName
//                        value:FONT11
//                        range:NSMakeRange([titleStr length]-1, 1)];
//
//        lbMsg2.attributedText = attrStr;
//    }
//
//    //创建“箭头”
//    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20, 28.5, 10.5, 18)];
//    [imgView2 setImage:[UIImage imageNamed:@"tongji_icon_up"]];
//    [self.contentView addSubview:imgView2];
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 74.5, SCREEN_WIDTH, 0.5)];
    [lineView setBackgroundColor:LINE_COLOR];
    [self.contentView addSubview:lineView];
    
}

- (void)firstString:(NSString *)string secondString:(NSString *)str
{
    UILabel *firstLab = (UILabel *)[self.subviews[0].subviews[2] viewWithTag:30];
    firstLab.text = [NSString stringWithFormat:@"%@家",string];
    
    UILabel *secondLab = (UILabel *)[self.subviews[0].subviews[3] viewWithTag:31];
    secondLab.text = [NSString stringWithFormat:@"%@家",str];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
