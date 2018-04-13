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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
