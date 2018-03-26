//
//  KHYCustomerVisitCell.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/24.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYCustomerVisitCell.h"

@implementation KHYCustomerVisitCell

- (void)setCustomerVisitModel:(KHYCustomerVisitModel *)model indexPath:(NSIndexPath *)indexPath {
    if(!model) return;
    
    self.indexPath = indexPath;
    
    //创建“时间”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH-20, 25)];
    [lbMsg setText:model.visit_date];
    [lbMsg setTextColor:COLOR9];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT15];
    [self.contentView addSubview:lbMsg];
    
    //创建“地址”
    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, SCREEN_WIDTH-20, 20)];
    [lbMsg2 setText:model.address];
    [lbMsg2 setTextColor:COLOR9];
    [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg2 setFont:FONT14];
    [self.contentView addSubview:lbMsg2];
    
    //创建“拜访记录”
    NSString *contentStr = [NSString stringWithFormat:@"拜访记录：%@",model.note];
    UILabel *lbMsg4 = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, SCREEN_WIDTH-20, 40)];
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
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 94.5, SCREEN_WIDTH, 0.5)];
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
