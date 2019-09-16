
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (YYZAdditions)

@property (class, nonatomic, readonly) CGFloat yyz_screenWidth;
@property (class, nonatomic, readonly) CGFloat yyz_screenHeight;
@property (class, nonatomic, readonly) CGFloat yyz_statusBarHeight;
@property (class, nonatomic, readonly) CGFloat yyz_navigationBarHeight;
@property (class, nonatomic, readonly) CGFloat yyz_tabBarHeight;
@property (class, nonatomic, readonly) CGFloat yyz_safeAreaBottomInset;

@property (class, nonatomic, readonly) int64_t yyz_compileTimestamp;

@end

NS_ASSUME_NONNULL_END
