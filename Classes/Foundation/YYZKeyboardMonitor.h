
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class YYZKeyboardMonitor;

@protocol YYZKeyboardMonitorDelegate <NSObject>



@end

@interface YYZKeyboardMonitor : NSObject

/** 获取单例 */
@property (class, nonatomic, readonly, strong) YYZKeyboardMonitor *defaultMonitor;

/** 开始监听，一般在`application:didFinishLaunchingWithOptions:`中调用初始化监听器 */
- (void)startMonitor;

/** 添加代理 */
+ (void)addDelegate:(id <YYZKeyboardMonitorDelegate>)delegate;

/** 移除代理 */
+ (void)removeDelegate:(id <YYZKeyboardMonitorDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
