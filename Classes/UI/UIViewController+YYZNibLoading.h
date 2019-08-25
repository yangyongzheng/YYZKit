
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (YYZNibLoading)

+ (instancetype)yyz_instantiateFromStoryboard;

+ (instancetype)yyz_instantiateWithStoryboardName:(NSString *)storyboardName;

+ (instancetype)yyz_instantiateWithStoryboardName:(NSString *)storyboardName
                                           bundle:(NSBundle *)bundle;

+ (instancetype)yyz_instantiateWithIdentifier:(NSString *)identifier;

+ (instancetype)yyz_instantiateWithStoryboardName:(NSString *)storyboardName
                                       identifier:(NSString *)identifier;

+ (instancetype)yyz_instantiateWithStoryboardName:(NSString *)storyboardName
                                       identifier:(NSString *)identifier
                                           bundle:(NSBundle *)bundle;

@end

NS_ASSUME_NONNULL_END
