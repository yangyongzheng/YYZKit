
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (YYZNibLoading)

+ (nullable instancetype)yyz_viewFromNib;

+ (nullable instancetype)yyz_viewWithNibName:(NSString *)nibName;

+ (nullable instancetype)yyz_viewWithNibName:(NSString *)nibName
                                      bundle:(nullable NSBundle *)bundleOrNil;

+ (nullable instancetype)yyz_viewWithNibName:(NSString *)nibName
                                      bundle:(nullable NSBundle *)bundleOrNil
                                       index:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
