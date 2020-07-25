//
//  SDDDateProvider.m
//  YYZMainProj
//
//  Created by Young on 2020/7/25.
//  Copyright © 2020 yangyongzheng. All rights reserved.
//

#import "SDDDateProvider.h"

@implementation SDDDateItem

@end

@interface SDDDateProvider ()
@property (nonatomic, copy) NSCalendar *defaultCalendar;
@property (nonatomic, copy) NSDateFormatter *defaultFormatter;
@property (nonatomic, copy) NSTimeZone *defaultTimeZone;        // GMT+8
@property (nonatomic, copy) NSLocale *defaultLocale;            // Chinese Simplified
@property (nonatomic) NSCalendarUnit defaultUnit;
@end

@implementation SDDDateProvider

+ (NSArray<NSArray<SDDDateItem *> *> *)presaleFuzzyDateItemsWithTodayDate:(NSDate *)todayDate {
    if (todayDate && [todayDate isKindOfClass:[NSDate class]]) {
        SDDDateProvider *provider = [[SDDDateProvider alloc] init];
        NSDate *endDate = [provider dateByAddingYear:1 toDate:todayDate];
        NSDateComponents *startDateComponents = [provider dateComponentsFromDate:todayDate];
        NSDateComponents *endDateComponents = [provider dateComponentsFromDate:endDate];
        
        NSMutableArray *groupDateItems = [NSMutableArray array];
        NSInteger year = startDateComponents.year;
        while (year <= endDateComponents.year) {
            NSMutableArray *sameYearItems = [NSMutableArray array];
            if (year == startDateComponents.year) {
                // 开始年份，仅大于等于开始月份的有效
                for (NSInteger m = startDateComponents.month; m <= 12; m++) {
                    if (m == startDateComponents.month) {
                        SDDDateMonthPeriod monthPeriod = [self monthPeriodWithDay:startDateComponents.day];
                        if (monthPeriod != SDDDateMonthPeriodThird) {
                            SDDDateItem *item = [[SDDDateItem alloc] init];
                            item.yearNum = year;
                            item.monthNum = m;
                            if (monthPeriod == SDDDateMonthPeriodFirst) {
                                item.enabledMonthPeriods = SDDDateMonthPeriodSecond|SDDDateMonthPeriodThird;
                            } else {
                                item.enabledMonthPeriods = SDDDateMonthPeriodThird;
                            }
                            [sameYearItems addObject:item];
                        }
                    } else {
                        SDDDateItem *item = [[SDDDateItem alloc] init];
                        item.yearNum = year;
                        item.monthNum = m;
                        item.enabledMonthPeriods = SDDDateMonthPeriodFirst|SDDDateMonthPeriodSecond|SDDDateMonthPeriodThird;
                        [sameYearItems addObject:item];
                    }
                }
            } else if (year == endDateComponents.year) {
                // 截止年份，仅小于等于截止月份的有效
                for (NSInteger m = 1; m <= endDateComponents.month; m++) {
                    SDDDateItem *item = [[SDDDateItem alloc] init];
                    item.yearNum = year;
                    item.monthNum = m;
                    if (m == endDateComponents.month) {
                        SDDDateMonthPeriod monthPeriod = [self monthPeriodWithDay:endDateComponents.day];
                        if (monthPeriod == SDDDateMonthPeriodFirst) {
                            item.enabledMonthPeriods = SDDDateMonthPeriodFirst;
                        } else if (monthPeriod == SDDDateMonthPeriodSecond) {
                            item.enabledMonthPeriods = SDDDateMonthPeriodFirst|SDDDateMonthPeriodSecond;
                        } else {
                            item.enabledMonthPeriods = SDDDateMonthPeriodFirst|SDDDateMonthPeriodSecond|SDDDateMonthPeriodThird;
                        }
                    } else {
                        item.enabledMonthPeriods = SDDDateMonthPeriodFirst|SDDDateMonthPeriodSecond|SDDDateMonthPeriodThird;
                    }
                    [sameYearItems addObject:item];
                }
            } else {
                // 中间年份，所有月份有效
                for (NSInteger m = 1; m <= 12; m++) {
                    SDDDateItem *item = [[SDDDateItem alloc] init];
                    item.yearNum = year;
                    item.monthNum = m;
                    item.enabledMonthPeriods = SDDDateMonthPeriodFirst|SDDDateMonthPeriodSecond|SDDDateMonthPeriodThird;
                    [sameYearItems addObject:item];
                }
            }
            
            if (sameYearItems.count > 0) {
                [groupDateItems addObject:[sameYearItems copy]];
            }
            
            year += 1;
        }
        
        if (groupDateItems.count > 0) {
            return [groupDateItems copy];
        }
    }
    return nil;
}

