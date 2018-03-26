//
//  KHYMineMessageCell.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/24.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHYMessageModel.h"
#import "SWTableViewCell.h"

@protocol KHYMineMessageCellDelegate <NSObject>

- (void)KHYMineMessageCellClick:(KHYMessageModel *)model indexPath:(NSIndexPath *)indexPath;

@end

@interface KHYMineMessageCell : SWTableViewCell

@property (assign) id<KHYMineMessageCellDelegate> delegate;
- (void)setMessageModel:(KHYMessageModel *)model indexPath:(NSIndexPath *)indexPath;
@property (nonatomic, assign) NSIndexPath *indexPath;

@end
