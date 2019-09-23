
#import "UIViewController+YYZNibLoading.h"
#import "YYZAssertNotEmpty.h"

@implementation UIViewController (YYZNibLoading)

static NSString * const DefaultStoryboardName = @"Main";

+ (instancetype)yyz_instantiateFromStoryboard {
    return [self yyz_instantiateWithStoryboardName:DefaultStoryboardName];
}

+ (instancetype)yyz_instantiateWithStoryboardName:(NSString *)storyboardName {
    return [self yyz_instantiateWithStoryboardName:storyboardName bundle:NSBundle.mainBundle];
}

+ (instancetype)yyz_instantiateWithStoryboardName:(NSString *)storyboardName
                                           bundle:(NSBundle *)bundle {
    NSString *identifier = NSStringFromClass([self class]);
    return [self yyz_instantiateWithStoryboardName:storyboardName
                                        identifier:identifier
                                            bundle:bundle];
}

+ (instancetype)yyz_instantiateWithIdentifier:(NSString *)identifier {
    return [self yyz_instantiateWithStoryboardName:DefaultStoryboardName identifier:identifier];
}

+ (instancetype)yyz_instantiateWithStoryboardName:(NSString *)storyboardName
                                       identifier:(NSString *)identifier {
    return [self yyz_instantiateWithStoryboardName:storyboardName
                                        identifier:identifier
                                            bundle:NSBundle.mainBundle];
}

+ (instancetype)yyz_instantiateWithStoryboardName:(NSString *)storyboardName
                                       identifier:(NSString *)identifier
                                           bundle:(NSBundle *)bundle {
    if (!YYZAssertStringNotEmpty(storyboardName)) {
        storyboardName = DefaultStoryboardName;
    }
    if (!YYZAssertStringNotEmpty(identifier)) {
        identifier = NSStringFromClass([self class]);
    }
    if (bundle && [bundle isKindOfClass:[NSBundle class]]) {} else {
        bundle = NSBundle.mainBundle;
    }
    UIStoryboard *sb = [UIStoryboard storyboardWithName:storyboardName bundle:bundle];
    return [sb instantiateViewControllerWithIdentifier:identifier];
}

@end
