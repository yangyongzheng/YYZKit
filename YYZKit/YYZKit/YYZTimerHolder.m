//
//  YYZTimerHolder.m
//  YYZKit
//
//  Created by Young on 2020/6/18.
//  Copyright © 2020 Young. All rights reserved.
//

#import "YYZTimerHolder.h"

@interface YYZKitPrivateTimerTarget : NSObject

@end

@implementation YYZKitPrivateTimerTarget

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                    repeats:(BOOL)repeats
                                       mode:(NSRunLoopMode)mode
                                      block:(void (^)(NSTimer *timer))block {
    if (interval <= 0) {
        interval = 0.0001;
    }
    NSTimer *timer = [NSTimer timerWithTimeInterval:interval
                                             target:self
                                           selector:@selector(timerDidFireCallback:)
                                           userInfo:block ? [block copy] : nil
                                            repeats:repeats];
    [NSRunLoop.currentRunLoop addTimer:timer forMode:mode?:NSRunLoopCommonModes];
    return timer;
}

+ (void)timerDidFireCallback:(NSTimer *)timer {
    void (^ block)(NSTimer *) = timer.userInfo;
    if (block) {
        block(timer);
    } else {
        [timer invalidate];
    }
}

@end



@interface YYZTimerHolder ()
@property (nonatomic, strong) NSTimer *currentTimer;
@property (nonatomic) NSTimeInterval timeRemaining;
@end

@implementation YYZTimerHolder

- (void)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                               repeats:(BOOL)repeats
                                 block:(void (^)(YYZTimerHolder * _Nonnull))block {
    [self scheduledTimerWithTimeInterval:interval
                                 repeats:repeats
                                    mode:NSRunLoopCommonModes
                                   block:block];
}

- (void)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                               repeats:(BOOL)repeats
                                  mode:(NSRunLoopMode)mode
                                 block:(void (^)(YYZTimerHolder * _Nonnull))block {
    [self invalidateTimer];
    if (interval <= 0) {interval = 0.0001;}
    if (block) {
        __weak typeof(self) weakSelf = self;
        self.currentTimer = [YYZKitPrivateTimerTarget scheduledTimerWithTimeInterval:interval
                                                                             repeats:repeats
                                                                                mode:mode
                                                                               block:^(NSTimer *timer) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (strongSelf) {
                block(strongSelf);
                if (!repeats) {
                    [strongSelf invalidateTimer];
                }
            }
        }];
    }
}

- (void)scheduledTimerWithCountdown:(NSTimeInterval)countdown
                           interval:(NSTimeInterval)interval
                              block:(void (^)(YYZTimerHolder * _Nonnull, NSTimeInterval))block {
    [self scheduledTimerWithCountdown:countdown
                             interval:interval
                                 mode:NSRunLoopCommonModes
                                block:block];
}

- (void)scheduledTimerWithCountdown:(NSTimeInterval)countdown
                           interval:(NSTimeInterval)interval
                               mode:(NSRunLoopMode)mode
                              block:(void (^)(YYZTimerHolder * _Nonnull, NSTimeInterval))block {
    [self invalidateTimer];
    self.timeRemaining = countdown;
    if (interval <= 0) {interval = 0.0001;}
    if (block && interval <= countdown) {
        __weak typeof(self) weakSelf = self;
        self.currentTimer = [YYZKitPrivateTimerTarget scheduledTimerWithTimeInterval:interval
                                                                             repeats:YES
                                                                                mode:mode
                                                                               block:^(NSTimer *timer) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (strongSelf) {
                strongSelf.timeRemaining -= interval;
                if (strongSelf.timeRemaining <= 0) {
                    strongSelf.timeRemaining = 0;
                    [strongSelf invalidateTimer];
                }
                block(strongSelf, strongSelf.timeRemaining);
            }
        }];
    }
}

- (void)fireTimer {
    if (self.currentTimer) {
        [self.currentTimer fire];
    }
}

- (void)invalidateTimer {
    if (self.currentTimer) {
        [self.currentTimer invalidate];
        self.currentTimer = nil;
    }
}

- (BOOL)isValid {
    return self.currentTimer ? self.currentTimer.isValid : NO;
}

- (void)dealloc {
    [self invalidateTimer];
}

@end
