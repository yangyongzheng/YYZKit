//
//  YYZApplicationMonitor.m
//  YYZKit
//
//  Created by Young on 2020/6/18.
//  Copyright © 2020 Young. All rights reserved.
//

#import "YYZApplicationMonitor.h"

#define YYZDefaultApplicationMonitor [YYZApplicationMonitor privateDefaultMonitor]

@interface YYZApplicationMonitor ()
@property (nonatomic, strong) NSHashTable *delegateTable;
@end

@implementation YYZApplicationMonitor

+ (void)load {
    if (self == [YYZApplicationMonitor self]) {
        [YYZDefaultApplicationMonitor setupEnvironment];
    }
}

- (void)dealloc {
    [self stopMonitoring];
}

+ (YYZApplicationMonitor *)privateDefaultMonitor {
    static YYZApplicationMonitor *monitor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        monitor = [[YYZApplicationMonitor alloc] init];
    });
    return monitor;
}

- (instancetype)init {
    if (self = [super init]) {
        self.delegateTable = [NSHashTable weakObjectsHashTable];
        [self startMonitoring];
    }
    return self;
}

- (void)setupEnvironment {
    
}

- (void)startMonitoring {
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

- (void)stopMonitoring {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

#pragma mark - Public
+ (void)addDelegate:(id<YYZApplicationMonitorDelegate>)delegate {
    if (delegate) {
        @synchronized (YYZDefaultApplicationMonitor.delegateTable) {
            [YYZDefaultApplicationMonitor.delegateTable addObject:delegate];
        }
    }
}

+ (void)removeDelegate:(id<YYZApplicationMonitorDelegate>)delegate {
    if (delegate) {
        @synchronized (YYZDefaultApplicationMonitor.delegateTable) {
            [YYZDefaultApplicationMonitor.delegateTable removeObject:delegate];
        }
    }
}

#pragma mark - Notifications
- (void)applicationDidFinishLaunchingNotification:(NSNotification *)notification {
    [self performDelegateSelector:@selector(applicationDidFinishLaunching:)];
}

- (void)applicationWillTerminateNotification:(NSNotification *)notification {
    [self performDelegateSelector:@selector(applicationWillTerminate:)];
}

- (void)applicationWillEnterForegroundNotification:(NSNotification *)notification {
    [self performDelegateSelector:@selector(applicationWillEnterForeground:)];
}

- (void)applicationDidEnterBackgroundNotification:(NSNotification *)notification {
    [self performDelegateSelector:@selector(applicationDidEnterBackground:)];
}

- (void)applicationDidBecomeActiveNotification:(NSNotification *)notification {
    [self performDelegateSelector:@selector(applicationDidBecomeActive:)];
}

- (void)applicationWillResignActiveNotification:(NSNotification *)notification {
    [self performDelegateSelector:@selector(applicationWillResignActive:)];
}

- (void)applicationDidReceiveMemoryWarningNotification:(NSNotification *)notification {
    [self performDelegateSelector:@selector(applicationDidReceiveMemoryWarning:)];
}

- (void)performDelegateSelector:(SEL)aSelector {
    NSArray *delegateArray = self.delegateTable.allObjects;
    for (id delegate in delegateArray) {
        if ([delegate respondsToSelector:aSelector] && [self.delegateTable containsObject:delegate]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [delegate performSelector:aSelector withObject:self];
#pragma clang diagnostic pop
        }
    }
}

@end
