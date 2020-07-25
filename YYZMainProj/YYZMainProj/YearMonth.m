//
//  YearMonth.m
//  YYZMainProj
//
//  Created by Young on 2020/7/24.
//  Copyright © 2020 yangyongzheng. All rights reserved.
//

#import "YearMonth.h"

@implementation YearMonth

+ (YearMonthPeriod)monthPeriodWithDay:(NSInteger)day {
    if (day < 11) {
        return YearMonthPeriodFirst;
    } else if (day < 21) {
        return YearMonthPeriodSecond;
    } else {
        return YearMonthPeriodThird;
    }
}

@end
