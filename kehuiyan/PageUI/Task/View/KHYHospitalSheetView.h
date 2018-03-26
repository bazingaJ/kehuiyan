//
//  KHYHospitalSheetView.h
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/3/16.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KHYHospitalSheetView : UIView <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@property (strong, nonatomic) UIView *backView;
@property (assign, nonatomic) CGFloat yPosition;
@property (assign, nonatomic) NSInteger index;

- (instancetype)initWithFrame:(CGRect)frame withDataArr:(NSMutableArray *)dataArr;

- (void)show;
- (void)dismiss;
- (void)showAlert;

/**
 *  回调函数
 */
@property (nonatomic, copy) void(^hospitalLevelCallBack)(NSString *levelID,NSString *levelStr);

@end
