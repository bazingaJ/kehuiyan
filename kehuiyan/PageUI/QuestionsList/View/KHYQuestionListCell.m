//
//  KHYQuestionListCell.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/10.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYQuestionListCell.h"

@implementation KHYQuestionListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(KHYQuestionListModel *)model
{
    
    [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"default_img_round_list"]];
    self.userName.text = model.name;
    self.contentLab.text = model.content;
    self.rebackBtn.hidden = [model.isReply isEqualToString:@"1"] ? YES : NO;
    self.alertRedView.hidden = [model.isReply isEqualToString:@"1"] ? YES : NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
