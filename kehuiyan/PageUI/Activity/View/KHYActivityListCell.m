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
