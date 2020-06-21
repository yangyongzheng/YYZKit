//
//  YYZKitFunctions.h
//  YYZKit
//
//  Created by Young on 2020/6/21.
//  Copyright © 2020 Young. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT BOOL YYZAssertStringNotEmpty(id string);
FOUNDATION_EXPORT BOOL YYZAssertMutableStringNotEmpty(id mutableString);
FOUNDATION_EXPORT BOOL YYZAssertArrayNotEmpty(id array);
FOUNDATION_EXPORT BOOL YYZAssertMutableArrayNotEmpty(id mutableArray);
FOUNDATION_EXPORT BOOL YYZAssertDictionaryNotEmpty(id dictionary);
FOUNDATION_EXPORT BOOL YYZAssertMutableDictionaryNotEmpty(id mutableDictionary);

FOUNDATION_EXPORT void YYZSafeSyncMainQueue(void (^ block)(void));
FOUNDATION_EXPORT void YYZSafeAsyncMainQueue(void (^ block)(void));

FOUNDATION_EXPORT double YYZFloor(double num, short scale);

@interface YYZKitFunctions : NSObject

@end

NS_ASSUME_NONNULL_END
