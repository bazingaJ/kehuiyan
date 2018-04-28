//
//  WSChatMessageInputBar.m
//  QQ
//
//  Created by weida on 15/9/23.
//  Copyright (c) 2015年 weida. All rights reserved.
//  https://github.com/weida-studio/QQ

#import "WSChatMessageInputBar.h"
#import "PureLayout.h"

//背景颜色
#define kBkColor               ([UIColor colorWithRed:0.922 green:0.925 blue:0.929 alpha:1])

//输入框最小高度
#define kMinHeightTextView          (34)

//输入框最大高度
#define kMaxHeightTextView   (84)

//默认输入框和父控件底部间隔
#define kDefaultBottomTextView_SupView  (5)

#define kDefaultTopTextView_SupView  (5)

//按钮大小
#define kSizeBtn                 (CGSizeMake(34, 34))

@interface WSChatMessageInputBar ()<UITextViewDelegate>
{
    /**
     *  @brief  TextView和自己底部约束，会被动态增加、删除
     */
    NSLayoutConstraint *mBottomConstraintTextView;
    
    
    /**
     *  @brief  自己和父控件 底部约束，使用这个约束让自己伴随键盘移动
     */
    NSLayoutConstraint *mBottomConstraintWithSupView;
    
    /**
     *  @brief  TextView的高度
     */
    CGFloat mHeightTextView;
    
}


/**
 *  @brief  输入TextView
 */
@property(nonatomic,strong)UITextView *mInputTextView;


/**
 *  @brief  更多按钮
 */
@property(nonatomic,strong)UIButton   *mMoreBtn;

@end

@implementation WSChatMessageInputBar

#pragma mark - Override System Method

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = kBkColor;
        mHeightTextView = kMinHeightTextView; //默认设置输入框最小高度
        
        /**
         *  @brief  增加更多按钮
         */
        [self addSubview:self.mMoreBtn];
        [self.mMoreBtn autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:5];
        [self.mMoreBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
        
        /**
         *  @brief  增加输入框
         */
        [self addSubview:self.mInputTextView];
        [self.mInputTextView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kDefaultTopTextView_SupView];
        [self.mInputTextView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5];
        [self.mInputTextView autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.mMoreBtn withOffset:-5];
        mBottomConstraintTextView = [self.mInputTextView  autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:kDefaultBottomTextView_SupView];
        
        /**
         *  @brief  监听键盘显示、隐藏变化，让自己伴随键盘移动
         */
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillHideNotification object:nil];
        
    }
    return self;
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


//获取自己和父控件底部约束，控制该约束可以让自己伴随键盘移动
-(void)updateConstraints
{
    [super updateConstraints];

    
    if (!mBottomConstraintWithSupView)
    {
         NSArray *constraints = self.superview.constraints;
        
        for (int index= (int)constraints.count-1; index>0; index--)
        {//从末尾开始查找
            NSLayoutConstraint *constraint = constraints[index];
            
            if (constraint.firstItem == self && constraint.firstAttribute == NSLayoutAttributeBottom && constraint.secondAttribute == NSLayoutAttributeBottom)
            {//获取自己和父控件底部约束
                mBottomConstraintWithSupView = constraint;
                
                break;
            }
        }
    }
    
}

/**
 *  @brief  返回自己的固有内容尺寸，刷新固有内容尺寸系统将会重新调用此方法
 *
 *  @return 宽度不设置固有内容尺寸，只设置高度
 */
-(CGSize)intrinsicContentSize
{
    CGFloat height = mHeightTextView+kDefaultBottomTextView_SupView +kDefaultTopTextView_SupView;
    
//    height += [mMoreView intrinsicContentSize].height; //如果更多视图当前正在显示，需要加上更多视图的高度
//
//    height += [mFaceView intrinsicContentSize].height; //如果表情视图当前正在显示，需要加上他的的高度
    
    return CGSizeMake(UIViewNoIntrinsicMetric, height);
}

#pragma mark - 伴随键盘移动

