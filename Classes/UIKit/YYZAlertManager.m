
#import "YYZAlertManager.h"
#import <objc/runtime.h>

typedef NS_ENUM(NSInteger, YYZPrivateAlertStyle) {
    YYZPrivateAlertStyleAlert = 0,
    YYZPrivateAlertStyleFormSheet,
};


@interface YYZPrivateViewControllerAnimatedTransitionProvider : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) BOOL yyz_privateIsPresentAnimation;
@end


@interface YYZPrivateViewControllerTransitionProvider : NSObject <UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) YYZPrivateViewControllerAnimatedTransitionProvider *yyz_privateAnimatedTransitionProvider;
@end


@interface UIViewController (YYZPrivateAlert)
@property (nonatomic) YYZPrivateAlertStyle yyz_privateAlertStyle;
@property (nonatomic, strong) YYZPrivateViewControllerTransitionProvider *yyz_privateTransitionProvider;
@end



@implementation YYZAlertManager

#pragma mark -  Public
+ (void)showAlertController:(UIViewController *)alertController
       presentingController:(UIViewController *)presentingController
                 completion:(void (^)(void))completion {
    alertController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    alertController.modalPresentationStyle = UIModalPresentationCustom;
    alertController.yyz_privateAlertStyle = YYZPrivateAlertStyleAlert;
    presentingController.yyz_privateTransitionProvider = [[YYZPrivateViewControllerTransitionProvider alloc] init];
    alertController.transitioningDelegate = presentingController.yyz_privateTransitionProvider;
    [presentingController presentViewController:alertController animated:YES completion:completion];
}

+ (void)showFormSheetController:(UIViewController *)formSheetController
           presentingController:(UIViewController *)presentingController
                     completion:(void (^)(void))completion {
    formSheetController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    formSheetController.modalPresentationStyle = UIModalPresentationCustom;
    formSheetController.yyz_privateAlertStyle = YYZPrivateAlertStyleFormSheet;
    presentingController.yyz_privateTransitionProvider = [[YYZPrivateViewControllerTransitionProvider alloc] init];
    formSheetController.transitioningDelegate = presentingController.yyz_privateTransitionProvider;
    [presentingController presentViewController:formSheetController animated:YES completion:completion];
}

+ (void)dismissViewController:(UIViewController *)viewController
                     animated:(BOOL)animated
                   completion:(void (^)(void))completion {
    [viewController dismissViewControllerAnimated:animated completion:completion];
}

@end



@implementation UIViewController (YYZPrivateAlert)

- (void)setYyz_privateAlertStyle:(YYZPrivateAlertStyle)yyz_privateAlertStyle {
    NSNumber *styleNumber = [NSNumber numberWithInteger:yyz_privateAlertStyle];
    objc_setAssociatedObject(self, @selector(yyz_privateAlertStyle), styleNumber, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (YYZPrivateAlertStyle)yyz_privateAlertStyle {
    id styleNumber = objc_getAssociatedObject(self, _cmd);
    return styleNumber ? [styleNumber integerValue] : YYZPrivateAlertStyleAlert;
}

- (void)setYyz_privateTransitionProvider:(YYZPrivateViewControllerTransitionProvider *)yyz_privateTransitionProvider {
    objc_setAssociatedObject(self, @selector(yyz_privateTransitionProvider), yyz_privateTransitionProvider, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (YYZPrivateViewControllerTransitionProvider *)yyz_privateTransitionProvider {
    return objc_getAssociatedObject(self, _cmd);
}

@end



@implementation YYZPrivateViewControllerTransitionProvider

#pragma mark -  UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    self.yyz_privateAnimatedTransitionProvider.yyz_privateIsPresentAnimation = YES;
    return self.yyz_privateAnimatedTransitionProvider;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.yyz_privateAnimatedTransitionProvider.yyz_privateIsPresentAnimation = NO;
    return self.yyz_privateAnimatedTransitionProvider;
}

- (YYZPrivateViewControllerAnimatedTransitionProvider *)yyz_privateAnimatedTransitionProvider {
    if (!_yyz_privateAnimatedTransitionProvider) {
        _yyz_privateAnimatedTransitionProvider = [[YYZPrivateViewControllerAnimatedTransitionProvider alloc] init];
    }
    return _yyz_privateAnimatedTransitionProvider;
}

@end



@implementation YYZPrivateViewControllerAnimatedTransitionProvider

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    if (self.yyz_privateIsPresentAnimation) {
        UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIView *shadowView = [[UIView alloc] initWithFrame:containerView.bounds];
        shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        UIView *separatorView = [[UIView alloc] initWithFrame:containerView.bounds];
        separatorView.backgroundColor = UIColor.clearColor;
        separatorView.userInteractionEnabled = NO;
        [containerView addSubview:shadowView];
        [containerView addSubview:separatorView];
        [containerView addSubview:toVC.view];
        if (toVC.yyz_privateAlertStyle == YYZPrivateAlertStyleAlert) {
            toVC.view.center = containerView.center;
            toVC.view.alpha = 0;
            [UIView animateWithDuration:transitionDuration animations:^{
                toVC.view.alpha = 1;
            } completion:^(BOOL finished) {
                [transitionContext completeTransition:YES];
            }];
        } else {
            __block CGRect beginFrame = toVC.view.frame;
            beginFrame.origin.x = (CGRectGetWidth(containerView.frame) - CGRectGetWidth(beginFrame)) / 2.0;
            beginFrame.origin.y = CGRectGetHeight(containerView.frame);
            toVC.view.frame = beginFrame;
            [UIView animateWithDuration:transitionDuration animations:^{
                beginFrame.origin.y = CGRectGetHeight(containerView.frame) - CGRectGetHeight(beginFrame);
                toVC.view.frame = beginFrame;
            } completion:^(BOOL finished) {
                [transitionContext completeTransition:YES];
            }];
        }
    } else {
        UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        if (fromVC.yyz_privateAlertStyle == YYZPrivateAlertStyleAlert) {
            [UIView animateWithDuration:transitionDuration animations:^{
                fromVC.view.alpha = 0;
            } completion:^(BOOL finished) {
                if (fromVC.view) {[fromVC.view removeFromSuperview];}
                [transitionContext completeTransition:YES];
            }];
        } else {
            [UIView animateWithDuration:transitionDuration animations:^{
                CGRect tempFrame = fromVC.view.frame;
                tempFrame.origin.y = CGRectGetHeight(containerView.bounds);
                fromVC.view.frame = tempFrame;
            } completion:^(BOOL finished) {
                if (fromVC.view) {[fromVC.view removeFromSuperview];}
                [transitionContext completeTransition:YES];
            }];
        }
    }
}

@end
