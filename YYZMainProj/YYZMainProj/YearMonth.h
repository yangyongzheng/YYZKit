//
//  YearMonth.h
//  YYZMainProj
//
//  Created by Young on 2020/7/24.
//  Copyright © 2020 yangyongzheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, YearMonthPeriod) {
    YearMonthPeriodFirst    = 1 << 0,   // 上旬
    YearMonthPeriodSecond   = 1 << 1,   // 中旬
    YearMonthPeriodThird    = 1 << 2,   // 下旬
};

@interface YearMonth : NSObject
@property (nonatomic) NSInteger yearNum;    // 年
@property (nonatomic) NSInteger monthNum;   // 月
@property (nonatomic) YearMonthPeriod enabledMonthPeriod;

+ (YearMonthPeriod)monthPeriodWithDay:(NSInteger)day;
@end

NS_ASSUME_NONNULL_END