+ (SDDDateMonthPeriod)monthPeriodWithDay:(NSInteger)day {
    if (day < 11) {
        return SDDDateMonthPeriodFirst; // 1-10
    } else if (day < 21) {
        return SDDDateMonthPeriodSecond;// 11-20
    } else {
        return SDDDateMonthPeriodThird; // 21-
    }
}

+ (NSInteger)dayWithMonthPeriod:(SDDDateMonthPeriod)monthPeriod {
    if (monthPeriod == SDDDateMonthPeriodFirst) {
        return 1;
    } else if (monthPeriod == SDDDateMonthPeriodSecond) {
        return 11;
    } else {
        return 21;
    }
}

+ (NSDate *)startFuzzyDateWithFirstItem:(SDDDateItem *)firstItem {
    if (firstItem && [firstItem isKindOfClass:[SDDDateItem class]]) {
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.year = firstItem.yearNum;
        components.month = firstItem.monthNum;
        if (firstItem.enabledMonthPeriods & SDDDateMonthPeriodFirst) {
            components.day = 1;
        } else if (firstItem.enabledMonthPeriods & SDDDateMonthPeriodSecond) {
            components.day = 11;
        } else {
            components.day = 21;
        }
        SDDDateProvider *provider = [[SDDDateProvider alloc] init];
        return [provider.defaultCalendar dateFromComponents:components];
    }
    return nil;
}

+ (NSDate *)endFuzzyDateWithLastItem:(SDDDateItem *)lastItem {
    if (lastItem && [lastItem isKindOfClass:[SDDDateItem class]]) {
        SDDDateProvider *provider = [[SDDDateProvider alloc] init];
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.year = lastItem.yearNum;
        components.month = lastItem.monthNum;
        components.day = 15;
        NSDate *referDate = [provider.defaultCalendar dateFromComponents:components];
        NSDate *startDate = nil;
        NSTimeInterval interval = 0;
        const BOOL flag = [provider.defaultCalendar rangeOfUnit:NSCalendarUnitMonth
                                                      startDate:&startDate
                                                       interval:&interval
                                                        forDate:referDate];
        if (flag && startDate && interval > 0) {
            if (lastItem.enabledMonthPeriods & SDDDateMonthPeriodThird) {
                return [startDate dateByAddingTimeInterval:interval-1];
            } else if (lastItem.enabledMonthPeriods & SDDDateMonthPeriodSecond) {
                const NSTimeInterval secsToBeAdded = 86400 * 20 - 1;
                return [startDate dateByAddingTimeInterval:secsToBeAdded];
            } else {
                const NSTimeInterval secsToBeAdded = 86400 * 10 - 1;
                return [startDate dateByAddingTimeInterval:secsToBeAdded];
            }
        }
    }
    return nil;
}

+ (NSDate *)tomorrowDateSinceDate:(NSDate *)date {
    if (date && [date isKindOfClass:[NSDate class]]) {
        return [date dateByAddingTimeInterval:86400];
    }
    return nil;
}

+ (NSDate *)nextYearDateSinceDate:(NSDate *)date {
    if (date && [date isKindOfClass:[NSDate class]]) {
        SDDDateProvider *provider = [[SDDDateProvider alloc] init];
        return [provider dateByAddingYear:1 toDate:date];
    }
    return nil;
}

