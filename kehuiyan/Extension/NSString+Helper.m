//
//  NSString+Helper.h
//  AIYISHU
//
//  Created by Mr.Psychosis on 14/9/23.
//  Copyright (c) 2014年 Frank. All rights reserved.
//

#import "NSString+Helper.h"
@implementation NSString (Helper)

#pragma mark 是否空字符串
- (BOOL)isEmptyString {
    if (![self isKindOfClass:[NSString class]]) {
        return TRUE;
    }else if (self==nil) {
        return TRUE;
    }else if(!self) {
        // null object
        return TRUE;
    } else if(self==NULL) {
        // null object
        return TRUE;
    } else if([self isEqualToString:@"NULL"]) {
        // null object
        return TRUE;
    }else if([self isEqualToString:@"(null)"]){
        
        return TRUE;
    }else{
        //  使用whitespaceAndNewlineCharacterSet删除周围的空白字符串
        //  然后在判断首位字符串是否为空
        NSString *trimedString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([trimedString length] == 0) {
            // empty string
            return TRUE;
        } else {
            // is neither empty nor null
            return FALSE;
        }
    }
}

#pragma mark 判断是否是手机号
- (BOOL)checkTel {
    NSString *regex = @"^((13[0-9])|(14[0-9])|(17[0-9])|(15[0-9])|(18[0-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}

#pragma mark 判断是否是邮箱
- (BOOL)isValidateEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

#pragma mark 清空字符串中的空白字符
- (NSString *)trimString {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark 返回沙盒中的文件路径
+ (NSString *)stringWithDocumentsPath:(NSString *)path {
    NSString *file = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return [file stringByAppendingPathComponent:path];
}

#pragma mark 写入系统偏好
- (void)saveToNSDefaultsWithKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:self forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//自定义字体字符高度
+ (CGFloat)heightCustomAdjustWidth:(CGFloat)width font:(UIFont *)font forString:(NSString *)string paragraphStyle:(NSMutableParagraphStyle*)paragraphStyle
{
    NSDictionary *attribute = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle};
    CGSize retSize = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                                    options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                                 attributes:attribute
                                                    context:nil].size;
    return retSize.height;
}


+ (CGFloat)widthCustomAdjustheight:(CGFloat)height font:(UIFont *)font forString:(NSString *)string paragraphStyle:(NSMutableParagraphStyle*)paragraphStyle
{
    NSDictionary *attribute = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle};
    CGSize retSize = [string boundingRectWithSize:CGSizeMake(MAXFLOAT,height)
                                          options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                       attributes:attribute
                                          context:nil].size;
    return retSize.width;
}

+ (CGFloat)widthAdjustheight:(CGFloat)height font:(UIFont *)font forString:(NSString *)string
{
    CGSize size = CGSizeMake(MAXFLOAT, height);
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    NSStringDrawingOptions options = (NSStringDrawingOptions)(NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading);
    CGSize actualsize =[string boundingRectWithSize:size options:options attributes:dic context:nil].size;
    return actualsize.width;
}


//系统字体计算
+ (CGFloat)heightAdjustWidth:(CGFloat)width font:(UIFont *)font forString:(NSString *)string
{
    CGSize size = CGSizeMake(width, MAXFLOAT);
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    NSStringDrawingOptions options = (NSStringDrawingOptions)(NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading);
    CGSize actualsize =[string boundingRectWithSize:size options:options attributes:dic context:nil].size;
    return actualsize.height;
}

#pragma mark 一串字符在固定宽度下，正常显示所需要的高度 method
+ (CGFloat)autoHeightWithString:(NSString *)string Width:(CGFloat)width Font:(UIFont *)font {
    NSMutableParagraphStyle * paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = 5;//行间距
    paragraph.paragraphSpacing = 50;//段落间隔
    paragraph.firstLineHeadIndent = 50;//首行缩近
    //绘制属性（字典）
    NSDictionary * dictA = @{NSFontAttributeName:[UIFont systemFontOfSize:20],
                             NSForegroundColorAttributeName:[UIColor greenColor],
                             NSBackgroundColorAttributeName:[UIColor grayColor],
                             NSParagraphStyleAttributeName:paragraph,
//                                NSObliquenessAttributeName:@0.5 //斜体
//                                NSStrokeColorAttributeName:[UIColor whiteColor],
//                                NSStrokeWidthAttributeName:@2,//描边
//                                NSKernAttributeName:@20,//字间距
//                                NSStrikethroughStyleAttributeName:@2//删除线
//                                NSUnderlineStyleAttributeName:@1,//下划线
                             };

    //大小
    CGSize boundRectSize = CGSizeMake(width, MAXFLOAT);
    
    //调用方法,得到高度
    CGFloat newFloat = [string boundingRectWithSize:boundRectSize
                                            options: NSStringDrawingUsesLineFragmentOrigin
                        | NSStringDrawingUsesFontLeading
                                         attributes:dictA context:nil].size.height;
    return newFloat;
}

