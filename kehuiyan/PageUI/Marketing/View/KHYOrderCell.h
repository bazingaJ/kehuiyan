//
//  KHYOrderCell.h
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/12.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHYOrderModel.h"

@interface KHYOrderCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIView *bottomView;
@property (nonatomic, weak) IBOutlet UIButton *deliverBtn;
@property (nonatomic, strong) KHYOrderModel *model;

@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (weak, nonatomic) IBOutlet UIImageView *comboImage;
@property (weak, nonatomic) IBOutlet UILabel *comboNameLab;
@property (weak, nonatomic) IBOutlet UILabel *comboNoteLab;
@property (weak, nonatomic) IBOutlet UILabel *comboPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *comboNumLab;
@property (weak, nonatomic) IBOutlet UILabel *comboDetailLab;


@end
