//
//  KHYMineInfoCell.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/3/12.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYMineInfoCell.h"

@interface KHYMineInfoCell ()<UITextFieldDelegate>



@end

@implementation KHYMineInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(manClick)];
    
    [self.manSelectedImgView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(womanClick)];
    [self.womanSelectedImgView addGestureRecognizer:tap1];
    
}
- (void)manClick
{
    self.manSelectedImgView.image = [UIImage imageNamed:@"sex_ selected"];
    self.womanSelectedImgView.image = [UIImage imageNamed:@"sex_ unselected"];
    if ([self.delegate respondsToSelector:@selector(manButtonClick)])
    {
        [self.delegate manButtonClick];
    }
}

- (void)womanClick
{
    self.manSelectedImgView.image = [UIImage imageNamed:@"sex_ unselected"];
    self.womanSelectedImgView.image = [UIImage imageNamed:@"sex_ selected"];
    if ([self.delegate respondsToSelector:@selector(womanButtonClick)])
    {
        [self.delegate womanButtonClick];
    }
}
- (IBAction)aaaa:(UITextField *)sender {
    
    if ([self.delegate respondsToSelector:@selector(textAfterEditingWithString:textFiled:)])
    {
        [self.delegate textAfterEditingWithString:sender.text textFiled:sender];
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
