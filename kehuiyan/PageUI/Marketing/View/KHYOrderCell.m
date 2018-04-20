//
//  KHYOrderCell.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/12.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYOrderCell.h"

@implementation KHYOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

/**
 设置直销订单管理列表

 @param model 订单列表模型
 */
- (void)setModel:(KHYOrderModel *)model
{
    NSLog(@"===%@===%@",model.status,model.status_name);
    self.timeLab.text = model.add_date;
    self.statusLab.text = model.status_name;
    [self.comboImage sd_setImageWithURL:[NSURL URLWithString:model.package_cover] placeholderImage:nil];
    self.comboNameLab.text = model.package_name;
    self.comboNoteLab.text = model.package_note;
    self.comboPriceLab.text = [NSString stringWithFormat:@"¥ %@",model.total_price];
    self.comboNumLab.text = [NSString stringWithFormat:@"x %@",model.total_num];
    self.comboDetailLab.text = [NSString stringWithFormat:@"共%@件商品 合计：¥%@(含运费￥%@)",model.total_num,model.actual_price,model.yun_fee];
    self.deliverBtn.hidden = YES;
//    if ([model.status isEqualToString:@"2"])
//    {
//        self.deliverBtn.hidden = NO;
//
//    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
