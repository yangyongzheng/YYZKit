//
//  UIColor+YYZKit.h
//  YYZKit
//
//  Created by Young on 2020/6/18.
//  Copyright © 2020 Young. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define YYZColorIsValidHexString(hexString) [UIColor isValidHexString:hexString]
#define YYZColorWithRGBA(hexString) [UIColor colorWithRGBAHexString:hexString]
#define YYZColorWithARGB(hexString) [UIColor colorWithARGBHexString:hexString]

@interface UIColor (YYZKit)

+ (BOOL)isValidHexString:(NSString *)hexString;

+ (UIColor *)colorWithRGBAHexString:(NSString *)hexString;

+ (UIColor *)colorWithARGBHexString:(NSString *)hexString;

@end

NS_ASSUME_NONNULL_END
