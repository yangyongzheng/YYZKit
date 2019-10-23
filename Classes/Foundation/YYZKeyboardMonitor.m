
#import "YYZKeyboardMonitor.h"

@implementation YYZKeyboardInfo

+ (YYZKeyboardInfo *)keyboardInfoWithNotification:(NSNotification *)noti {
    YYZKeyboardInfo *info = [[YYZKeyboardInfo alloc] init];
    info->_beginFrame = [noti.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    info->_endFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    info->_animationDuration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    return info;
}

@end



@interface YYZKeyboardMonitor ()
@property (nonatomic, strong) NSHashTable *delegateContainer;
@end

@implementation YYZKeyboardMonitor

+ (YYZKeyboardMonitor *)defaultMonitor {
    static YYZKeyboardMonitor *monitor  = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        monitor = [[YYZKeyboardMonitor alloc] init];
        [monitor initDefaultConfig];
    });
    return monitor;
}

+ (void)addDelegate:(id<YYZKeyboardMonitorDelegate>)delegate {
    if (delegate) {
        @synchronized (YYZKeyboardMonitor.defaultMonitor.delegateContainer) {
            [YYZKeyboardMonitor.defaultMonitor.delegateContainer addObject:delegate];
        }
    }
}

+ (void)removeDelegate:(id<YYZKeyboardMonitorDelegate>)delegate {
    if (delegate) {
        @synchronized (YYZKeyboardMonitor.defaultMonitor.delegateContainer) {
            [YYZKeyboardMonitor.defaultMonitor.delegateContainer removeObject:delegate];
        }
    }
}

#pragma mark - Private
+ (void)load {
    [YYZKeyboardMonitor defaultMonitor];
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)initDefaultConfig {
    self.delegateContainer = [NSHashTable weakObjectsHashTable];
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

- (void)keyboardWillShowNotification:(NSNotification *)noti {
    NSArray *delegateArray = self.delegateContainer.allObjects;
    for (id <YYZKeyboardMonitorDelegate> delegate in delegateArray) {
        if ([self.delegateContainer containsObject:delegate] && [delegate respondsToSelector:@selector(keyboardMonitor:keyboardWillShow:)]) {
            [delegate keyboardMonitor:self
                     keyboardWillShow:[YYZKeyboardInfo keyboardInfoWithNotification:noti]];
        }
    }
}

- (void)keyboardDidShowNotification:(NSNotification *)noti {
    NSArray *delegateArray = self.delegateContainer.allObjects;
    for (id <YYZKeyboardMonitorDelegate> delegate in delegateArray) {
        if ([self.delegateContainer containsObject:delegate] && [delegate respondsToSelector:@selector(keyboardMonitor:keyboardDidShow:)]) {
            [delegate keyboardMonitor:self
                      keyboardDidShow:[YYZKeyboardInfo keyboardInfoWithNotification:noti]];
        }
    }
}

- (void)keyboardWillHideNotification:(NSNotification *)noti {
    NSArray *delegateArray = self.delegateContainer.allObjects;
    for (id <YYZKeyboardMonitorDelegate> delegate in delegateArray) {
        if ([self.delegateContainer containsObject:delegate] && [delegate respondsToSelector:@selector(keyboardMonitor:keyboardWillHide:)]) {
            [delegate keyboardMonitor:self
                     keyboardWillHide:[YYZKeyboardInfo keyboardInfoWithNotification:noti]];
        }
    }
}

- (void)keyboardDidHideNotification:(NSNotification *)noti {
    NSArray *delegateArray = self.delegateContainer.allObjects;
    for (id <YYZKeyboardMonitorDelegate> delegate in delegateArray) {
        if ([self.delegateContainer containsObject:delegate] && [delegate respondsToSelector:@selector(keyboardMonitor:keyboardDidHide:)]) {
            [delegate keyboardMonitor:self
                      keyboardDidHide:[YYZKeyboardInfo keyboardInfoWithNotification:noti]];
        }
    }
}

- (void)keyboardWillChangeFrameNotification:(NSNotification *)noti {
    NSArray *delegateArray = self.delegateContainer.allObjects;
    for (id <YYZKeyboardMonitorDelegate> delegate in delegateArray) {
        if ([self.delegateContainer containsObject:delegate] && [delegate respondsToSelector:@selector(keyboardMonitor:keyboardWillChangeFrame:)]) {
            [delegate keyboardMonitor:self
              keyboardWillChangeFrame:[YYZKeyboardInfo keyboardInfoWithNotification:noti]];
        }
    }
}

- (void)keyboardDidChangeFrameNotification:(NSNotification *)noti {
    NSArray *delegateArray = self.delegateContainer.allObjects;
    for (id <YYZKeyboardMonitorDelegate> delegate in delegateArray) {
        if ([self.delegateContainer containsObject:delegate] && [delegate respondsToSelector:@selector(keyboardMonitor:keyboardDidChangeFrame:)]) {
            [delegate keyboardMonitor:self
               keyboardDidChangeFrame:[YYZKeyboardInfo keyboardInfoWithNotification:noti]];
        }
    }
}

@end
