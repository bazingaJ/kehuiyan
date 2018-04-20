//
//  KHYAnnounceCell.h
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/11.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JXAnnounceDelegate <NSObject>

- (void)cellTFEditing:(UITextField *)textFiled;

- (void)firstBtnClick:(UIButton *)button;

- (void)secondBtnClick:(UIButton *)button;

- (void)textViewDidEditing:(UITextView *)textView;

@end

@interface KHYAnnounceCell : UITableViewCell <UITextViewDelegate>
@property (nonatomic, assign) id<JXAnnounceDelegate>delegate;
/**
 cell1
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UITextField *contentTF;

/**
 cell2
 */
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLab1;

/**
 cell3
 */
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *totalLab;
@property (weak, nonatomic) IBOutlet UILabel *holderLab;

/**
 cell4
 */
@property (weak, nonatomic) IBOutlet UIImageView *activityImage;

@end
