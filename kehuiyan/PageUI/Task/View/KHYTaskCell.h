//
//  KHYTaskCell.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/10.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHYTaskModel.h"
#import "SWTableViewCell.h"

@interface KHYTaskCell : SWTableViewCell

- (void)setTaskModel:(KHYTaskModel *)model;
@end
