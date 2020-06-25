//
//  YYZKeyboardMonitor.h
//  YYZKit
//
//  Created by Young on 2020/6/18.
//  Copyright © 2020 Young. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYZKeyboardInfo : NSObject
@property (nonatomic, readonly) CGRect keyboardBeginFrame;
@property (nonatomic, readonly) CGRect keyboardEndFrame;
@property (nonatomic, readonly) double animationDuration;
@end

@class YYZKeyboardMonitor;

@protocol YYZKeyboardMonitorDelegate <NSObject>

@optional
- (void)keyboardMonitor:(YYZKeyboardMonitor *)keyboardMonitor willShow:(YYZKeyboardInfo *)info;
- (void)keyboardMonitor:(YYZKeyboardMonitor *)keyboardMonitor didShow:(YYZKeyboardInfo *)info;

- (void)keyboardMonitor:(YYZKeyboardMonitor *)keyboardMonitor willHide:(YYZKeyboardInfo *)info;
- (void)keyboardMonitor:(YYZKeyboardMonitor *)keyboardMonitor didHide:(YYZKeyboardInfo *)info;

- (void)keyboardMonitor:(YYZKeyboardMonitor *)keyboardMonitor willChangeFrame:(YYZKeyboardInfo *)info;
- (void)keyboardMonitor:(YYZKeyboardMonitor *)keyboardMonitor didChangeFrame:(YYZKeyboardInfo *)info;

@end

@interface YYZKeyboardMonitor : NSObject

/// 添加代理
+ (void)addDelegate:(id<YYZKeyboardMonitorDelegate>)delegate;

/// 移除代理
+ (void)removeDelegate:(id<YYZKeyboardMonitorDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
