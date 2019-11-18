
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (YYZAlert)

- (void)yyz_showAlertController:(UIViewController *)alertController completion:(void (^ _Nullable)(void))completion;

- (void)yyz_showFormSheetController:(UIViewController *)formSheetController completion:(void (^ _Nullable)(void))completion;

@end

NS_ASSUME_NONNULL_END
