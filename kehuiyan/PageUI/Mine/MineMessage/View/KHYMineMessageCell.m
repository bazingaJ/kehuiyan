//
//  KHYMineMessageCell.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/24.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYMineMessageCell.h"

@implementation KHYMineMessageCell

- (void)setMessageModel:(KHYMessageModel *)model indexPath:(NSIndexPath *)indexPath {
    if(!model) return;
    
    self.indexPath = indexPath;
    
    //创建“标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 25)];
    [lbMsg setText:model.title];
    if([model.is_read isEqualToString:@"1"]) {
        //已读
        [lbMsg setTextColor:COLOR9];
    }else{
        //未读
        [lbMsg setTextColor:[UIColor blackColor]];
    }
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT16];
    [self.contentView addSubview:lbMsg];
    
    //创建“消息内容”
    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, SCREEN_WIDTH-20, 40)];
    [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
    if([model.is_read isEqualToString:@"1"]) {
        //已读
        [lbMsg2 setTextColor:COLOR9];
    }else{
        //未读
        [lbMsg2 setTextColor:COLOR3];
    }
    [lbMsg2 setFont:FONT14];
    [lbMsg2 setNumberOfLines:2];
    NSString *content = model.content;
    if(!IsStringEmpty(content)) {
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:content];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:5.0f];
        [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, content.length)];
        [lbMsg2 setAttributedText:attStr];
    }
    [self.contentView addSubview:lbMsg2];
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 90, SCREEN_WIDTH-10, 0.5)];
    [lineView setBackgroundColor:LINE_COLOR];
    [self.contentView addSubview:lineView];
    
    //创建”发送日期“
    UILabel *lbMsg3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, SCREEN_WIDTH-90, 20)];
    [lbMsg3 setText:model.date];
    [lbMsg3 setTextColor:COLOR9];
    [lbMsg3 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg3 setFont:FONT12];
    [self.contentView addSubview:lbMsg3];
    
    //创建“查看详情”
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-80, 100, 70, 20)];
    [btnFunc setTitle:@"查看详情" forState:UIControlStateNormal];
    if([model.is_read isEqualToString:@"1"]) {
        //已读
        [btnFunc setTitleColor:COLOR9 forState:UIControlStateNormal];
    }else{
        //未读
        [btnFunc setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    }
    [btnFunc.titleLabel setFont:FONT15];
    [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [btnFunc addTouch:^{
        if([self.delegate respondsToSelector:@selector(KHYMineMessageCellClick:indexPath:)]) {
            [self.delegate KHYMineMessageCellClick:model indexPath:indexPath];
        }
    }];
    [self.contentView addSubview:btnFunc];
    
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
