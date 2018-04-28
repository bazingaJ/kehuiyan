//
//  KHYOrderDetailCell.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/12.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYOrderDetailCell.h"
/**
 
 product_list Array
 
 @property (nonatomic , copy) NSString              * code;
 @property (nonatomic , copy) NSString              * product_id;
 @property (nonatomic , copy) NSString              * total_num;
 @property (nonatomic , copy) NSString              * cover_url;
 @property (nonatomic , copy) NSString              * name;
 @property (nonatomic , copy) NSString              * price;
 
 */
@implementation KHYOrderDetailCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
}

- (void)setProductArr:(NSArray *)productArr
{
    
    self.titleLab1.hidden = YES;
    self.code.hidden = YES;
    self.single_price.hidden = YES;
    self.numberLab.hidden = YES;
    
    self.titleLab2.hidden = YES;
    self.codeLab2.hidden = YES;
    self.single_priceLab2.hidden = YES;
    self.numberLab2.hidden = YES;
    
    self.titleLab3.hidden = YES;
    self.codeLab3.hidden = YES;
    self.single_priceLab3.hidden = YES;
    self.numberLab3.hidden = YES;
    
    if (productArr.count > 0) {
        NSDictionary *dic = [productArr firstObject];
        self.titleLab1.hidden = NO;
        self.code.hidden = NO;
        self.single_price.hidden = NO;
        self.numberLab.hidden = NO;
        
        self.titleLab1.text = [NSString getRightStringByCurrentString:dic[@"name"]];
        self.code.text = [NSString getRightStringByCurrentString:dic[@"code"]];
        self.single_price.text = [NSString getRightStringByCurrentString:dic[@"price"]];
        self.numberLab.text = [NSString getRightStringByCurrentString:dic[@"total_num"]];
        
    }
    if (productArr.count > 1) {
        NSDictionary *dic = productArr [1];
        self.titleLab2.hidden = NO;
        self.codeLab2.hidden = NO;
        self.single_priceLab2.hidden = NO;
        self.numberLab2.hidden = NO;
        
        self.titleLab2.text = [NSString getRightStringByCurrentString:dic[@"name"]];
        self.codeLab2.text = [NSString getRightStringByCurrentString:dic[@"code"]];
        self.single_priceLab2.text = [NSString getRightStringByCurrentString:dic[@"price"]];
        self.numberLab2.text = [NSString getRightStringByCurrentString:dic[@"total_num"]];
    }
    if (productArr.count > 2) {
        NSDictionary *dic = productArr [2];
        self.titleLab3.hidden = NO;
        self.codeLab3.hidden = NO;
        self.single_priceLab3.hidden = NO;
        self.numberLab3.hidden = NO;
        
        self.titleLab3.text = [NSString getRightStringByCurrentString:dic[@"name"]];
        self.codeLab3.text = [NSString getRightStringByCurrentString:dic[@"code"]];
        self.single_priceLab3.text = [NSString getRightStringByCurrentString:dic[@"price"]];
        self.numberLab3.text = [NSString getRightStringByCurrentString:dic[@"total_num"]];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

    
}

@end
