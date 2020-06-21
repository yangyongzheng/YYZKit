//
//  YYZKitFunctions.m
//  YYZKit
//
//  Created by Young on 2020/6/21.
//  Copyright © 2020 Young. All rights reserved.
//

#import "YYZKitFunctions.h"

BOOL YYZAssertStringNotEmpty(id string) {
    return (string &&
            [string isKindOfClass:[NSString class]] &&
            [string length] > 0);
}

BOOL YYZAssertMutableStringNotEmpty(id mutableString) {
    return (mutableString &&
            [mutableString isKindOfClass:[NSMutableString class]] &&
            [mutableString length] > 0);
}

BOOL YYZAssertArrayNotEmpty(id array) {
    return (array &&
            [array isKindOfClass:[NSArray class]] &&
            [array count] > 0);
}

BOOL YYZAssertMutableArrayNotEmpty(id mutableArray) {
    return (mutableArray &&
            [mutableArray isKindOfClass:[NSMutableArray class]] &&
            [mutableArray count] > 0);
}

BOOL YYZAssertDictionaryNotEmpty(id dictionary) {
    return (dictionary &&
            [dictionary isKindOfClass:[NSDictionary class]] &&
            [dictionary count] > 0);
}

BOOL YYZAssertMutableDictionaryNotEmpty(id mutableDictionary) {
    return (mutableDictionary &&
            [mutableDictionary isKindOfClass:[NSMutableDictionary class]] &&
            [mutableDictionary count] > 0);
}


void YYZSafeSyncMainQueue(void (^ block)(void)) {
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

void YYZSafeAsyncMainQueue(void (^ block)(void)) {
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

double YYZFloor(double num, short scale) {
    NSNumber *numObj = [NSNumber numberWithDouble:num];
    NSDecimalNumber *decimalNumber = [[NSDecimalNumber alloc] initWithDecimal:numObj.decimalValue];
    NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown
                                                                                             scale:scale
                                                                                  raiseOnExactness:NO
                                                                                   raiseOnOverflow:NO
                                                                                  raiseOnUnderflow:NO
                                                                               raiseOnDivideByZero:NO];
    NSDecimalNumber *result = [decimalNumber decimalNumberByRoundingAccordingToBehavior:handler];
    return result.doubleValue;
}



@implementation YYZKitFunctions

@end
