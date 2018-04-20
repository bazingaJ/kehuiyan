//
//  KHYCustomerVisitCell.h
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/24.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHYCustomerVisitModel.h"
#import "SWTableViewCell.h"

@interface KHYCustomerVisitCell : SWTableViewCell

- (void)setCustomerVisitModel:(KHYCustomerVisitModel *)model indexPath:(NSIndexPath *)indexPath;
@property (nonatomic, assign) NSIndexPath *indexPath;

@end
