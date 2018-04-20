//
//  KHYComboCell.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/13.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYComboCell.h"

@implementation KHYComboCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (IBAction)checkBtnClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(checkBtnClick:)])
    {
        [self.delegate checkBtnClick:sender];
    }
}
- (void)setModel:(KHYComboModel *)model
{
    
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.cover_url] placeholderImage:[UIImage imageNamed:@"default_img_round_list"]];
    self.titleLab.text = model.name;
    self.moneyLab.text = [NSString stringWithFormat:@"¥%@",model.total_price];
    NSString *detail = @"";
    for (int i =0; i <model.product_list.count; i++)
    {
        NSDictionary *dict = model.product_list[i];
        NSString *name = [NSString stringWithFormat:@"%@\n",dict[@"name"]];
        detail = [detail stringByAppendingString:name];
        
    }
    self.detail.text = detail;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
