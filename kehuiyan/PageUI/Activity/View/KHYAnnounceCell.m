//
//  KHYAnnounceCell.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/11.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYAnnounceCell.h"

static const NSInteger MAX_STARWORDS_LENGTH = 500;

@implementation KHYAnnounceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textView.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldEditChanged:) name:UITextViewTextDidChangeNotification object:self.textView];
    
    self.firstBtn.layer.borderColor = COLOR3.CGColor;
    [self.firstBtn setTitle:@"" forState:UIControlStateNormal];
    self.secondBtn.layer.borderColor = COLOR3.CGColor;
    [self.secondBtn setTitle:@"" forState:UIControlStateNormal];
}

- (IBAction)firstBtnClick:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(firstBtnClick:)]){
        [self.delegate firstBtnClick:sender];
    }
}

- (IBAction)secondBtnCilck:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(secondBtnClick:)]){
        [self.delegate secondBtnClick:sender];
    }
}
// 文字编辑监听
- (IBAction)editingText:(UITextField *)sender{
    
    if ([self.delegate respondsToSelector:@selector(cellTFEditing:)]){
        [self.delegate cellTFEditing:sender];
    }
}
- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""])
    {
        self.holderLab.hidden = NO;
    }
    else
    {
        self.holderLab.hidden = YES;
    }
    if ([self.delegate respondsToSelector:@selector(textViewDidEditing:)])
    {
        [self.delegate textViewDidEditing:textView];
    }
}

#pragma mark - Notification Method
-(void)textFieldEditChanged:(NSNotification *)obj
{
    UITextView *textView = (UITextView *)obj.object;
    NSString *toBeString = textView.text;
    
    //获取高亮部分
    UITextRange *selectedRange = [textView markedTextRange];
    UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
    
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position)
    {
        if (toBeString.length > MAX_STARWORDS_LENGTH)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_STARWORDS_LENGTH];
            if (rangeIndex.length == 1)
            {
                textView.text = [toBeString substringToIndex:MAX_STARWORDS_LENGTH];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_STARWORDS_LENGTH)];
                textView.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
    NSInteger nowLength = toBeString.length;
    NSInteger left = MAX_STARWORDS_LENGTH - toBeString.length;
    if (nowLength > MAX_STARWORDS_LENGTH)
    {
        nowLength = MAX_STARWORDS_LENGTH;
    }
    if (left < 0)
    {
        left = 0;
    }
    self.totalLab.text = [NSString stringWithFormat:@"%ld/%ld",left,MAX_STARWORDS_LENGTH];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}

@end
