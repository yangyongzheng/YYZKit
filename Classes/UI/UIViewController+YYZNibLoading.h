
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (YYZNibLoading)

/**
 从 Storyboard 实例化对象，默认 storyboardName 为`Main`，bundle为`mainBundle`，identifier为类名称
 */
+ (instancetype)yyz_instantiateFromStoryboard;

/**
 根据 storyboardName 实例化对象
 */
+ (instancetype)yyz_instantiateWithStoryboardName:(NSString *)storyboardName;

/**
 根据 storyboardName 及其所在 bundle 实例化对象
 */
+ (instancetype)yyz_instantiateWithStoryboardName:(NSString *)storyboardName
                                           bundle:(NSBundle *)bundle;

/**
 根据 identifier 实例化对象，默认 storyboardName 为`Main`，bundle为`mainBundle`
 */
+ (instancetype)yyz_instantiateWithIdentifier:(NSString *)identifier;

/**
 根据 storyboardName 以及 identifier 实例化对象，bundle为`mainBundle`
 */
+ (instancetype)yyz_instantiateWithStoryboardName:(NSString *)storyboardName
                                       identifier:(NSString *)identifier;

/**
 从 Storyboard 实例化对象

 @param storyboardName Storyboard 名称
 @param identifier Storyboard Id
 @param bundle 所在资源包
 @return UIViewController 对象
 */
+ (instancetype)yyz_instantiateWithStoryboardName:(NSString *)storyboardName
                                       identifier:(NSString *)identifier
                                           bundle:(NSBundle *)bundle;

@end

NS_ASSUME_NONNULL_END
