
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define YYZ_SCREEN_WIDTH            [YYZDevice mainScreenWidth]
#define YYZ_SCREEN_HEIGHT           [YYZDevice mainScreenHeight]
#define YYZ_STATUSBAR_HEIGHT        [YYZDevice statusBarHeight]
#define YYZ_NAVIGATIONBAR_HEIGHT    [YYZDevice navigationBarHeight]
#define YYZ_TABBAR_HEIGHT           [YYZDevice tabBarHeight]
#define YYZ_SAFE_AREA_INSET_TOP     (YYZ_STATUSBAR_HEIGHT + YYZ_NAVIGATIONBAR_HEIGHT)
#define YYZ_SAFE_AREA_INSET_BOTTOM  [YYZDevice safeAreaBottomInset]

@interface YYZDevice : NSObject

/** 编译时间，单位秒 */
@property (class, nonatomic, readonly) int64_t compileTimestamp;

+ (CGFloat)mainScreenWidth;
+ (CGFloat)mainScreenHeight;
+ (CGFloat)statusBarHeight;
+ (CGFloat)navigationBarHeight; // 始终返回 44
+ (CGFloat)tabBarHeight;        // 始终返回 49
+ (CGFloat)safeAreaBottomInset;

@end

NS_ASSUME_NONNULL_END
