//
//  KHYAskRecordCell.h
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/17.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHYExpertQuestionModel.h"
#import "KHYQuestionListModel.h"

@interface KHYAskRecordCell : UITableViewCell

/**
 cell1
 */
@property (weak, nonatomic) IBOutlet UIImageView *avatarImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *firstTagLab;
@property (weak, nonatomic) IBOutlet UILabel *secondTagLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UILabel *numberLab;

@property (nonatomic, strong) KHYExpertQuestionModel *model;

/**
 cell2
 */
@property (weak, nonatomic) IBOutlet UILabel *descirpLab;
@property (weak, nonatomic) IBOutlet UILabel *infoLab;
@property (weak, nonatomic) IBOutlet UILabel *answerLab;
@property (weak, nonatomic) IBOutlet UIImageView *answerImg;

@property (nonatomic, strong) KHYQuestionListModel *questionModel;

@end
