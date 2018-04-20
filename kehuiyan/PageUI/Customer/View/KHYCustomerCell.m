//
//  KHYCustomerCell.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/23.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYCustomerCell.h"

@implementation KHYCustomerCell

- (void)setCustomerModel:(KHYCustomerModel *)model {
    if(!model) return;
    
    //创建“头像”
    NSString *imgURL = model.avatar_src;
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
    [imgView setContentMode:UIViewContentModeScaleAspectFill];
    [imgView.layer setCornerRadius:30];
    [imgView.layer setMasksToBounds:YES];
    [imgView setClipsToBounds:YES];
    [imgView.layer setBorderWidth:0.5];
    [imgView.layer setBorderColor:LINE_COLOR.CGColor];
    [imgView sd_setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:@"default_img_round_list"]];
    [self.contentView addSubview:imgView];
    
    //创建“医生名称、职称”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, SCREEN_WIDTH-90, 20)];
    [lbMsg setText:[NSString stringWithFormat:@"%@  %@",model.realname,model.position_name]];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT16];
    [self.contentView addSubview:lbMsg];
    
    //创建“医院名称”
    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(80, 30, SCREEN_WIDTH-90, 25)];
    [lbMsg2 setText:model.hospital_name];
    [lbMsg2 setTextColor:COLOR9];
    [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg2 setFont:FONT16];
    [self.contentView addSubview:lbMsg2];
    
    //创建“日期”
    UILabel *lbMsg3 = [[UILabel alloc] initWithFrame:CGRectMake(80, 55, SCREEN_WIDTH-90, 25)];
    [lbMsg3 setText:model.visit_time];
    [lbMsg3 setTextColor:COLOR9];
    [lbMsg3 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg3 setFont:FONT14];
    [self.contentView addSubview:lbMsg3];
    
    //创建“拜访记录”
    NSString *contentStr = model.visit_note;
    UILabel *lbMsg4 = [[UILabel alloc] initWithFrame:CGRectMake(80, 80, SCREEN_WIDTH-90, 40)];
    [lbMsg4 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg4 setTextColor:COLOR9];
    [lbMsg4 setFont:FONT12];
    [lbMsg4 setNumberOfLines:2];
    if(!IsStringEmpty(contentStr)) {
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:5.0f];
        [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, contentStr.length)];
        [lbMsg4 setAttributedText:attStr];
    }
    [self.contentView addSubview:lbMsg4];
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 129.5, SCREEN_WIDTH, 0.5)];
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
