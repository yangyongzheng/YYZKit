
#import "YYZTimerHolder.h"
#import <objc/runtime.h>

@interface NSTimer (YYZPrivateTimerHolder)

+ (NSTimer *)yyz_privateScheduledTimerWithIntervalMilliseconds:(long)intervalMilliseconds
                                                       repeats:(BOOL)repeats
                                                          mode:(NSRunLoopMode)mode
                                                         block:(void(^)(void))block;

@end

@implementation NSTimer (YYZPrivateTimerHolder)

+ (NSTimer *)yyz_privateScheduledTimerWithIntervalMilliseconds:(long)intervalMilliseconds
                                                       repeats:(BOOL)repeats
                                                          mode:(NSRunLoopMode)mode
                                                         block:(void (^)(void))block {
    NSTimeInterval interval = 0.001;
    if (intervalMilliseconds > 0) {
        interval = (NSTimeInterval)intervalMilliseconds / 1000.0;
    }
    NSTimer *timer = [NSTimer timerWithTimeInterval:interval
                                             target:self
                                           selector:@selector(yyz_privateTimerTriggerCallback:)
                                           userInfo:block?[block copy]:nil
                                            repeats:repeats];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:mode?:NSRunLoopCommonModes];
    
    return timer;
}

+ (void)yyz_privateTimerTriggerCallback:(NSTimer *)timer {
    if (timer.userInfo) {
        void (^ block)(void) = timer.userInfo;
        block();
    } else {
        [timer invalidate];
    }
}

@end



@interface YYZTimerHolder ()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic) long countdownMilliseconds;
@end

@implementation YYZTimerHolder

- (void)dealloc {
    [self invalidate];
}

#pragma mark - Public
- (void)scheduledTimerWithTimeInterval:(long)intervalMilliseconds
                               repeats:(BOOL)repeats
                                 block:(YYZTimerHolderBlock)block {
    [self scheduledTimerWithTimeInterval:intervalMilliseconds
                                 repeats:repeats
                                    mode:NSRunLoopCommonModes
                                   block:block];
}

- (void)scheduledTimerWithTimeInterval:(long)intervalMilliseconds
                               repeats:(BOOL)repeats
                                  mode:(NSRunLoopMode)mode
                                 block:(YYZTimerHolderBlock)block {
    // 1.重置
    [self invalidate];
    // 2.入参检测
    if (intervalMilliseconds <= 0) {intervalMilliseconds = 1;}
    if (block) {
        // 3.实例化定时器
        __weak typeof(self) weakSelf = self;
        self.timer = [NSTimer yyz_privateScheduledTimerWithIntervalMilliseconds:intervalMilliseconds
                                                                        repeats:repeats
                                                                           mode:mode
                                                                          block:^{
                                                                              __strong typeof(weakSelf) strongSelf = weakSelf;
                                                                              if (strongSelf) {
                                                                                  block(strongSelf);
                                                                                  if (!repeats) {
                                                                                      [strongSelf invalidate];
                                                                                  }
                                                                              }
                                                                          }];
    }
}

- (void)scheduledTimerWithCountdown:(long)countdownMilliseconds
               intervalMilliseconds:(long)intervalMilliseconds
                              block:(YYZTimerHolderCountdownBlock)block {
    [self scheduledTimerWithCountdown:countdownMilliseconds
                 intervalMilliseconds:intervalMilliseconds
                                 mode:NSRunLoopCommonModes
                                block:block];
}

- (void)scheduledTimerWithCountdown:(long)countdownMilliseconds
               intervalMilliseconds:(long)intervalMilliseconds
                               mode:(NSRunLoopMode)mode
                              block:(YYZTimerHolderCountdownBlock)block {
    // 1.重置
    [self invalidate];
    self.countdownMilliseconds = countdownMilliseconds;
    // 2.入参检测
    if (intervalMilliseconds <= 0) {intervalMilliseconds = 1;}
    if (block && countdownMilliseconds >= intervalMilliseconds) {
        // 3.实例化定时器
        __weak typeof(self) weakSelf = self;
        self.timer = [NSTimer yyz_privateScheduledTimerWithIntervalMilliseconds:intervalMilliseconds
                                                                        repeats:YES
                                                                           mode:mode
                                                                          block:^{
                                                                              __strong typeof(weakSelf) strongSelf = weakSelf;
                                                                              if (strongSelf) {
                                                                                  strongSelf.countdownMilliseconds -= intervalMilliseconds;
                                                                                  if (strongSelf.countdownMilliseconds <= 0) {
                                                                                      strongSelf.countdownMilliseconds = 0;
                                                                                      [strongSelf invalidate];
                                                                                  }
                                                                                  block(strongSelf, strongSelf.countdownMilliseconds);
                                                                              }
                                                                          }];
    }
}

- (void)fire {
    if (self.timer) {
        [self.timer fire];
    }
}

- (void)invalidate {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (BOOL)isValid {
    return self.timer.isValid;
}

@end
