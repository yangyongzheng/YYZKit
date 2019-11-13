
#import "UIColor+YYZAdditions.h"

@implementation UIColor (YYZAdditions)

+ (UIColor * _Nonnull (^)(NSString * _Nonnull))yyz_hexString {
    return ^id(NSString *string) {
        NSString *filteredHexString = nil;
        if ([self yyz_isValidHexString:string filteredPrefix:&filteredHexString]) {
            return [self yyz_colorWithValidHexString:filteredHexString beginWithAlpha:NO];
        } else {
            return [UIColor clearColor];
        }
    };
}

+ (UIColor * _Nonnull (^)(NSString * _Nonnull))yyz_reverseHexString {
    return ^id(NSString *string) {
        NSString *filteredHexString = nil;
        if ([self yyz_isValidHexString:string filteredPrefix:&filteredHexString]) {
            return [self yyz_colorWithValidHexString:filteredHexString beginWithAlpha:YES];
        } else {
            return [UIColor clearColor];
        }
    };
}

+ (BOOL)yyz_isValidHexString:(NSString *)hexString {
    return [self yyz_isValidHexString:hexString filteredPrefix:nil];
}

+ (BOOL)yyz_isValidHexString:(NSString *)hexString filteredPrefix:(NSString **)result {
    NSString *validHexString = nil;
    if (hexString && [hexString isKindOfClass:[NSString class]] && hexString.length > 0) {
        // 1.过滤首尾两端空格字符以及换行符
        NSString *filterString = [hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (filterString && filterString.length > 0) {
            // 2.过滤所有空格字符
            filterString = [filterString stringByReplacingOccurrencesOfString:@" " withString:@""];
            if (filterString && filterString.length > 0) {
                // 3.正则校验是否以 `#` 或 `0x` 或 `0X` 开头，6位有效R/G/B值或8位有效R/G/B/A值结尾
                NSString *regularExpression = @"^(#|0x|0X)?([0-9a-fA-F]{6}|[0-9a-fA-F]{8})$";
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regularExpression];
                if ([predicate evaluateWithObject:filterString]) {
                    // 4.正则校验通过时，返回有效的R/G/B或R/G/B/A字符串
                    if ([filterString hasPrefix:@"#"]) {
                        validHexString = [filterString substringFromIndex:1];
                    } else if ([filterString hasPrefix:@"0x"] || [filterString hasPrefix:@"0X"]) {
                        validHexString = [filterString substringFromIndex:2];
                    } else {
                        validHexString = filterString;
                    }
                }
            }
        }
    }
    if (result) {
        *result = validHexString;
    }
    
    return validHexString && validHexString.length > 0;
}

+ (UIColor *)yyz_colorWithValidHexString:(NSString *)hexString beginWithAlpha:(BOOL)isBeginWithAlpha {
    if (hexString && [hexString isKindOfClass:[NSString class]] && hexString.length == 6) {
        NSString *rstring = [hexString substringWithRange:NSMakeRange(0, 2)];
        NSString *gstring = [hexString substringWithRange:NSMakeRange(2, 2)];
        NSString *bstring = [hexString substringWithRange:NSMakeRange(4, 2)];
        int r, g, b;
        sscanf(rstring.UTF8String, "%X", &r);
        sscanf(gstring.UTF8String, "%X", &g);
        sscanf(bstring.UTF8String, "%X", &b);
        return [UIColor colorWithRed:(CGFloat)r/255.0
                               green:(CGFloat)g/255.0
                                blue:(CGFloat)b/255.0
                               alpha:1.0];
    } else if (hexString && [hexString isKindOfClass:[NSString class]] && hexString.length == 8) {
        NSString *rstring, *gstring, *bstring, *astring;
        if (isBeginWithAlpha) {
            astring = [hexString substringWithRange:NSMakeRange(0, 2)];
            rstring = [hexString substringWithRange:NSMakeRange(2, 2)];
            gstring = [hexString substringWithRange:NSMakeRange(4, 2)];
            bstring = [hexString substringWithRange:NSMakeRange(6, 2)];
        } else {
            rstring = [hexString substringWithRange:NSMakeRange(0, 2)];
            gstring = [hexString substringWithRange:NSMakeRange(2, 2)];
            bstring = [hexString substringWithRange:NSMakeRange(4, 2)];
            astring = [hexString substringWithRange:NSMakeRange(6, 2)];
        }
        int r, g, b, a;
        sscanf(rstring.UTF8String, "%X", &r);
        sscanf(gstring.UTF8String, "%X", &g);
        sscanf(bstring.UTF8String, "%X", &b);
        sscanf(astring.UTF8String, "%X", &a);
        return [UIColor colorWithRed:(CGFloat)r/255.0
                               green:(CGFloat)g/255.0
                                blue:(CGFloat)b/255.0
                               alpha:(CGFloat)a/255.0];
    } else {
        return [UIColor clearColor];
    }
}

@end
