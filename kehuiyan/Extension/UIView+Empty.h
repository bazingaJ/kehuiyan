//
//  UIView+Empty.h
//  wulian_user
//
//  Created by 相约在冬季 on 2017/6/1.
//  Copyright © 2017年 wlqq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^emptyViewClickBlock)(NSInteger tIndex);

/**
 *  空白视图类型枚举
 */
typedef NS_ENUM(NSInteger, EmptyViewType)
{
    //页面加载失败
    EmptyViewTypeLoadFail=0,
    //
    EmptyViewTypeWait = 1,
};

@interface EmptyWarnView : UIView

/**
 *  提示图
 */
@property (nonatomic, strong) UIImageView *imgView;
/**
 *  提示标题
 */
@property (nonatomic, strong) UILabel *lblTitle;
/**
 *  提示副标题
 */
@property (nonatomic, strong) UILabel *lblSubTitle;
/**
 *  按钮(1登录、2重新加载)
 */
@property (nonatomic, strong) UIButton *btnFunc;
/**
 *  回调函数
 */
@property (nonatomic, copy) emptyViewClickBlock clickBlock;
/**
 *  初始化视图
 */
+ (EmptyWarnView *)initWithFrame:(CGRect)frame andType:(EmptyViewType)type;

@end

@interface UIView (Empty)

/**
 *  空页面视图
 */
@property (strong, nonatomic) EmptyWarnView *warningView;

/**
 *  空页面视图呈现
 *
 *  @param emptyViewType 页面的展示的数据类别（例如：我的消息、团队）
 *  @param isEmpty 是否有数据
 *  @param clickBlock 登录、重新加载回调函数
 */
- (void)emptyViewShowWithDataType:(EmptyViewType)emptyViewType
                          isEmpty:(BOOL)isEmpty
              emptyViewClickBlock:(emptyViewClickBlock)clickBlock;

@end
