//
//  KHYAnnounceCell.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/11.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYAnnounceCell.h"

@implementation KHYAnnounceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.firstBtn.layer.borderColor = COLOR3.CGColor;
    [self.firstBtn setTitle:@"" forState:UIControlStateNormal];
    self.secondBtn.layer.borderColor = COLOR3.CGColor;
    [self.secondBtn setTitle:@"" forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
