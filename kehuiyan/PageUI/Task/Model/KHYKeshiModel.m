//
//  KHYKeshiModel.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/23.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYKeshiModel.h"

@implementation KHYKeshiModel

/**
 *  二级科室列表
 */
- (void)setChild_list:(NSMutableArray *)child_list
{
    _child_list = [KHYKeshiModel mj_objectArrayWithKeyValuesArray:child_list];
}

@end
