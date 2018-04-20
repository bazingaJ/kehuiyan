//
//  KHYActivityListCell.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/10.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYActivityListCell.h"

@implementation KHYActivityListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

// cell1赋值操作
- (void)setModel:(KHYActivityModel *)model
{
    
    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:model.cover_url] placeholderImage:nil];
    self.titleLab.text = model.title;
    self.timeLab.text = model.add_date;
    self.partInPersonLab.text = [NSString stringWithFormat:@"参与人数：%@/%@",model.sign_num,model.limit_num];
}
//cell2
- (void)setPartInModel:(KHYPartInModel *)partInModel
{
    
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:partInModel.avatar] placeholderImage:nil];
    self.nameLab.text = partInModel.realname;
    self.statusLab.text = partInModel.is_sign_name;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

- (IBAction)lookBtn:(UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(lookUpBtnClick:)])
    {
        [self.delegate lookUpBtnClick:sender];
    }
    
}



@end
