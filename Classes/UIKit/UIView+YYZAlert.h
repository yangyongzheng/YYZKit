
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, YYZAlertAnimationType) {
    YYZAlertAnimationTypeNone,  // 无动画
    YYZAlertAnimationTypeFade,  // 淡入淡出
    YYZAlertAnimationTypeSlide, // 显示时从左侧滑入，隐藏时从右侧滑出
};

@interface UIView (YYZAlert)

/**
 显示弹框视图

 @param animation 动画类型
 @param completion 动画完成回调（只有成功显示弹框才会回调）
 @return 是否显示弹框成功，YES-成功 NO-失败
 */
- (BOOL)yyz_showWithAnimation:(YYZAlertAnimationType)animation completion:(void (^ _Nullable)(void))completion;

/**
 隐藏弹框视图

 @param animation 动画类型
 @param completion 动画完成回调（只有成功隐藏弹框才会回调）
 @return 是否隐藏弹框成功，YES-成功 NO-失败
 */
- (BOOL)yyz_hideWithAnimation:(YYZAlertAnimationType)animation completion:(void (^ _Nullable)(void))completion;

@end

NS_ASSUME_NONNULL_END
