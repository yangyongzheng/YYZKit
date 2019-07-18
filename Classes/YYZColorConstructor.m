
#import "YYZColorConstructor.h"
#import "YYZAssertNotEmpty.h"

#pragma mark - Private
#pragma mark 过滤字符串
/**
 过滤字符串，返回结果为 `nil` 或 6位有效R/G/B值 或 8位有效R/G/B/A值。
 */
static NSString * YYZPrivateFilterHexString(NSString *hexString) {
    if (YYZAssertStringNotEmpty(hexString)) {
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
                        return [filterString substringFromIndex:1];
                    } else if ([filterString hasPrefix:@"0x"] || [filterString hasPrefix:@"0X"]) {
                        return [filterString substringFromIndex:2];
                    } else {
                        return filterString;
                    }
                }
            }
        }
    }
    
    return nil;
}

#pragma mark - Public
UIColor * YYZColorWithRGBA(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha) {
    return [UIColor colorWithRed:red/255.0
                           green:green/255.0
                            blue:blue/255.0
                           alpha:alpha];
}

UIColor * YYZColorWithRGB(CGFloat red, CGFloat green, CGFloat blue) {
    return YYZColorWithRGBA(red, green, blue, 1.0);
}

UIColor * YYZColorWithHexString(NSString *hexString) {
    // 过滤字符串
    NSString *filterString = YYZPrivateFilterHexString(hexString);
    if (filterString.length >= 6) {
        // 生成 r g b a 字符串
        NSString *red = [filterString substringWithRange:NSMakeRange(0, 2)];
        NSString *green = [filterString substringWithRange:NSMakeRange(2, 2)];
        NSString *blue = [filterString substringWithRange:NSMakeRange(4, 2)];
        NSString *alpha = nil;
        if (filterString.length == 8) {alpha = [filterString substringWithRange:NSMakeRange(6, 2)];}
        // 按照16进制整数格式读取，转化为 [0 255] 之间的整数
        unsigned int r = 0, g = 0, b = 0, a = 255;
        sscanf(red.UTF8String, "%X", &r);
        sscanf(green.UTF8String, "%X", &g);
        sscanf(blue.UTF8String, "%X", &b);
        if (alpha) {sscanf(alpha.UTF8String, "%X", &a);}
        
        return [UIColor colorWithRed:(CGFloat)r/255.0
                               green:(CGFloat)g/255.0
                                blue:(CGFloat)b/255.0
                               alpha:(CGFloat)a/255.0];
    }
    
    return UIColor.clearColor;
}

UIColor * YYZColorWithHexInt(UInt32 hexInt) {
    NSString *hexString = [NSString stringWithFormat:@"%X", hexInt];
    return YYZColorWithHexString(hexString);
}
