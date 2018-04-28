//
//  KHYChatInfoModel.h
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/23.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  @brief  消息类型
 */
typedef NS_OPTIONS(NSInteger,JXChatCellType)
{
    /**
     *  @brief  文本消息
     */
    JXChatCellType_Text = 1,
    
    /**
     *  @brief  套餐消息
     */
    JXChatCellType_Pacage = 2,
    
};

@interface KHYChatInfoModel : NSObject

@property (nonatomic , copy) NSString              * msg_id;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , copy) NSString              * user_avatar;
@property (nonatomic , copy) NSDictionary          * package_info;
@property (nonatomic , copy) NSString              * user_nickname;
@property (nonatomic , copy) NSString              * date;
@property (nonatomic , copy) NSString              * chat_id;
@property (nonatomic , copy) NSString              * user_id;
@property (nonatomic , copy) NSString              * is_mine;
@property (nonatomic , copy) NSString              * type;
@property (nonatomic , copy) NSString              * content_type;


@property (nonatomic, strong) NSString *height;

/**
 package
 */
@property (nonatomic, strong) NSString *packageID;

@property (nonatomic, strong) NSString *packageText;

@property (nonatomic, strong) NSString *packageImg;

@property (nonatomic, strong) NSString *packgeInfo;

@property (nonatomic, assign) JXChatCellType chatCellType;

@end
