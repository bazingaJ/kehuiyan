//
//  KHYCustomerModel.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/23.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYCustomerModel.h"

@implementation KHYCustomerModel

/**
 *  简介高度
 */
- (CGFloat)cellH {
    CGFloat textH = 0;
    if(!IsStringEmpty(self.intro)) {
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
        [style setLineSpacing:5.0];
        NSDictionary *attribute = @{NSFontAttributeName:FONT14,NSParagraphStyleAttributeName:style};
        CGSize retSize = [self.intro boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT)
                                                       options:\
                          NSStringDrawingTruncatesLastVisibleLine |
                          NSStringDrawingUsesLineFragmentOrigin |
                          NSStringDrawingUsesFontLeading
                                                    attributes:attribute
                                                       context:nil].size;
        textH = retSize.height+20;
    }
    return textH > 40 ? textH : 40;
}

/**
 *  备注高度
 */
- (CGFloat)cellH2 {
    CGFloat textH = 0;
    if(!IsStringEmpty(self.note)) {
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
        [style setLineSpacing:5.0];
        NSDictionary *attribute = @{NSFontAttributeName:FONT14,NSParagraphStyleAttributeName:style};
        CGSize retSize = [self.note boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT)
                                                  options:\
                          NSStringDrawingTruncatesLastVisibleLine |
                          NSStringDrawingUsesLineFragmentOrigin |
                          NSStringDrawingUsesFontLeading
                                               attributes:attribute
                                                  context:nil].size;
        textH = retSize.height+20;
    }
    return textH > 40 ? textH : 40;
}

@end
