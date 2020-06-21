//
//  YYZApplicationMonitor.h
//  YYZKit
//
//  Created by Young on 2020/6/18.
//  Copyright © 2020 Young. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YYZApplicationMonitor;

@protocol YYZApplicationMonitorDelegate <NSObject>

@optional
- (void)applicationDidFinishLaunching:(YYZApplicationMonitor *)monitor;
- (void)applicationWillTerminate:(YYZApplicationMonitor *)monitor;
- (void)applicationWillEnterForeground:(YYZApplicationMonitor *)monitor;
- (void)applicationDidEnterBackground:(YYZApplicationMonitor *)monitor;
- (void)applicationDidBecomeActive:(YYZApplicationMonitor *)monitor;
- (void)applicationWillResignActive:(YYZApplicationMonitor *)monitor;
- (void)applicationDidReceiveMemoryWarning:(YYZApplicationMonitor *)monitor;

@end

@interface YYZApplicationMonitor : NSObject

/// 添加代理
+ (void)addDelegate:(id<YYZApplicationMonitorDelegate>)delegate;

/// 移除代理
+ (void)removeDelegate:(id<YYZApplicationMonitorDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
