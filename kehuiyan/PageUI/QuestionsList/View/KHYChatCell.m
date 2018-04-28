//
//  KHYChatCell.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/23.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYChatCell.h"

static NSString *const other = @"TextCellCell1";

static NSString *const me = @"TextCellCell2";

@interface KHYChatCell()

/**
 *  @brief  头像
 */
@property (nonatomic, strong) UIImageView *headImg;

/**
 @brief  气泡
 */
@property (nonatomic, strong) UIImageView *bubbleImg;

/**
 @brief 聊天内容文字
 */
@property (nonatomic, strong) UILabel *textLab;

@end


@implementation KHYChatCell

+ (instancetype)cellWithTableView:(UITableView*)tableView cellIdentifier:(NSString *)identifier{
    
    KHYChatCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[KHYChatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        // 先设置头像
        self.headImg = [[UIImageView alloc] init];
        self.headImg.userInteractionEnabled = YES;
        self.headImg.layer.masksToBounds = YES;
        self.headImg.layer.cornerRadius = 20;
        self.headImg.image = [UIImage imageNamed:@"default_img_round_list"];
        [self.contentView addSubview:_headImg];
        
        // 他人发送
        if ([reuseIdentifier isEqualToString:other]) {
            [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(25);
                make.width.height.mas_equalTo(40);
                make.left.mas_equalTo(self.contentView).mas_offset(15);
            }];
        }else{
            [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(25);
                make.width.height.mas_equalTo(40);
                make.right.mas_equalTo(self.contentView).mas_offset(-15);
            }];
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headBeenTaped:)];
        [_headImg addGestureRecognizer:tap];
        
        // 在设置聊天气泡
        self.bubbleImg = [[UIImageView alloc] init];
        self.bubbleImg.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.bubbleImg];
        
        self.textLab = [[UILabel alloc] init];
        self.textLab.numberOfLines = 0;
        self.textLab.backgroundColor = [UIColor clearColor];
        self.textLab.font = [UIFont systemFontOfSize:14];
        self.textLab.textColor = COLOR3;
        [self.contentView addSubview:self.textLab];
        
        if ([reuseIdentifier isEqualToString:other])//是他人发送的
        {
            // 先设置文字的约束
            [self.textLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.headImg.mas_right).mas_offset(20);
                make.top.mas_equalTo(self.headImg).mas_offset(10);
            }];
            
            // 再设置气泡的约束
            [self.bubbleImg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.textLab).mas_offset(-10);
                make.right.mas_equalTo(self.textLab.mas_right).mas_offset(20);
                make.bottom.mas_equalTo(self.textLab.mas_bottom).mas_offset(10);
                make.left.mas_equalTo(self.headImg.mas_right);
            }];
            self.bubbleImg.image = [[UIImage imageNamed:@"chat_fromOther"] stretchableImageWithLeftCapWidth:30 topCapHeight:30];
            
        }else//自己发送的消息
        {
            // 先设置文字的约束
            [self.textLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self.headImg.mas_left).mas_offset(-20);
                make.top.mas_equalTo(self.headImg).mas_offset(10);
            }];
            
            // 再设置气泡的约束
            [self.bubbleImg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.textLab).mas_offset(-10);
                make.right.mas_equalTo(self.headImg.mas_left);
                make.bottom.mas_equalTo(self.textLab.mas_bottom).mas_offset(10);
                make.left.mas_equalTo(self.textLab.mas_left).mas_offset(-20);
            }];
            //自己发送的消息
            self.bubbleImg.image = [[UIImage imageNamed:@"chat_fromMe"] stretchableImageWithLeftCapWidth:30 topCapHeight:30];
        }
        
        
    }
    return self;
}

- (void)setModel:(KHYChatInfoModel *)model
{
    
    self.textLab.text= model.content;
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:model.user_avatar] placeholderImage:[UIImage imageNamed:@"default_img_round_list"]];
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGSize contentSize = [model.content boundingRectWithSize:CGSizeMake(screenW*0.6, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14], NSFontAttributeName, nil] context:nil].size;
    if ([model.is_mine isEqualToString:@"1"]) {
        self.textLab.textColor = [UIColor whiteColor];
        [self.textLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(contentSize.width + 10);
        }];
    }else{
        self.textLab.textColor = COLOR3;
        [self.textLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(contentSize.width + 10);
        }];
    }
    
}


-(CGFloat)getH1{
    
    [self.contentView layoutIfNeeded];
    
    return  CGRectGetMaxY(self.bubbleImg.frame)+10;
}

- (void)headBeenTaped:(UITapGestureRecognizer *)tap
{
    
    
}

@end
