
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, YYZAlertAnimationType) {
    YYZAlertAnimationTypeNone,  // 无动画
    YYZAlertAnimationTypeFade,  // 淡入淡出
    YYZAlertAnimationTypeSlide, // 显示时从左侧滑入，隐藏时从右侧滑出
};

@interface YYZAlertManager : NSObject

+ (BOOL)isAlertingView;

+ (BOOL)showWithCustomView:(UIView *)customView
             animationType:(YYZAlertAnimationType)animationType
                completion:(void(^)(void))completion;

+ (void)hideWithAnimationType:(YYZAlertAnimationType)animationType
                   completion:(void(^)(void))completion;

@end

NS_ASSUME_NONNULL_END
