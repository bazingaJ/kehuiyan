//
//  KHYSubjectCell.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/3/15.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYSubjectCell.h"

@implementation KHYSubjectCell

- (void)setSubjectModel:(KHYSubjectModel *)model
{
    if(!model) return;
    
    //创建“科室名称”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 25)];
    [lbMsg setText:model.subject_name];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT16];
    [self.contentView addSubview:lbMsg];
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5)];
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
