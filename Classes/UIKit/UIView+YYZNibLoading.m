
#import "UIView+YYZNibLoading.h"
#import "YYZAssertNotEmpty.h"

@implementation UIView (YYZNibLoading)

+ (instancetype)yyz_viewFromNib {
    NSString *nibName = NSStringFromClass([self class]);
    return [self yyz_viewWithNibName:nibName];
}

+ (instancetype)yyz_viewWithNibName:(NSString *)nibName {
    return [self yyz_viewWithNibName:nibName
                              bundle:NSBundle.mainBundle];
}

+ (instancetype)yyz_viewWithNibName:(NSString *)nibName
                             bundle:(NSBundle *)bundleOrNil {
    return [self yyz_viewWithNibName:nibName
                              bundle:bundleOrNil
                               index:0];
}

+ (instancetype)yyz_viewWithNibName:(NSString *)nibName
                             bundle:(NSBundle *)bundleOrNil
                              index:(NSInteger)index {
    id findObject = nil;
    
    if (!YYZAssertStringNotEmpty(nibName)) {
        nibName = NSStringFromClass([self class]);
    }
    if (bundleOrNil && [bundleOrNil isKindOfClass:[NSBundle class]]) {} else {
        bundleOrNil = NSBundle.mainBundle;
    }
    UINib *nib = [UINib nibWithNibName:nibName bundle:bundleOrNil];
    NSArray *nibObjects = [nib instantiateWithOwner:nil options:nil];
    if (nibObjects.count > 0) {
        if (index < nibObjects.count) {
            id tempObject = nibObjects[index];
            if ([tempObject isKindOfClass:[self class]]) {
                findObject = tempObject;
            }
        }
        if (!findObject) {
            for (id obj in nibObjects) {
                if ([obj isKindOfClass:[self class]]) {
                    findObject = obj;
                    break;
                }
            }
        }
    }
    
    return findObject;
}

@end
