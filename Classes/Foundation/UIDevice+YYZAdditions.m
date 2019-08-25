
#import "UIDevice+YYZAdditions.h"

@implementation UIDevice (YYZAdditions)

- (CGFloat)yyz_statusBarHeight {
    return UIApplication.sharedApplication.statusBarFrame.size.height;
}

- (CGFloat)yyz_screenWidth {
    return UIScreen.mainScreen.bounds.size.width;
}

- (CGFloat)yyz_screenHeight {
    return UIScreen.mainScreen.bounds.size.height;
}

- (CGFloat)yyz_navigationBarHeight {
    return 44;
}

- (CGFloat)yyz_tabBarHeight {
    return 49;
}

- (CGFloat)yyz_safeAreaBottomInset {
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

- (int64_t)yyz_compileTimestamp {
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

@end
