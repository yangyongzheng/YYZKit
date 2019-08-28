
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (YYZAdditions)

/**
 解析规则：6位有效16进制数时按R/G/B解析，8位按照R/G/B/A解析，其他情况直接返回`[UIColor clearColor]`
 */
@property (class, nonatomic, readonly) UIColor *(^ yyz_hexInt)(uint32_t);

/**
 解析规则：6位有效16进制字符串时按R/G/B解析，8位按照R/G/B/A解析，其他情况直接返回`[UIColor clearColor]`
 */
@property (class, nonatomic, readonly) UIColor *(^ yyz_hexString)(NSString *);

/**
 解析规则：6位有效16进制数时按R/G/B解析，8位按照A/R/G/B解析，其他情况直接返回`[UIColor clearColor]`
 */
@property (class, nonatomic, readonly) UIColor *(^ yyz_reverseHexInt)(uint32_t);

/**
 解析规则：6位有效16进制字符串时按R/G/B解析，8位按照A/R/G/B解析，其他情况直接返回`[UIColor clearColor]`
 */
@property (class, nonatomic, readonly) UIColor *(^ yyz_reverseHexString)(NSString *);

/**
 校验是否为有效16进制字符串

 @param hexString 16进制字符串
 */
+ (BOOL)yyz_isValidHexString:(NSString *)hexString;

@end

NS_ASSUME_NONNULL_END
