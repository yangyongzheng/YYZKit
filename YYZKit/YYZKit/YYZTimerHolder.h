//
//  YYZTimerHolder.h
//  YYZKit
//
//  Created by Young on 2020/6/18.
//  Copyright © 2020 Young. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYZTimerHolder : NSObject

/// 常规定时器
/// @param interval 间隔时间，单位秒，当 <= 0 时，使用默认值0.0001s
/// @param repeats 是否重复触发定时器
/// @param block 定时器触发回调
- (void)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                               repeats:(BOOL)repeats
                                 block:(void (^)(YYZTimerHolder *timerHolder))block;

/// 常规定时器
/// @param interval 间隔时间，单位秒，当 <= 0 时，使用默认值0.0001s
/// @param repeats 是否重复触发定时器
/// @param mode 模式，默认 NSRunLoopCommonModes
/// @param block 定时器触发回调
- (void)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                               repeats:(BOOL)repeats
                                  mode:(NSRunLoopMode)mode
                                 block:(void (^)(YYZTimerHolder *timerHolder))block;

/// 倒计时定时器
/// @param countdown 倒计时，单位秒
/// @param interval 间隔时间，单位秒
/// @param block 定时器触发回调
- (void)scheduledTimerWithCountdown:(NSTimeInterval)countdown
                           interval:(NSTimeInterval)interval
                              block:(void (^)(YYZTimerHolder *timerHolder, NSTimeInterval timeRemaining))block;

/// 倒计时定时器
/// @param countdown 倒计时，单位秒
/// @param interval 间隔时间，单位秒
/// @param mode 模式，默认 NSRunLoopCommonModes
/// @param block 定时器触发回调
- (void)scheduledTimerWithCountdown:(NSTimeInterval)countdown
                           interval:(NSTimeInterval)interval
                               mode:(NSRunLoopMode)mode
                              block:(void (^)(YYZTimerHolder *timerHolder, NSTimeInterval timeRemaining))block;

/// 立即触发一次定时器
- (void)fireTimer;

/// 停止定时器
- (void)invalidateTimer;

/// 定时器是否有效
@property (readonly) BOOL isValid;

@end

NS_ASSUME_NONNULL_END
