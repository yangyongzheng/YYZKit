
#import "YYZKeyboardMonitor.h"

@implementation YYZKeyboardMonitor

+ (YYZKeyboardMonitor *)defaultMonitor {
    static YYZKeyboardMonitor *monitor  = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        monitor = [[[self class] alloc] init];
    });
    return monitor;
}

- (void)startMonitor {
    
}

+ (void)addDelegate:(id<YYZKeyboardMonitorDelegate>)delegate {
    
}

+ (void)removeDelegate:(id<YYZKeyboardMonitorDelegate>)delegate {
    
}

@end
