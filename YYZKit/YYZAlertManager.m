
#import "YYZAlertManager.h"
#import <objc/runtime.h>

typedef NS_ENUM(NSInteger, YYZPrivateAlertStyle) {
    YYZPrivateAlertStyleAlert = 0,
    YYZPrivateAlertStyleFormSheet,
};

@interface UIViewController (YYZPrivateAlert)
@property (nonatomic) YYZPrivateAlertStyle yyz_privateAlertStyle;
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

@end



@interface YYZPrivateAlertTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) BOOL isPresentAnimation;
@end

@interface YYZAlertManager () <UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) YYZPrivateAlertTransitionAnimator *transitionAnimator;
@end

@implementation YYZAlertManager

#pragma mark - Lifecycle
+ (YYZAlertManager *)defaultManager {
    static YYZAlertManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[YYZAlertManager alloc] init];
    });
    return manager;
}

#pragma mark -  Public
+ (void)showAlertController:(UIViewController *)alertController
       presentingController:(UIViewController *)presentingController
                 completion:(void (^)(void))completion {
    alertController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    alertController.modalPresentationStyle = UIModalPresentationCustom;
    alertController.yyz_privateAlertStyle = YYZPrivateAlertStyleAlert;
    alertController.transitioningDelegate = [YYZAlertManager defaultManager];
    [presentingController presentViewController:alertController animated:YES completion:completion];
}

+ (void)showFormSheetController:(UIViewController *)formSheetController
           presentingController:(UIViewController *)presentingController
                     completion:(void (^)(void))completion {
    formSheetController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    formSheetController.modalPresentationStyle = UIModalPresentationCustom;
    formSheetController.yyz_privateAlertStyle = YYZPrivateAlertStyleFormSheet;
    formSheetController.transitioningDelegate = [YYZAlertManager defaultManager];
    [presentingController presentViewController:formSheetController animated:YES completion:completion];
}

#pragma mark -  Private
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    self.transitionAnimator.isPresentAnimation = YES;
    return self.transitionAnimator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.transitionAnimator.isPresentAnimation = NO;
    return self.transitionAnimator;
}

- (YYZPrivateAlertTransitionAnimator *)transitionAnimator {
    if (!_transitionAnimator) {
        _transitionAnimator = [[YYZPrivateAlertTransitionAnimator alloc] init];
    }
    return _transitionAnimator;
}

@end



@implementation YYZPrivateAlertTransitionAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    if (self.isPresentAnimation) {
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
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        if (fromView) {[fromView removeFromSuperview];}
        [transitionContext completeTransition:YES];
    }
}

@end
