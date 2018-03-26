//
//  KHYHomeLeftCell.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/8.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYHomeLeftCell.h"

@implementation KHYHomeLeftCell

- (void)setLeftMenuTitleArr:(NSArray *)titleArr {
    
    //创建“图标”
    UIImage *image = [UIImage imageNamed:titleArr[0]];
    CGFloat tW = image.size.width;
    CGFloat tH = image.size.height;
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (45-tH)/2, tW, tH)];
    [imgView setImage:image];
    [self.contentView addSubview:imgView];
    
    //创建“标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, SCREEN_WIDTH-70, 25)];
    [lbMsg setText:titleArr[1]];
    [lbMsg setTextColor:[UIColor blackColor]];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT17];
    [self.contentView addSubview:lbMsg];
    
    //创建“右侧尖头”
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60, 17.5, 5.5, 10)];
    [imgView2 setImage:[UIImage imageNamed:@"right_icon_gray"]];
    [self.contentView addSubview:imgView2];
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH-40, 0.5)];
    [lineView setBackgroundColor:LINE_COLOR];
    [self.contentView addSubview:lineView];
    
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
