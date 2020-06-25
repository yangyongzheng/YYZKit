//
//  YYZKeyboardMonitor.m
//  YYZKit
//
//  Created by Young on 2020/6/18.
//  Copyright © 2020 Young. All rights reserved.
//

#import "YYZKeyboardMonitor.h"

@implementation YYZKeyboardInfo

+ (YYZKeyboardInfo *)keyboardInfoWithNotification:(NSNotification *)noti {
    YYZKeyboardInfo *info = [[YYZKeyboardInfo alloc] init];
    info->_keyboardBeginFrame = [noti.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    info->_keyboardEndFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    info->_animationDuration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    return info;
}

@end



#define YYZDefaultKeyboardMonitor [YYZKeyboardMonitor privateDefaultMonitor]

@interface YYZKeyboardMonitor ()
@property (nonatomic, strong) NSHashTable *delegateTable;
@end

@implementation YYZKeyboardMonitor

+ (void)load {
    if (self == [YYZKeyboardMonitor self]) {
        [YYZDefaultKeyboardMonitor setupEnvironment];
    }
}

- (void)dealloc {
    [self stopMonitoring];
}

+ (YYZKeyboardMonitor *)privateDefaultMonitor {
    static YYZKeyboardMonitor *monitor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        monitor = [[YYZKeyboardMonitor alloc] init];
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
                                           selector:@selector(keyboardWillShowNotification:)
                                               name:UIKeyboardWillShowNotification
                                             object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(keyboardDidShowNotification:)
                                               name:UIKeyboardDidShowNotification
                                             object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(keyboardWillHideNotification:)
                                               name:UIKeyboardWillHideNotification
                                             object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(keyboardDidHideNotification:)
                                               name:UIKeyboardDidHideNotification
                                             object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(keyboardWillChangeFrameNotification:)
                                               name:UIKeyboardWillChangeFrameNotification
                                             object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(keyboardDidChangeFrameNotification:)
                                               name:UIKeyboardDidChangeFrameNotification
                                             object:nil];
}

- (void)stopMonitoring {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

#pragma mark - Public
+ (void)addDelegate:(id<YYZKeyboardMonitorDelegate>)delegate {
    if (delegate) {
        @synchronized (YYZDefaultKeyboardMonitor.delegateTable) {
            [YYZDefaultKeyboardMonitor.delegateTable addObject:delegate];
        }
    }
}

+ (void)removeDelegate:(id<YYZKeyboardMonitorDelegate>)delegate {
    if (delegate) {
        @synchronized (YYZDefaultKeyboardMonitor.delegateTable) {
            [YYZDefaultKeyboardMonitor.delegateTable removeObject:delegate];
        }
    }
}

#pragma mark - Notifications
- (void)keyboardWillShowNotification:(NSNotification *)noti {
    [self performDelegateSelector:@selector(keyboardMonitor:willShow:)
                 withKeyboardInfo:[YYZKeyboardInfo keyboardInfoWithNotification:noti]];
}

- (void)keyboardDidShowNotification:(NSNotification *)noti {
    [self performDelegateSelector:@selector(keyboardMonitor:didShow:)
                 withKeyboardInfo:[YYZKeyboardInfo keyboardInfoWithNotification:noti]];
}

- (void)keyboardWillHideNotification:(NSNotification *)noti {
    [self performDelegateSelector:@selector(keyboardMonitor:willHide:)
                 withKeyboardInfo:[YYZKeyboardInfo keyboardInfoWithNotification:noti]];
}

- (void)keyboardDidHideNotification:(NSNotification *)noti {
    [self performDelegateSelector:@selector(keyboardMonitor:didHide:)
                 withKeyboardInfo:[YYZKeyboardInfo keyboardInfoWithNotification:noti]];
}

- (void)keyboardWillChangeFrameNotification:(NSNotification *)noti {
    [self performDelegateSelector:@selector(keyboardMonitor:willChangeFrame:)
                 withKeyboardInfo:[YYZKeyboardInfo keyboardInfoWithNotification:noti]];
}

- (void)keyboardDidChangeFrameNotification:(NSNotification *)noti {
    [self performDelegateSelector:@selector(keyboardMonitor:didChangeFrame:)
                 withKeyboardInfo:[YYZKeyboardInfo keyboardInfoWithNotification:noti]];
}

- (void)performDelegateSelector:(SEL)aSelector withKeyboardInfo:(YYZKeyboardInfo *)keyboardInfo {
    NSArray *allDelegates = self.delegateTable.allObjects;
    for (id <YYZKeyboardMonitorDelegate> delegate in allDelegates) {
        if ([self.delegateTable containsObject:delegate] && [delegate respondsToSelector:aSelector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [delegate performSelector:aSelector withObject:self withObject:keyboardInfo];
#pragma clang diagnostic pop
        }
    }
}

@end
