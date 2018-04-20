//
//  KHYChatModel.h
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/18.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KHYChatModel : NSObject

@property (nonatomic , copy) NSString              * date;
@property (nonatomic , copy) NSString              * chat_id;
@property (nonatomic , copy) NSString              * user_id;
@property (nonatomic , copy) NSString              * user_nickname;
@property (nonatomic , copy) NSString              * user_avatar;
@property (nonatomic , copy) NSString              * content;

@end
