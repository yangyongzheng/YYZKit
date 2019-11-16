
#import "YYZDevice.h"

@implementation YYZDevice

+ (int64_t)compileTimestamp {
    static int64_t timestamp = 0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *timeString = [NSString stringWithFormat:@"%s %s", __DATE__, __TIME__];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM dd yyyy HH:mm:ss"];
        [formatter setLocale:locale];
        timestamp = (int64_t)[[formatter dateFromString:timeString] timeIntervalSince1970];
    });
    
    return timestamp;
}

+ (CGFloat)mainScreenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)mainScreenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)statusBarHeight {
    return [UIApplication sharedApplication].statusBarFrame.size.height;
}

+ (CGFloat)navigationBarHeight {
    return 44.0;
}

+ (CGFloat)tabBarHeight {
    return 49.0;
}

+ (CGFloat)safeAreaBottomInset {
    static CGFloat bottomInset = 0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 11.0, *)) {
            UIWindow *window = UIApplication.sharedApplication.delegate.window;
            if (!window) {
                window = UIApplication.sharedApplication.windows.firstObject;
            }
            bottomInset = window.safeAreaInsets.bottom;
        }
    });
    
    return bottomInset;
}

@end
