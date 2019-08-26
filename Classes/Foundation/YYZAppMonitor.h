
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class YYZAppMonitor;

@protocol YYZAppMonitorDelegate <NSObject>

@optional
- (void)applicationDidFinishLaunching:(YYZAppMonitor *)appMonitor;
- (void)applicationWillTerminate:(YYZAppMonitor *)appMonitor;
- (void)applicationWillEnterForeground:(YYZAppMonitor *)appMonitor;
- (void)applicationDidEnterBackground:(YYZAppMonitor *)appMonitor;
- (void)applicationDidBecomeActive:(YYZAppMonitor *)appMonitor;
- (void)applicationWillResignActive:(YYZAppMonitor *)appMonitor;
- (void)applicationDidReceiveMemoryWarning:(YYZAppMonitor *)appMonitor;

@end

@interface YYZAppMonitor : NSObject

/** 添加代理 */
+ (void)addDelegate:(id <YYZAppMonitorDelegate>)delegate;

/** 移除代理 */
+ (void)removeDelegate:(id <YYZAppMonitorDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