#pragma mark 一串字符在一行中正常显示所需要的宽度 method
+ (CGFloat)autoWidthWithString:(NSString *)string Font:(UIFont *)font {
    
    //大小
    CGSize boundRectSize = CGSizeMake(MAXFLOAT, font.lineHeight);
    //绘制属性（字典）
    NSDictionary *fontDict = @{ NSFontAttributeName: font };
    //调用方法,得到高度
    CGFloat newFloat = [string boundingRectWithSize:boundRectSize
                                            options: NSStringDrawingUsesLineFragmentOrigin
                        | NSStringDrawingUsesFontLeading
                                         attributes:fontDict context:nil].size.width;
    return newFloat;
}

+ (NSAttributedString *)makeDeleteLine:(NSString *)string{
    string = [NSString stringWithFormat:@"<html><body style =\"font-size:12px;\"><s><font color=\"#B6B6B6\">%@</font></s></body></html>",string];
    NSAttributedString * attributeString = [[NSAttributedString alloc]initWithData:[string dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    return attributeString;
}

+ (NSString *)StringHaveNextLine:(NSArray *)array{
    NSString *lineString;
//    for (NSInteger index = 0; index < array.count; index ++) {
//        ZJPFriendInfoBrandList *infoBrand = array[index];
//        if (index == 0) {
//            lineString = [NSString stringWithFormat:@"%@",infoBrand.brandCNName];
//        }else{
//            lineString = [NSString stringWithFormat:@"%@\n%@",lineString,infoBrand.brandCNName];
//        }
//        
//    }
    return lineString;
}

+ (NSString *)dateStringWithDate:(NSDate *)date DateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSString *str = [dateFormatter stringFromDate:date];
    return str ? str : @"";
}


//去除字符串特殊字符及空格
+ (NSString *)stringByTrimmingCharactersInSetEx:(NSString *)str {
    
    //去除两端的空格
    NSString *tempStr = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //去除回车
    NSString *resultStr = [tempStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    //去除特殊字符
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"./@／：；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\"^_^"];
    NSString *trimmedString = [resultStr stringByTrimmingCharactersInSet:set];
    return trimmedString;
}

//去除Html标签
/*+ (NSString *)stringByReplacingHTMLRegex:(NSString *)htmlStr {
    NSString *regEx = @"<([^>]*)>";
    NSString *resultStr = [htmlStr stringByReplacingOccurrencesOfRegex:regEx withString:@""];
    return resultStr;
}*/

//验证密码是否符合要求(同时包含字母和数字)
+(BOOL)validPassWordLegal:(NSString *)pass{
    BOOL result = false;
    if ([pass length]>=6 && [pass length]<=11){
        // 判断长度6~11位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,11}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:pass];
    }
    return result;
}

//过滤表情符
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

+ (BOOL)yjxStringIsEmptyWith:(NSString *)str
{
    if (![str isKindOfClass:[NSString class]]) {
        return TRUE;
    }else if (str==nil) {
        return TRUE;
    }else if(!str) {
        // null object
        return TRUE;
    } else if(str==NULL) {
        // null object
        return TRUE;
    } else if([str isEqualToString:@"NULL"]) {
        // null object
        return TRUE;
    }else if([str isEqualToString:@"(null)"]){
        
        return TRUE;
    }else{
        //  使用whitespaceAndNewlineCharacterSet删除周围的空白字符串
        //  然后在判断首位字符串是否为空
        NSString *trimedString = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([trimedString length] == 0) {
            // empty string
            return TRUE;
        } else {
            // is neither empty nor null
            return FALSE;
        }
    }
}


+ (NSString *)getRightStringByCurrentString:(NSString *)string
{
    if ([NSString yjxStringIsEmptyWith:string])
    {
        return @"";
    }
    else
    {
        return string;
    }
}

@end
