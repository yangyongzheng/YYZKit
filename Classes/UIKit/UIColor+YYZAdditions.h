
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (YYZAdditions)

/**
 解析规则：6位有效16进制字符串按 RRGGBB 解析，8位按照 RRGGBBAA 解析，其他情况直接返回`[UIColor clearColor]`
 */
@property (class, nonatomic, readonly) UIColor *(^ yyz_hexString)(NSString *);

/**
 解析规则：6位有效16进制字符串按 RRGGBB 解析，8位按照 AARRGGBB 解析，其他情况直接返回`[UIColor clearColor]`
 */
@property (class, nonatomic, readonly) UIColor *(^ yyz_reverseHexString)(NSString *);

/**
 校验是否为有效(可解析)16进制字符串

 @param hexString 16进制字符串
 */
+ (BOOL)yyz_isValidHexString:(NSString *)hexString;

@end

NS_ASSUME_NONNULL_END