+ (NSDate *)dateFromString:(NSString *)dateString dateFormat:(NSString *)dateFormat {
    const BOOL precheck = (dateString && [dateString isKindOfClass:[NSString class]] && dateString.length > 0 &&
                           dateFormat && [dateFormat isKindOfClass:[NSString class]] && dateFormat.length > 0);
    if (precheck) {
        SDDDateProvider *provider = [[SDDDateProvider alloc] init];
        provider.defaultFormatter.dateFormat = dateFormat;
        return [provider.defaultFormatter dateFromString:dateString];
    }
    return nil;
}

+ (NSString *)stringFromDate:(NSDate *)date dateFormat:(NSString *)dateFormat {
    const BOOL precheck = (date && [date isKindOfClass:[NSDate class]] &&
                           dateFormat && [dateFormat isKindOfClass:[NSString class]] && dateFormat.length > 0);
    if (precheck) {
        SDDDateProvider *provider = [[SDDDateProvider alloc] init];
        provider.defaultFormatter.dateFormat = dateFormat;
        return [provider.defaultFormatter stringFromDate:date];
    }
    return nil;
}

+ (BOOL)validateDate:(NSDate *)date minDate:(NSDate *)minDate maxDate:(NSDate *)maxDate {
    const BOOL precheck = (date && [date isKindOfClass:[NSDate class]] &&
                           minDate && [minDate isKindOfClass:[NSDate class]] &&
                           maxDate && [maxDate isKindOfClass:[NSDate class]]);
    if (precheck) {
        NSComparisonResult resultOne = [date compare:minDate];
        NSComparisonResult resultTwo = [date compare:maxDate];
        return ((resultOne == NSOrderedSame || resultOne == NSOrderedDescending) &&
                (resultTwo == NSOrderedSame || resultTwo == NSOrderedAscending));
    }
    return NO;
}

#pragma mark - Private
- (NSDate *)dateByAddingYear:(NSInteger)year toDate:(NSDate *)date {
    return [self.defaultCalendar dateByAddingUnit:NSCalendarUnitYear
                                            value:year
                                           toDate:date
                                          options:0];
}

- (NSDateComponents *)dateComponentsFromDate:(NSDate *)date {
    return [self.defaultCalendar components:self.defaultUnit fromDate:date];
}

#pragma mark - getter or setter
- (NSCalendar *)defaultCalendar {
    if (!_defaultCalendar) {
        _defaultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        _defaultCalendar.timeZone = self.defaultTimeZone;
        _defaultCalendar.locale = self.defaultLocale;
    }
    return _defaultCalendar;
}

- (NSDateFormatter *)defaultFormatter {
    if (!_defaultFormatter) {
        _defaultFormatter = [[NSDateFormatter alloc] init];
        _defaultFormatter.calendar = self.defaultCalendar;
        _defaultFormatter.timeZone = self.defaultTimeZone;
        _defaultFormatter.locale = self.defaultLocale;
        _defaultFormatter.dateFormat = @"yyyy-MM-dd";
    }
    return _defaultFormatter;
}

- (NSTimeZone *)defaultTimeZone {
    if (!_defaultTimeZone) {
        _defaultTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:28800];
    }
    return _defaultTimeZone;
}

- (NSLocale *)defaultLocale {
    if (!_defaultLocale) {
        _defaultLocale = [NSLocale localeWithLocaleIdentifier:@"zh_Hans_CN"];
    }
    return _defaultLocale;
}

- (NSCalendarUnit)defaultUnit {
    if (!_defaultUnit) {
        _defaultUnit = (NSCalendarUnitYear |
                        NSCalendarUnitMonth |
                        NSCalendarUnitDay |
                        NSCalendarUnitHour |
                        NSCalendarUnitMinute |
                        NSCalendarUnitSecond);
    }
    return _defaultUnit;
}

@end
