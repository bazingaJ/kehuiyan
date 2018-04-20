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
    
}

- (void)setModel:(KHYQuestionListModel *)model
{
    
    [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:model.avatar_url] placeholderImage:[UIImage imageNamed:@"default_img_round_list"]];
    self.userName.text = model.realname;
    self.contentLab.text = model.reply_content;
    self.rebackBtn.hidden = [model.status isEqualToString:@"2"]||[model.status isEqualToString:@"3"] ? YES : NO;
    self.alertRedView.hidden = [model.status isEqualToString:@"2"]||[model.status isEqualToString:@"3"] ? YES : NO;
    
}

- (void)setChatModel:(KHYChatModel *)chatModel
{
    
    [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:chatModel.user_avatar] placeholderImage:[UIImage imageNamed:@"default_img_round_list"]];
    self.userName.text = chatModel.user_nickname;
    self.contentLab.text = chatModel.content;
    [self.rebackBtn setTitle:@"回复咨询" forState:UIControlStateNormal];;
    self.alertRedView.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
