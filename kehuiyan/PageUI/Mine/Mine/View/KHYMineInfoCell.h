//
//  KHYMineInfoCell.h
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/3/12.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YJXSexButtonDelegate <NSObject>

- (void)manButtonClick;
- (void)womanButtonClick;
- (void)textAfterEditingWithString:(NSString *)string textFiled:(UITextField *)textFiled;


@end


@interface KHYMineInfoCell : UITableViewCell

@property (nonatomic, assign) id<YJXSexButtonDelegate>delegate;

/**
 infoCell1
 */
@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;

/**
 infoCell2
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UITextField *infoTF;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelTrailWidth;


/**
 infoCell3
 */
@property (weak, nonatomic) IBOutlet UIImageView *manSelectedImgView;
@property (weak, nonatomic) IBOutlet UIImageView *womanSelectedImgView;


@end
