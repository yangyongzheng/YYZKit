
#import "YYZKitDefines.h"

NS_ASSUME_NONNULL_BEGIN

/**
 根据R/G/B/A创建颜色，R/G/B取值范围为[0.0 255.0]，A的取值范围[0.0 1.0]。
 */
YYZKIT_EXTERN UIColor * YYZColorWithRGBA(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha);

/**
 相当于调用 `YYZColorWithRGBA(red, green, blue, 1.0)` 。
 */
YYZKIT_EXTERN UIColor * YYZColorWithRGB(CGFloat red, CGFloat green, CGFloat blue);

/**
 根据R/G/B 或 R/G/B/A 16进制字符串创建颜色，如 @"55BB22"、@"#55BB22"、@"55bb22ff"、@"0x55BB22"、@"0X55bb22" 等。
 
 @param hexString R/G/B 或 R/G/B/A 16进制字符串。可以以 "#" 或 "0x" 或 "0X" 开头，以6位或8位16进制数结尾。
 @return 当传入的hexString为无效值时返回 UIColor.clearColor，否则返回 `hexString` 对应的颜色。
 */
YYZKIT_EXTERN UIColor * YYZColorWithHexString(NSString *hexString);

/**
 根据R/G/B 或 R/G/B/A 16进制整数创建颜色，如 0x55BB22、0Xff8822、0xdcdcdcff、0xa1a1a1FF 等。
 
 @param hexInt R/G/B 或 R/G/B/A 16进制整数。
 @return 当传入的hexInt为无效值时返回 UIColor.clearColor，否则返回 `hexInt` 对应的颜色。
 */
YYZKIT_EXTERN UIColor * YYZColorWithHexInt(UInt32 hexInt);

NS_ASSUME_NONNULL_END
