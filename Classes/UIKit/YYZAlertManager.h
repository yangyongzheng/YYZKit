
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYZAlertManager : NSObject

+ (void)showAlertController:(UIViewController *)alertController
       presentingController:(UIViewController *)presentingController
                 completion:(void (^ _Nullable)(void))completion;

+ (void)showFormSheetController:(UIViewController *)formSheetController
           presentingController:(UIViewController *)presentingController
                     completion:(void (^ _Nullable)(void))completion;

+ (void)dismissViewController:(UIViewController *)viewController
                     animated:(BOOL)animated
                   completion:(void (^ _Nullable)(void))completion;

@end

NS_ASSUME_NONNULL_END
