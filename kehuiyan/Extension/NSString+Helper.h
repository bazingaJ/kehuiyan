//
//  NSString+Helper.h
//  AIYISHU
//
//  Created by Mr.Psychosis on 14/9/23.
//  Copyright (c) 2014年 Frank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Helper)

/**
 *  判断是否为正确的邮箱
 *
 *  @return 返回YES为正确的邮箱，NO为不是邮箱
 */
- (BOOL)isValidateEmail;

/**
 *  判断是否为正确的手机号
 *
 *  @return 返回YES为手机号，NO为不是手机号
 */
- (BOOL)checkTel;

/**
 *  清空字符串中的空白字符
 *
 *  @return 清空空白字符串之后的字符串
 */
- (NSString *)trimString;

/**
 *  是否空字符串
 *
 *  @return 如果字符串为nil或者长度为0返回YES
 */
- (BOOL)isEmptyString;

/**
 *  返回沙盒中的文件路径
 *
 *  @return 返回当前字符串对应在沙盒中的完整文件路径
 */
+ (NSString *)stringWithDocumentsPath:(NSString *)path;

/**
 *  写入系统偏好
 *
 *  @param key 写入键值
 */
- (void)saveToNSDefaultsWithKey:(NSString *)key;

//自定义字体字符高度
+ (CGFloat)heightCustomAdjustWidth:(CGFloat)width font:(UIFont *)font forString:(NSString *)string paragraphStyle:(NSMutableParagraphStyle*)paragraphStyle;
+ (CGFloat)widthCustomAdjustheight:(CGFloat)height font:(UIFont *)font forString:(NSString *)string paragraphStyle:(NSMutableParagraphStyle*)paragraphStyle;
//系统字体高度计算
+ (CGFloat)widthAdjustheight:(CGFloat)height font:(UIFont *)font forString:(NSString *)string;
+ (CGFloat)heightAdjustWidth:(CGFloat)width font:(UIFont *)font forString:(NSString *)string;
/**
 *  一串字符在固定宽度下，正常显示所需要的高度
 *
 *  @param string：文本内容
 *  @param width：每一行的宽度
 *  @param 字体大小
 */
+ (CGFloat)autoHeightWithString:(NSString *)string
                        Width:(CGFloat)width
                         Font:(UIFont *)font;

/**
 *  一串字符在一行中正常显示所需要的宽度
 *
 *  @param string：文本内容
 *  @param 字体大小
 */
+ (CGFloat)autoWidthWithString:(NSString *)string
                         Font:(UIFont *)font;
//下划线文字
+ (NSAttributedString *)makeDeleteLine:(NSString *)string;

//返回带换行符的字符串
+ (NSString *)StringHaveNextLine:(NSArray *)array;

//日期格式转换
+ (NSString *)dateStringWithDate:(NSDate *)date DateFormat:(NSString *)dateFormat;

//去除特殊字符及空格
+ (NSString *)stringByTrimmingCharactersInSetEx:(NSString *)str;

//去除Html标签
+ (NSString *)stringByReplacingHTMLRegex:(NSString *)htmlStr;

//验证密码是否是6～11位的字母和数字
+(BOOL)validPassWordLegal:(NSString *)pass;

//过滤表情符
+ (BOOL)stringContainsEmoji:(NSString *)string;

/**
 判断字符串是否为空 否则返回空字符串

 @param string 被判断的字符串
 @return 返回必定是字符串
 @date 2018/3/12 yangjx
 */
+ (NSString *)getRightStringByCurrentString:(NSString *)string;

@end
