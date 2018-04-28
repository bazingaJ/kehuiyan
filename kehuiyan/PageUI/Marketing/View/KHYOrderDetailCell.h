//
//  KHYOrderDetailCell.h
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/12.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KHYOrderDetailCell : UITableViewCell

@property (nonatomic, strong) NSArray *productArr;

// No.1
@property (nonatomic, weak) IBOutlet UILabel *titleLab1;
@property (weak, nonatomic) IBOutlet UILabel *code;
@property (weak, nonatomic) IBOutlet UILabel *single_price;
@property (weak, nonatomic) IBOutlet UILabel *numberLab;

// No.2
@property (weak, nonatomic) IBOutlet UILabel *titleLab2;
@property (weak, nonatomic) IBOutlet UILabel *codeLab2;
@property (weak, nonatomic) IBOutlet UILabel *single_priceLab2;
@property (weak, nonatomic) IBOutlet UILabel *numberLab2;

// No.3
@property (weak, nonatomic) IBOutlet UILabel *titleLab3;
@property (weak, nonatomic) IBOutlet UILabel *codeLab3;
@property (weak, nonatomic) IBOutlet UILabel *single_priceLab3;
@property (weak, nonatomic) IBOutlet UILabel *numberLab3;



@end
