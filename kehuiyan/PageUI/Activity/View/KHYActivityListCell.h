//
//  KHYActivityListCell.h
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/10.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JXActivityCellDelegate <NSObject>

/**
 查看按钮点击

 @param button 按钮本身
 */
- (void)lookUpBtnClick:(UIButton *)button;

@end

@interface KHYActivityListCell : UITableViewCell

@property (nonatomic, assign) id<JXActivityCellDelegate>delegate;
/**
 cell1
 */
@property (weak, nonatomic) IBOutlet UIImageView *avatarImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *partInPersonLab;
- (IBAction)lookBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;

@end
