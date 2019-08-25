
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class YYZTimerHolder;

typedef void(^YYZTimerHolderBlock)(YYZTimerHolder *timerHolder);
typedef void(^YYZTimerHolderCountdownBlock)(YYZTimerHolder *timerHolder, long currentMilliseconds);

@interface YYZTimerHolder : NSObject

/**
 开启定时器
 
 @param intervalMilliseconds 触发间隔时间，单位毫秒。当 <= 0 时，设置默认值1ms
 @param repeats 是否重复定时器
 @param block 定时器触发回调Block
 */
- (void)scheduledTimerWithTimeInterval:(long)intervalMilliseconds
                               repeats:(BOOL)repeats
                                 block:(YYZTimerHolderBlock)block;

/**
 开启定时器
 
 @param intervalMilliseconds 触发间隔时间，单位毫秒。当 <= 0 时，设置默认值1ms
 @param repeats 是否重复定时器
 @param mode 运行循环模式，默认`NSRunLoopCommonModes`
 @param block 定时器触发回调Block
 */
- (void)scheduledTimerWithTimeInterval:(long)intervalMilliseconds
                               repeats:(BOOL)repeats
                                  mode:(NSRunLoopMode)mode
                                 block:(YYZTimerHolderBlock)block;

/**
 开启倒计时定时器，注意入参 countdownMillisecond >= intervalMillisecond 才会生效
 
 @param countdownMilliseconds 倒计时长，单位毫秒
 @param intervalMillisecond 触发间隔时间，单位毫秒。当 <= 0 时，设置默认值1ms
 @param block 定时器触发回调Block
 */
- (void)scheduledTimerWithCountdown:(long)countdownMilliseconds
               intervalMilliseconds:(long)intervalMillisecond
                              block:(YYZTimerHolderCountdownBlock)block;

/**
 开启倒计时定时器，注意入参 countdownMillisecond >= intervalMillisecond 才会生效
 
 @param countdownMilliseconds 倒计时长，单位毫秒
 @param intervalMilliseconds 触发间隔时间，单位毫秒。当 <= 0 时，设置默认值1ms
 @param mode 运行循环模式，默认`NSRunLoopCommonModes`
 @param block 定时器触发回调Block
 */
- (void)scheduledTimerWithCountdown:(long)countdownMilliseconds
               intervalMilliseconds:(long)intervalMilliseconds
                               mode:(NSRunLoopMode)mode
                              block:(YYZTimerHolderCountdownBlock)block;

/** 立即触发一次定时器 */
- (void)fire;

/** 销毁定时器 */
- (void)invalidate;

/** 获取定时器是否有效 */
@property (readonly, getter=isValid) BOOL valid;

@end

NS_ASSUME_NONNULL_END