-(void)keyboardChange:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    
    
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardEndFrame;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    
    if (notification.name == UIKeyboardWillShowNotification)
    {
        mBottomConstraintWithSupView.constant = -(keyboardEndFrame.size.height);
    }else
    {
        mBottomConstraintWithSupView.constant = 0;
    }
    
    [self.superview layoutIfNeeded];
    
    
    [UIView commitAnimations];
}

#pragma mark - 点击事件处理


-(void)moreBtnClick:(UIButton*)sender
{
    
    if ([self.delegate respondsToSelector:@selector(choicePackge)]) {
        [self.delegate choicePackge];
    }
    
}


#pragma mark - Getter Method

-(UIButton *)mMoreBtn
{
    if (_mMoreBtn) {
        return _mMoreBtn;
    }
    
    _mMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _mMoreBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [_mMoreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _mMoreBtn.backgroundColor = [UIColor clearColor];
    
    [_mMoreBtn setImage:[UIImage imageNamed:@"chat_bottom_up_nor"] forState:UIControlStateNormal];
    [_mMoreBtn autoSetDimensionsToSize:kSizeBtn];
    
    
    return _mMoreBtn;
}


-(UITextView *)mInputTextView
{
    if (_mInputTextView) {
        return _mInputTextView;
    }
    
    _mInputTextView = [[UITextView alloc]initForAutoLayout];

    _mInputTextView.delegate = self;
    _mInputTextView.layer.cornerRadius = 4;
    _mInputTextView.layer.masksToBounds = YES;
    _mInputTextView.layer.borderWidth = 1;
    _mInputTextView.layer.borderColor = [[[UIColor lightGrayColor] colorWithAlphaComponent:0.4] CGColor];
    _mInputTextView.scrollIndicatorInsets = UIEdgeInsetsMake(10.0f, 0.0f, 10.0f, 4.0f);
    _mInputTextView.contentInset = UIEdgeInsetsZero;
    _mInputTextView.scrollEnabled = NO;
    _mInputTextView.scrollsToTop = NO;
    _mInputTextView.userInteractionEnabled = YES;
    _mInputTextView.font = [UIFont systemFontOfSize:14];
    _mInputTextView.textColor = [UIColor blackColor];
    _mInputTextView.backgroundColor = [UIColor whiteColor];
    _mInputTextView.keyboardAppearance = UIKeyboardAppearanceDefault;
    _mInputTextView.keyboardType = UIKeyboardTypeDefault;
    _mInputTextView.returnKeyType = UIReturnKeySend;
    _mInputTextView.textAlignment = NSTextAlignmentLeft;
    
    return _mInputTextView;
}

#pragma mark -TextView Delegate

//输入框获取输入焦点后，隐藏其他视图
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    
}

//判断用户是否点击了键盘发送按钮
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {//点击了发送按钮
       
        if (![textView.text isEqualToString:@""])
        {//输入框当前有数据才需要发送
            KHYChatInfoModel *model = [KHYChatInfoModel new];
            model.chatCellType = JXChatCellType_Text;
            model.content = textView.text;
            model.is_mine = @"1";
            model.content_type = @"1";
            if ([self.delegate respondsToSelector:@selector(getMsgWith:)]) {
                [self.delegate getMsgWith:model];
            }
            
            textView.text = @"";//清空输入框
            [self textViewDidChange:textView];
        }
        return NO;
    }
    
    return YES;
}

//根据输入文字多少，自动调整输入框的高度
-(void)textViewDidChange:(UITextView *)textView
{
    //计算输入框最小高度
    CGSize size =  [textView sizeThatFits:CGSizeMake(textView.contentSize.width, 0)];
    
    CGFloat contentHeight;

    //输入框的高度不能超过最大高度
    if (size.height > kMaxHeightTextView)
    {
        contentHeight = kMaxHeightTextView;
        textView.scrollEnabled = YES;
    }else
    {
        contentHeight = size.height;
        textView.scrollEnabled = NO;
    }
    
    
    if (mHeightTextView != contentHeight)
    {//如果当前高度需要调整，就调整，避免多做无用功
        mHeightTextView = contentHeight ;//重新设置自己的高度
        [self invalidateIntrinsicContentSize];
    }
}


@end
