//
//  KHYQuestionListCell.h
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/10.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHYQuestionListModel.h"

@interface KHYQuestionListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UIButton *rebackBtn;
@property (weak, nonatomic) IBOutlet UIView *alertRedView;

@property (nonatomic, strong) KHYQuestionListModel *model;

@end
