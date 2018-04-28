//
//  JXAppTool.m
//  BZWKuaiYun
//
//  Created by Jessey Young on 2017/5/19.
//  Copyright © 2017年 ISU. All rights reserved.
//

#import "JXAppTool.h"
#import <CommonCrypto/CommonDigest.h>

@implementation JXAppTool

//获取当前正在显示的视图控制器
+ (UIViewController*)currentViewController
{
    //获得当前活动窗口的根视图
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1)
    {
        //根据不同的页面切换方式，逐步取得最上层的viewController
        if ([vc isKindOfClass:[UITabBarController class]])
        {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]])
        {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController)
        {
            vc = vc.presentedViewController;
        }
        else
        {
            break;
        }
    }
    return vc;
}


+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}
+ (NSString *)transformServerFormatStringByAnydate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:date];
    return dateTime;
}
+ (NSString *)transformLocalStringByAnydate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *dateTime = [formatter stringFromDate:date];
    return dateTime;
}
+ (NSDate *)getCurrentTime
{
    return [NSDate date];
}
+ (NSDate *)getYesterdayTimeByRandomTime:(NSDate *)date
{
    NSDate *lastDate = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:date];
    return lastDate;
}
+ (NSDate *)getTomorrowTimeByRandomTime:(NSDate *)date
{
    NSDate *nextDate = [NSDate dateWithTimeInterval:24*60*60 sinceDate:date];
    return nextDate;
}
+ (NSInteger)getNowYearStr
{
    NSDate *date = [NSDate date];
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"YYYY"];
    NSString *dateStr = [format stringFromDate:date];
    return [dateStr integerValue];
}

+ (NSString *)getNowMonthStr
{
    NSDate *date = [NSDate date];
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM"];
    NSString *dateStr = [format stringFromDate:date];
    return dateStr;
}

+ (NSString *)getWholeStrYMDHMS
{
    NSDate *date = [NSDate date];
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    format.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    NSString *dateStr = [format stringFromDate:date];
    return dateStr;
}

