//
//  KHYAskRecordCell.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/17.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYAskRecordCell.h"

@implementation KHYAskRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
// cell1
- (void)setModel:(KHYExpertQuestionModel *)model
{
    
    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"default_img_round_list"]];
    self.nameLab.text = model.name;
    self.firstTagLab.hidden = YES;
    self.secondTagLab.hidden = YES;
    if (model.tag_list.count > 0) {
        self.firstTagLab.hidden = NO;
        NSString *midStr = [model.tag_list firstObject];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"   %@   .",midStr]];
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange( 6 + midStr.length,1)];
        self.firstTagLab.attributedText = string;
        if (model.tag_list.count > 1) {
            self.secondTagLab.hidden = NO;
            NSString *midStr = model.tag_list[1];
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"   %@   .",midStr]];
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange( 6 + midStr.length,1)];
            self.secondTagLab.attributedText = string;
        }
    }
    self.detailLab.text = model.intro;
    self.numberLab.text = [NSString stringWithFormat:@"咨询人数：%@人",model.zixun_num];
}

// cell2
- (void)setQuestionModel:(KHYQuestionListModel *)questionModel
{
    
    self.descirpLab.text = questionModel.ask_content;
    self.infoLab.text = [NSString stringWithFormat:@"%@ | %@岁     %@",questionModel.sex,questionModel.age,questionModel.ask_date];
    self.answerLab.text = questionModel.reply_content;
    if ([questionModel.status isEqualToString:@"1"])
    {
        self.answerImg.hidden = YES;
        self.answerLab.hidden = YES;
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
