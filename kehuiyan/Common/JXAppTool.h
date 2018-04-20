//
//  JXAppTool.h
//  BZWKuaiYun
//
//  Created by Jessey Young on 2017/5/19.
//  Copyright © 2017年 ISU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JXAppTool : NSObject

//获取当前正在显示的视图控制器
+ (UIViewController*)currentViewController;


/**
 @brief 把color变成image
 @param color 传来的color
 @return 返回iamge
 */
+ (UIImage *)createImageWithColor:(UIColor *)color;


/**
 转换日期类型成为发请求的服务器要求格式字符串

 @param date 转换前的日期类型
 @return 转换后的字符串类型
 */
+ (NSString *)transformServerFormatStringByAnydate:(NSDate *)date;
/**
 转换日期类型成为字符串类型

 @param date 转换前的日期类型
 @return 转换后的字符串类型
 */
+ (NSString *)transformLocalStringByAnydate:(NSDate *)date;
/**
 @brief 获取当前的年月
 @return 返回的年月字符串 格式是YYYY-MM-DD
 */
+ (NSDate *)getCurrentTime;

+ (NSDate *)getYesterdayTimeByRandomTime:(NSDate *)date;
+ (NSDate *)getTomorrowTimeByRandomTime:(NSDate *)date;



/**
 @brief 获取当前的年

 @return 返回当前的年
 */
+ (NSInteger)getNowYearStr;

/**
 @brief 获取当前的年月

 @return 返回当前的年月
 */
+ (NSString *)getNowMonthStr;

/**
 @brief 获取当前所有时间日期
 
 @return 返回当前的所有时间日期
 */
+ (NSString *)getWholeStrYMDHMS;

/**
 @brief 获取MD5加密数据
 @param string 加密前的数据
 @return 加密后的数据
 */
+ (NSString *)MD5EncryptionWithString:(NSString *)string;

/**
 字典转json字符串方法

 @param dict 需要转换的字典
 @return 返回的JSON字符串
 */
+ (NSString *)convertToJsonData:(NSDictionary *)dict;

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
//判断是否 版本相同
+ (BOOL)isSameVersion;


/**
 @brief 把分转换成元

 @param penny 分
 @return 元
 */
+ (NSString *)transforMoneyGetPenny:(NSString *)penny;


/**
 @brief 10000 转换为10K

 @param str 原字符串
 @return 返回转换之后的字符串
 */
+ (NSString *)changeToKNumByString:(NSString *)str;


/**
 @brief 自定义流布局返回高度

 @param arr 给一个数组过来
 @return 返回约束高度
 */
+ (CGFloat)setupLeaveItem:(NSArray *)arr;

/**
 @brief 验证字符串的有效性

 @param string 待验证字符串
 @return 返回是否有效
 */
+ (BOOL)verifyIsNullString:(NSString *)string;

/**
 @brief 动态获取单元格的高度

 @param str 文字内容
 @param width 文字宽度限制
 @param font 文字的字体大小
 @return 文字所占的高度
 */
+ (CGFloat)getHeightFirstByString:(NSString *)str withStringWidth:(CGFloat)width withStringFont:(CGFloat)font;
// 同上的另一个方法  只返回所计算的字符高度 不返回最少为44 的高度
+ (CGFloat)getHeightAnotherFirstByString:(NSString *)str withStringWidth:(CGFloat)width withStringFont:(CGFloat)font;

// 只在跟踪详情页面使用的
+ (CGFloat)trailingGetHeightAnotherFirstByString:(NSString *)str withStringWidth:(CGFloat)width withStringFont:(CGFloat)font;
/**
 @brief 系统弹窗

 @param viewController 展示的控制器
 @param title 弹窗的标题
 @param msg 弹窗信息
 @param btnTitle 确定按钮的标题
 @param cancelTitle 取消按钮的标题
 */
+ (void)showAlertViewNeedShowViewController:(UIViewController *)viewController Title:(NSString *)title message:(NSString *)msg SurebuttonTitle:(NSString *)btnTitle cancelButtonTitle:(NSString *)cancelTitle;

/**
 @brief 获取存储到沙盒的路径

 @param fileName 自定义文件名称
 @return 返回完整文件路径
 */
+ (NSString *)getFilePathWithFileName:(NSString *)fileName;


/**
 判断是否是总经理以上的领导职位登录

 @return 返回yes 是领导  no 不是领导
 */
+ (BOOL)isLeader;




@end
