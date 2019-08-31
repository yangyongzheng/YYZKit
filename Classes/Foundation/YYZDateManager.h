
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 格式化日期
 
 年: yyyy
 月: M 9, MM 09, MMM Sept, MMMM September, MMMMM S
 日: d 表示 Day of the month, D 表示 Day of year, F 表示 Day of Week in Month.
 时: h [1 12], H [0 23], Use hh or HH for zero padding.
 分: m/mm Use one or two for zero padding.
 秒: s/ss Use one or two for zero padding.
 毫秒: SSS
 */
static NSString * const YYZDateFormatterShortStyle = @"yyyy-MM-dd";
static NSString * const YYZDateFormatterLongStyle = @"yyyy-MM-dd HH:mm:ss";
static NSString * const YYZDateFormatterFullStyle = @"yyyy-MM-dd HH:mm:ss.SSS";
static NSString * const YYZDateFormatterForeignStyle = @"MMM dd, yyyy h:mm:ss a";

@interface YYZDateManager : NSObject

/** 日期(中国北京时区)的所有组件 */
+ (NSDateComponents *)chineseDateComponentsFromDate:(NSDate *)fromDate;

/**
 日期格式化对象
 
 1.timeZone: GMT+8（北京时区）
 2.locale: 本地化为简体中文
 */
+ (NSDateFormatter *)chineseDateFormatterWithDateFormat:(NSString *)dateFormat;

/**
 日期格式化对象
 
 1.timeZone: GMT+8（北京时区）
 2.locale: 本地化为英语（美国）
 */
+ (NSDateFormatter *)englishDateFormatterWithDateFormat:(NSString *)dateFormat;

/**
 时间戳(单位秒)转字符串
 
 @param intervalSeconds 时间戳，单位秒
 @param dateFormat 日期格式
 */
+ (NSString *)stringFromTimeInterval:(NSTimeInterval)intervalSeconds
                          dateFormat:(NSString *)dateFormat;

/**
 字符串转时间戳
 
 @param string 时间字符串
 @param dateFormat 时间字符串格式
 @return 时间戳
 */
+ (NSTimeInterval)timeIntervalFromString:(NSString *)string
                              dateFormat:(NSString *)dateFormat;

@end

NS_ASSUME_NONNULL_END
