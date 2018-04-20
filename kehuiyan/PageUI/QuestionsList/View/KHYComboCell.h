//
//  KHYComboCell.h
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/13.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHYComboModel.h"

@protocol JXComboCellDelegate <NSObject>

- (void)checkBtnClick:(UIButton *)btn;

@end

@interface KHYComboCell : UITableViewCell

@property (nonatomic, assign) id <JXComboCellDelegate>delegate;
@property (nonatomic, strong) KHYComboModel *model;
/**
 cell1
 */
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;

@end
