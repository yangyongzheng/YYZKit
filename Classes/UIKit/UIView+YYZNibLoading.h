
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (YYZNibLoading)

/**
 从 Xib 实例化 UIView，默认 Xib 名称为类名，bundle 为 mainBundle
 */
+ (nullable instancetype)yyz_viewFromNib;

/**
 从 Xib 实例化 UIView

 @param nibName Xib 文件名
 */
+ (nullable instancetype)yyz_viewWithNibName:(NSString *)nibName;

/**
 从 Xib 实例化 UIView

 @param nibName Xib 文件名
 @param bundleOrNil 所在资源包，nil 时 默认为 mainBundle
 */
+ (nullable instancetype)yyz_viewWithNibName:(NSString *)nibName
                                      bundle:(nullable NSBundle *)bundleOrNil;

/**
 从 Xib 实例化 UIView

 @param nibName Xib 文件名
 @param bundleOrNil 所在资源包，nil 时 默认为 mainBundle
 @param index Xib 序列化后数组中对象下标
 */
+ (nullable instancetype)yyz_viewWithNibName:(NSString *)nibName
                                      bundle:(nullable NSBundle *)bundleOrNil
                                       index:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
