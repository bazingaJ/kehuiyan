//
//  KHYPackgeCell.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/23.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYPackgeCell.h"

static NSString *const identifier = @"KHYPackgeCell1";

@interface KHYPackgeCell()

/**
 *  @brief  头像
 */
@property (nonatomic, strong) UIImageView *headImg;

/**
 @brief  气泡
 */
@property (nonatomic, strong) UIImageView *bubbleImg;

/**
 @brief 套餐标题
 */
@property (nonatomic, strong) UILabel *titleLab;

/**
 @brief 套餐详情
 */
@property (nonatomic, strong) UILabel *detailLab;

/**
 套餐图片
 */
@property (nonatomic, strong) UIImageView *packgeImg;

@end

@implementation KHYPackgeCell

+ (instancetype)cellWithTableView:(UITableView*)tableView{
    
    KHYPackgeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[KHYPackgeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        
        [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(25);
            make.width.height.mas_equalTo(40);
            make.right.mas_equalTo(self.contentView).mas_offset(-15);
        }];
        
        // 在设置聊天气泡
        self.bubbleImg = [[UIImageView alloc] init];
        self.bubbleImg.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.bubbleImg];
        
        self.titleLab = [[UILabel alloc] init];
        self.titleLab.numberOfLines = 2;
        self.titleLab.backgroundColor = [UIColor clearColor];
        self.titleLab.font = [UIFont systemFontOfSize:15];
        self.titleLab.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.titleLab];
        // 先设置文字的约束
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.headImg.mas_left).mas_offset(-20);
            make.top.mas_equalTo(self.headImg.mas_top).mas_offset(10);
            make.width.mas_equalTo(130);
        }];
        
        self.detailLab = [[UILabel alloc] init];
        self.detailLab.numberOfLines = 3;
        self.detailLab.backgroundColor = [UIColor clearColor];
        self.detailLab.font = [UIFont systemFontOfSize:11];
        self.detailLab.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.detailLab];
        // 先设置文字的约束
        [self.detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.mas_equalTo(self.titleLab);
            make.top.mas_equalTo(self.titleLab.mas_bottom).mas_offset(10);
        }];
        
        self.packgeImg = [[UIImageView alloc] init];
        self.packgeImg.backgroundColor = [UIColor clearColor];
        self.packgeImg.layer.masksToBounds = YES;
        self.packgeImg.layer.cornerRadius = 5;
        [self.contentView addSubview:self.packgeImg];
        
        [self.packgeImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(90);
            make.top.mas_equalTo(self.titleLab.mas_top);
            make.right.mas_equalTo(self.titleLab.mas_left).mas_offset(-15);
        }];
        
        
        // 再设置气泡的约束
        [self.bubbleImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLab.mas_top).mas_offset(-10);
            make.right.mas_equalTo(self.headImg.mas_left);
            make.bottom.mas_equalTo(self.packgeImg.mas_bottom).mas_offset(10);
            make.left.mas_equalTo(self.packgeImg.mas_left).mas_offset(-20);
        }];
        //自己发送的消息
        self.bubbleImg.image = [[UIImage imageNamed:@"chat_fromMe"] stretchableImageWithLeftCapWidth:30 topCapHeight:30];
    
        
        
    }
    return self;
}

- (void)setModel:(KHYChatInfoModel *)model
{
    
    if (model.packageText) {
        // 本地缓存数据
        [self.headImg sd_setImageWithURL:[NSURL URLWithString:model.user_avatar] placeholderImage:[UIImage imageNamed:@"default_img_round_list"]];
        self.titleLab.text = model.packageText;
        self.detailLab.text = model.packgeInfo;
        [self.packgeImg sd_setImageWithURL:[NSURL URLWithString:model.packageImg] placeholderImage:nil];
    }else{
        
        // 接口获取数据
        [self.headImg sd_setImageWithURL:[NSURL URLWithString:model.user_avatar] placeholderImage:[UIImage imageNamed:@"default_img_round_list"]];
        NSDictionary *dataDic = model.package_info;
        self.titleLab.text = dataDic[@"name"];
        NSArray *arr = dataDic[@"product_list"];
        NSString *detail = @"";
        if (arr.count > 0) {
            for (int i =0; i <arr.count; i++)
            {
                NSDictionary *dict = arr[i];
                NSString *name = [NSString stringWithFormat:@"%@,",dict[@"name"]];
                detail = [detail stringByAppendingString:name];
                detail = [detail substringToIndex:detail.length - 1];
            }
        }
        
        self.detailLab.text = detail;
        [self.packgeImg sd_setImageWithURL:[NSURL URLWithString:dataDic[@"cover_url"]] placeholderImage:nil];
    }
    
}


@end