+ (NSString *)MD5EncryptionWithString:(NSString *)string
{
    const char *cStr = [string UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    NSString *MD5String = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",result[0], result[1], result[2], result[3],result[4], result[5], result[6], result[7],result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
    
    return MD5String;
}

// 字典转json字符串方法
+ (NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil)
    {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&err];
    
    if(err)
    {
//        JXLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

//自定义 按钮流布局
+ (CGFloat)setupLeaveItem:(NSArray *)arr
{
    CGFloat sumWidth = 0.0f;
    int row = 0;
    CGFloat maxY = .0f;
    
    BOOL isChange = NO;
    if (![JXAppTool verifyIsNullString:[arr firstObject]])
    {
        for (int i = 0 ; i < arr.count; i++)
        {
            if (sumWidth < SCREEN_WIDTH)
            {
                UILabel *txtLab = [[UILabel alloc] init];
                CGSize size =  [arr[i] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
                if (i == 0)//确定第一个位置
                {
                    txtLab.frame = CGRectMake(25, 10, size.width+10, 25);
                    maxY = CGRectGetMaxY(txtLab.frame)+10;
                }
                else
                {
                    if (i == arr.count - 1) //确定最后的maxY
                    {
                        if (sumWidth + size.width + 10 + 25 <= SCREEN_WIDTH)
                        {
                            txtLab.frame = CGRectMake(sumWidth, row * 25 + 10 * (row + 1), size.width+10, 25);
                            maxY = CGRectGetMaxY(txtLab.frame)+10;
                        }
                        else
                        {
                            row = row + 1;
                            txtLab.frame = CGRectMake(25, row * 25 + 10 * (row + 1), size.width+10, 25);
                            maxY = CGRectGetMaxY(txtLab.frame)+10;
                        }
                    }
                    else //非最后的
                    {
                        if (sumWidth + size.width + 10 + 25 <= SCREEN_WIDTH)
                        {
                            txtLab.frame = CGRectMake(sumWidth, row * 25 + 10 * (row + 1), size.width+10, 25);
                        }
                        else
                        {
                            row = row + 1;
                            isChange = YES;
                            txtLab.frame = CGRectMake(25, row * 25 + 10 * (row + 1), size.width+10, 25);
                        }
                    }
                    
                }
                
                sumWidth= CGRectGetMaxX(txtLab.frame) + 10;
            }
        }
        return maxY;
    }
    else
    {
        return 0;
    }
}

+ (BOOL)verifyIsNullString:(NSString *)string
{
    NSString *str = @"";
    if ([string isKindOfClass:[NSNumber class]])
    {
        str = [NSString stringWithFormat:@"%@",string];
    }
    else
    {
        str = string;
    }
    
    return (str == nil || [str isKindOfClass:[NSNull class]] || [str isEqual:[NSNull null]] ||str.length <= 0);
}

+ (CGFloat)getHeightFirstByString:(NSString *)str withStringWidth:(CGFloat)width withStringFont:(CGFloat)font
{
    NSMutableParagraphStyle *paragphStyle=[[NSMutableParagraphStyle alloc]init];
    paragphStyle.lineSpacing=0;//设置行距为0
    paragphStyle.firstLineHeadIndent=0.0;
    paragphStyle.hyphenationFactor=0.0;
    paragphStyle.paragraphSpacingBefore=0.0;
    NSDictionary *dic=@{NSFontAttributeName:[UIFont systemFontOfSize:font],
                        NSParagraphStyleAttributeName:paragphStyle, NSKernAttributeName:@1.2f};
    CGSize size=[str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return 15 + ceil(size.height) <= 44 ? 44.f : 15 + ceil(size.height);
}
+ (CGFloat)getHeightAnotherFirstByString:(NSString *)str withStringWidth:(CGFloat)width withStringFont:(CGFloat)font
{
    NSMutableParagraphStyle *paragphStyle=[[NSMutableParagraphStyle alloc]init];
    paragphStyle.lineSpacing=0;//设置行距为0
    paragphStyle.firstLineHeadIndent=0.0;
    paragphStyle.hyphenationFactor=0.0;
    paragphStyle.paragraphSpacingBefore=0.0;
    NSDictionary *dic=@{NSFontAttributeName:[UIFont systemFontOfSize:font],
                        NSParagraphStyleAttributeName:paragphStyle, NSKernAttributeName:@1.0f};
    CGSize size=[str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return ceil(size.height);
}
+ (CGFloat)trailingGetHeightAnotherFirstByString:(NSString *)str withStringWidth:(CGFloat)width withStringFont:(CGFloat)font
{
    NSMutableParagraphStyle *paragphStyle=[[NSMutableParagraphStyle alloc]init];
    paragphStyle.lineSpacing=0;//设置行距为0
    paragphStyle.firstLineHeadIndent=0.0;
    paragphStyle.hyphenationFactor=0.0;
    paragphStyle.paragraphSpacingBefore=0.0;
    NSDictionary *dic=@{NSFontAttributeName:[UIFont systemFontOfSize:font],
                        NSParagraphStyleAttributeName:paragphStyle, NSKernAttributeName:@2.0f};
    CGSize size=[str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}
+ (void)showAlertViewNeedShowViewController:(UIViewController *)viewController Title:(NSString *)title message:(NSString *)msg SurebuttonTitle:(NSString *)btnTitle cancelButtonTitle:(NSString *)cancelTitle
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [viewController presentViewController:alert animated:YES completion:nil];
}
// level_id <= 3 是领导
+ (BOOL)isLeader{
    
    // 在判断是否是 总经理以上的领导层
    NSInteger positionID = [[HelperManager CreateInstance].level_id integerValue];
    if (positionID <= 3 && positionID > 0) {
        return YES;
    }
    else{
        return NO;
    }
}

@end
