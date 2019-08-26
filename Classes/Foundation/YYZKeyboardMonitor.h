
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYZKeyboardInfo : NSObject
@property (nonatomic, readonly) CGRect beginFrame;
@property (nonatomic, readonly) CGRect endFrame;
@property (nonatomic, readonly) double animationDuration;
@end



@class YYZKeyboardMonitor;

@protocol YYZKeyboardMonitorDelegate <NSObject>

@optional
- (void)keyboardMonitor:(YYZKeyboardMonitor *)keyboardMonitor
       keyboardWillShow:(YYZKeyboardInfo *)info;

- (void)keyboardMonitor:(YYZKeyboardMonitor *)keyboardMonitor
        keyboardDidShow:(YYZKeyboardInfo *)info;

- (void)keyboardMonitor:(YYZKeyboardMonitor *)keyboardMonitor
       keyboardWillHide:(YYZKeyboardInfo *)info;

- (void)keyboardMonitor:(YYZKeyboardMonitor *)keyboardMonitor
        keyboardDidHide:(YYZKeyboardInfo *)info;

- (void)keyboardMonitor:(YYZKeyboardMonitor *)keyboardMonitor
keyboardWillChangeFrame:(YYZKeyboardInfo *)info;

- (void)keyboardMonitor:(YYZKeyboardMonitor *)keyboardMonitor
 keyboardDidChangeFrame:(YYZKeyboardInfo *)info;

@end

@interface YYZKeyboardMonitor : NSObject

/** 添加代理 */
+ (void)addDelegate:(id <YYZKeyboardMonitorDelegate>)delegate;

/** 移除代理 */
+ (void)removeDelegate:(id <YYZKeyboardMonitorDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
