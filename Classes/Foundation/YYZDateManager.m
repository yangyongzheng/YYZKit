
#import "YYZDateManager.h"

@implementation YYZDateManager

+ (NSCalendar *)gregorianCalendar {
    static NSCalendar *calendar = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
        calendar.locale = [YYZDateManager chineseLocale];
        calendar.timeZone = [YYZDateManager beijingTimeZone];
    });
    
    return calendar;
}

+ (NSDateComponents *)chineseDateComponentsFromDate:(NSDate *)fromDate {
    return [YYZDateManager.gregorianCalendar componentsInTimeZone:YYZDateManager.beijingTimeZone
                                                         fromDate:fromDate];
}

+ (NSDateFormatter *)chineseDateFormatterWithDateFormat:(NSString *)dateFormat {
    return [self dateFormatterWithDateFormat:dateFormat locale:YYZDateManager.chineseLocale];
}

+ (NSDateFormatter *)englishDateFormatterWithDateFormat:(NSString *)dateFormat {
    return [self dateFormatterWithDateFormat:dateFormat locale:YYZDateManager.englishLocale];
}

+ (NSString *)stringFromTimeInterval:(NSTimeInterval)intervalSeconds dateFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = [self chineseDateFormatterWithDateFormat:dateFormat];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:intervalSeconds];
    return [formatter stringFromDate:date];
}

+ (NSTimeInterval)timeIntervalFromString:(NSString *)string dateFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = [self chineseDateFormatterWithDateFormat:dateFormat];
    NSDate *date = [formatter dateFromString:string];
    return [date timeIntervalSince1970];
}

#pragma mark - Private
+ (NSTimeZone *)beijingTimeZone {
    return [NSTimeZone timeZoneForSecondsFromGMT:28800];
}

+ (NSLocale *)chineseLocale {
    return [NSLocale localeWithLocaleIdentifier:@"zh"];
}

+ (NSLocale *)englishLocale {
    return [NSLocale localeWithLocaleIdentifier:@"en_US"];
}

+ (NSDateFormatter *)dateFormatterWithDateFormat:(NSString *)dateFormat locale:(NSLocale *)locale {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.calendar = [YYZDateManager gregorianCalendar];
    dateFormatter.timeZone = [YYZDateManager beijingTimeZone];
    dateFormatter.locale = locale ?: [YYZDateManager chineseLocale];
    dateFormatter.dateFormat = dateFormat ?: YYZDateFormatterLongStyle;
    return dateFormatter;
}

@end
