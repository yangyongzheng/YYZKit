
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (YYZAdditions)

- (CGFloat)yyz_screenWidth;
- (CGFloat)yyz_screenHeight;
- (CGFloat)yyz_statusBarHeight;
- (CGFloat)yyz_navigationBarHeight;
- (CGFloat)yyz_tabBarHeight;
- (CGFloat)yyz_safeAreaBottomInset;

- (int64_t)yyz_compileTimestamp;

@end

NS_ASSUME_NONNULL_END
