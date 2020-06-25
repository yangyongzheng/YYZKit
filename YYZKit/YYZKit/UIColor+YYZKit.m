//
//  UIColor+YYZKit.m
//  YYZKit
//
//  Created by Young on 2020/6/18.
//  Copyright © 2020 Young. All rights reserved.
//

#import "UIColor+YYZKit.h"

@implementation UIColor (YYZKit)

+ (BOOL)isValidHexString:(NSString *)hexString {
    NSString *validHexCode = [self privateFilterHexCode:hexString];
    return [self privateValidateHexCode:validHexCode];
}

+ (UIColor *)colorWithRGBAHexString:(NSString *)hexString {
    NSString *validHexCode = [self privateFilterHexCode:hexString];
    if ([self privateValidateHexCode:validHexCode]) {
        if (validHexCode.length == 6) {
            validHexCode = [NSString stringWithFormat:@"%@FF", validHexCode];
        }
        int red, green, blue, alpha;
        int matchCount = sscanf(validHexCode.UTF8String, "%2x%2x%2x%2x", &red, &green, &blue, &alpha);
        if (matchCount == 4) { // 4 为 sscanf 函数成功匹配和赋值的个数
            return [UIColor colorWithRed:(CGFloat)red/255.0
                                   green:(CGFloat)green/255.0
                                    blue:(CGFloat)blue/255.0
                                   alpha:(CGFloat)alpha/255.0];
        }
    }
    NSAssert(0, @"入参<%@>非法，颜色创建失败：%s", hexString, __func__);
    return [UIColor clearColor];
}

+ (UIColor *)colorWithARGBHexString:(NSString *)hexString {
    NSString *validHexCode = [self privateFilterHexCode:hexString];
    if ([self privateValidateHexCode:validHexCode]) {
        if (validHexCode.length == 6) {
            validHexCode = [NSString stringWithFormat:@"FF%@", validHexCode];
        }
        int red, green, blue, alpha;
        int matchCount = sscanf(validHexCode.UTF8String, "%2x%2x%2x%2x", &alpha, &red, &green, &blue);
        if (matchCount == 4) { // 4 为 sscanf 函数成功匹配和赋值的个数
            return [UIColor colorWithRed:(CGFloat)red/255.0
                                   green:(CGFloat)green/255.0
                                    blue:(CGFloat)blue/255.0
                                   alpha:(CGFloat)alpha/255.0];
        }
    }
    NSAssert(0, @"入参<%@>非法，颜色创建失败：%s", hexString, __func__);
    return [UIColor clearColor];
}

#pragma mark - Private
+ (NSString *)privateFilterHexCode:(NSString *)hexCode {
    if (hexCode && [hexCode isKindOfClass:[NSString class]] && hexCode.length >= 6) {
        NSString *safeHexCode = [hexCode copy];
        NSString *result = [safeHexCode stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
        if (result && result.length >= 6) {
            result = [result stringByReplacingOccurrencesOfString:@" " withString:@""];
            if (result && result.length >= 6) {
                if ([result hasPrefix:@"#"]) {
                    return [result substringFromIndex:1];
                } else if ([result hasPrefix:@"0x"] || [result hasPrefix:@"0X"]) {
                    return [result substringFromIndex:2];
                } else {
                    return result;
                }
            }
        }
    }
    return nil;
}

+ (BOOL)privateValidateHexCode:(NSString *)hexCode {
    if (hexCode && [hexCode isKindOfClass:[NSString class]] && hexCode.length >= 6) {
        static NSPredicate *validator = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            NSString *regular = @"^[0-9a-fA-F]{6}([0-9a-fA-f]{2})?$";
            validator = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regular];
        });
        
        return [validator evaluateWithObject:hexCode];
    }
    return NO;
}

@end
