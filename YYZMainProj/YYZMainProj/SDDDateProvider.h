//
//  SDDDateProvider.h
//  YYZMainProj
//
//  Created by Young on 2020/7/25.
//  Copyright © 2020 yangyongzheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, SDDDateMonthPeriod) {
    SDDDateMonthPeriodFirst     = 1 << 0,   // 上旬
    SDDDateMonthPeriodSecond    = 1 << 1,   // 中旬
    SDDDateMonthPeriodThird     = 1 << 2,   // 下旬
};



@interface SDDDateItem : NSObject
@property (nonatomic) NSInteger yearNum;    // 年
@property (nonatomic) NSInteger monthNum;   // 月
@property (nonatomic) SDDDateMonthPeriod enabledMonthPeriods;
@end



@interface SDDDateProvider : NSObject

+ (NSArray<NSArray<SDDDateItem *> *> *)presaleFuzzyDateItemsWithTodayDate:(NSDate *)todayDate;

+ (SDDDateMonthPeriod)monthPeriodWithDay:(NSInteger)day;

+ (NSInteger)dayWithMonthPeriod:(SDDDateMonthPeriod)monthPeriod;

+ (NSDate *)startFuzzyDateWithFirstItem:(SDDDateItem *)firstItem;

+ (NSDate *)endFuzzyDateWithLastItem:(SDDDateItem *)lastItem;

+ (NSDate *)tomorrowDateSinceDate:(NSDate *)date;

+ (NSDate *)nextYearDateSinceDate:(NSDate *)date;

+ (NSDate *)dateFromString:(NSString *)dateString dateFormat:(NSString *)dateFormat;

+ (NSString *)stringFromDate:(NSDate *)date dateFormat:(NSString *)dateFormat;

+ (BOOL)validateDate:(NSDate *)date minDate:(NSDate *)minDate maxDate:(NSDate *)maxDate;

@end

NS_ASSUME_NONNULL_END
