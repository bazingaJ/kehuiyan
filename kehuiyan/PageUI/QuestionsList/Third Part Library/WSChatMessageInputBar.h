//
//  WSChatMessageInputBar.h
//  QQ
//
//  Created by weida on 15/9/23.
//  Copyright (c) 2015年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import <UIKit/UIKit.h>
#import "KHYChatInfoModel.h"

@protocol JXChatInputBarDelegate <NSObject>

- (void)getMsgWith:(KHYChatInfoModel *)model;

- (void)choicePackge;

@end

/**
 *  @brief  聊天界面底部输入界面
 */
@interface WSChatMessageInputBar : UIView

@property (nonatomic, assign) id<JXChatInputBarDelegate>delegate;

@end
