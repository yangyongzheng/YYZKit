
#ifndef YYZAssertNotEmpty_h
#define YYZAssertNotEmpty_h

#import "YYZKitDefines.h"

YYZKIT_STATIC_INLINE BOOL YYZAssertStringNotEmpty(id string) {
    return string && [string isKindOfClass:[NSString class]] && ((NSString *)string).length > 0;
}

YYZKIT_STATIC_INLINE BOOL YYZAssertArrayNotEmpty(id array) {
    return array && [array isKindOfClass:[NSArray class]] && ((NSArray *)array).count > 0;
}

YYZKIT_STATIC_INLINE BOOL YYZAssertMutableArrayNotEmpty(id mutableArray) {
    return mutableArray && [mutableArray isKindOfClass:[NSMutableArray class]] && ((NSMutableArray *)mutableArray).count > 0;
}

YYZKIT_STATIC_INLINE BOOL YYZAssertDictionaryNotEmpty(id dictionary) {
    return dictionary && [dictionary isKindOfClass:[NSDictionary class]] && ((NSDictionary *)dictionary).count > 0;
}

YYZKIT_STATIC_INLINE BOOL YYZAssertMutableDictionaryNotEmpty(id mutableDictionary) {
    return mutableDictionary && [mutableDictionary isKindOfClass:[NSMutableDictionary class]] && ((NSMutableDictionary *)mutableDictionary).count > 0;
}

#endif /* YYZAssertNotEmpty_h */
