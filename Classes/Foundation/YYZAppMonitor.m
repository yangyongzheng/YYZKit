
#import "YYZAppMonitor.h"
#import <UIKit/UIKit.h>

@interface YYZAppMonitor ()
@property (nonatomic, strong) NSHashTable *delegateContainer;
@end

@implementation YYZAppMonitor

#pragma mark - Public
+ (YYZAppMonitor *)defaultMonitor {
    static YYZAppMonitor *monitor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        monitor = [[[self class] alloc] init];
        [monitor initDefaultConfig];
    });
    
    return monitor;
}

+ (void)addDelegate:(id<YYZAppMonitorDelegate>)delegate {
    if (delegate) {
        @synchronized (YYZAppMonitor.defaultMonitor.delegateContainer) {
            [YYZAppMonitor.defaultMonitor.delegateContainer addObject:delegate];
        }
    }
}

+ (void)removeDelegate:(id<YYZAppMonitorDelegate>)delegate {
    if (delegate) {
        @synchronized (YYZAppMonitor.defaultMonitor.delegateContainer) {
            [YYZAppMonitor.defaultMonitor.delegateContainer removeObject:delegate];
        }
    }
}

#pragma mark - Private
+ (void)load {
    [super load];
    
    [YYZAppMonitor defaultMonitor];
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)initDefaultConfig {
    self.delegateContainer = [NSHashTable weakObjectsHashTable];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(applicationDidFinishLaunchingNotification:)
                                               name:UIApplicationDidFinishLaunchingNotification
                                             object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(applicationWillTerminateNotification:)
                                               name:UIApplicationWillTerminateNotification
                                             object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(applicationWillEnterForegroundNotification:)
                                               name:UIApplicationWillEnterForegroundNotification
                                             object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(applicationDidEnterBackgroundNotification:)
                                               name:UIApplicationDidEnterBackgroundNotification
                                             object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(applicationDidBecomeActiveNotification:)
                                               name:UIApplicationDidBecomeActiveNotification
                                             object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(applicationWillResignActiveNotification:)
                                               name:UIApplicationWillResignActiveNotification
                                             object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(applicationDidReceiveMemoryWarningNotification:)
                                               name:UIApplicationDidReceiveMemoryWarningNotification
                                             object:nil];
}

#pragma mark - notifications
- (void)applicationDidFinishLaunchingNotification:(NSNotification *)notification {
    NSArray *allDelegates = self.delegateContainer.allObjects; // fix 代理回调方法中调用`removeDelegate:`移除对象崩溃
    for (id <YYZAppMonitorDelegate> delegate in allDelegates) {
        if (delegate && [delegate respondsToSelector:@selector(applicationDidFinishLaunching:)]) {
            [delegate applicationDidFinishLaunching:self];
        }
    }
}

- (void)applicationWillTerminateNotification:(NSNotification *)notification {
    NSArray *allDelegates = self.delegateContainer.allObjects; // fix 代理回调方法中调用`removeDelegate:`移除对象崩溃
    for (id <YYZAppMonitorDelegate> delegate in allDelegates) {
        if (delegate && [delegate respondsToSelector:@selector(applicationWillTerminate:)]) {
            [delegate applicationWillTerminate:self];
        }
    }
}

- (void)applicationWillEnterForegroundNotification:(NSNotification *)notification {
    NSArray *allDelegates = self.delegateContainer.allObjects; // fix 代理回调方法中调用`removeDelegate:`移除对象崩溃
    for (id <YYZAppMonitorDelegate> delegate in allDelegates) {
        if (delegate && [delegate respondsToSelector:@selector(applicationWillEnterForeground:)]) {
            [delegate applicationWillEnterForeground:self];
        }
    }
}

- (void)applicationDidEnterBackgroundNotification:(NSNotification *)notification {
    NSArray *allDelegates = self.delegateContainer.allObjects; // fix 代理回调方法中调用`removeDelegate:`移除对象崩溃
    for (id <YYZAppMonitorDelegate> delegate in allDelegates) {
        if (delegate && [delegate respondsToSelector:@selector(applicationDidEnterBackground:)]) {
            [delegate applicationDidEnterBackground:self];
        }
    }
}

- (void)applicationDidBecomeActiveNotification:(NSNotification *)notification {
    NSArray *allDelegates = self.delegateContainer.allObjects; // fix 代理回调方法中调用`removeDelegate:`移除对象崩溃
    for (id <YYZAppMonitorDelegate> delegate in allDelegates) {
        if (delegate && [delegate respondsToSelector:@selector(applicationDidBecomeActive:)]) {
            [delegate applicationDidBecomeActive:self];
        }
    }
}

- (void)applicationWillResignActiveNotification:(NSNotification *)notification {
    NSArray *allDelegates = self.delegateContainer.allObjects; // fix 代理回调方法中调用`removeDelegate:`移除对象崩溃
    for (id <YYZAppMonitorDelegate> delegate in allDelegates) {
        if (delegate && [delegate respondsToSelector:@selector(applicationWillResignActive:)]) {
            [delegate applicationWillResignActive:self];
        }
    }
}

- (void)applicationDidReceiveMemoryWarningNotification:(NSNotification *)notification {
    NSArray *allDelegates = self.delegateContainer.allObjects; // fix 代理回调方法中调用`removeDelegate:`移除对象崩溃
    for (id <YYZAppMonitorDelegate> delegate in allDelegates) {
        if (delegate && [delegate respondsToSelector:@selector(applicationDidReceiveMemoryWarning:)]) {
            [delegate applicationDidReceiveMemoryWarning:self];
        }
    }
}

@end
