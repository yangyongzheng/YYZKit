
#import "UIViewController+YYZAlert.h"
#import <objc/runtime.h>

typedef NS_ENUM(NSInteger, YYZPrivateAlertStyle) {
    YYZPrivateAlertStyleAlert = 0,
    YYZPrivateAlertStyleFormSheet,
};


@interface YYZPrivateAlertAnimatedTransitioning : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, readonly, assign) BOOL yyz_privateIsPresentAnimation;

+ (YYZPrivateAlertAnimatedTransitioning *)animatedTransitioningWithFlag:(BOOL)isPresentAnimation;
@end


@interface YYZPrivateAlertTransitioningDelegate : NSObject <UIViewControllerTransitioningDelegate>

@end



@implementation UIViewController (YYZAlert)

#pragma mark - Public
- (void)yyz_showAlertController:(UIViewController *)alertController completion:(void (^)(void))completion {
    alertController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    alertController.modalPresentationStyle = UIModalPresentationCustom;
    alertController.yyz_privateAlertStyle = YYZPrivateAlertStyleAlert;
    alertController.transitioningDelegate = alertController.yyz_privateAlertTransitioningDelegate;
    [self presentViewController:alertController animated:YES completion:completion];
}

- (void)yyz_showFormSheetController:(UIViewController *)formSheetController completion:(void (^)(void))completion {
    formSheetController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    formSheetController.modalPresentationStyle = UIModalPresentationCustom;
    formSheetController.yyz_privateAlertStyle = YYZPrivateAlertStyleFormSheet;
    formSheetController.transitioningDelegate = formSheetController.yyz_privateAlertTransitioningDelegate;
    [self presentViewController:formSheetController animated:YES completion:completion];
}

#pragma mark - Private
- (void)setYyz_privateAlertStyle:(YYZPrivateAlertStyle)yyz_privateAlertStyle {
    NSNumber *styleNumber = [NSNumber numberWithInteger:yyz_privateAlertStyle];
    objc_setAssociatedObject(self, @selector(yyz_privateAlertStyle), styleNumber, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (YYZPrivateAlertStyle)yyz_privateAlertStyle {
    id styleNumber = objc_getAssociatedObject(self, _cmd);
    return styleNumber ? [styleNumber integerValue] : YYZPrivateAlertStyleAlert;
}

- (YYZPrivateAlertTransitioningDelegate *)yyz_privateAlertTransitioningDelegate {
    YYZPrivateAlertTransitioningDelegate *transitioningDelegate = objc_getAssociatedObject(self, _cmd);
    if (!transitioningDelegate) {
        transitioningDelegate = [[YYZPrivateAlertTransitioningDelegate alloc] init];
        objc_setAssociatedObject(self, _cmd, transitioningDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return transitioningDelegate;
}

@end



@implementation YYZPrivateAlertTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    return [YYZPrivateAlertAnimatedTransitioning animatedTransitioningWithFlag:YES];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [YYZPrivateAlertAnimatedTransitioning animatedTransitioningWithFlag:NO];
}

@end



@implementation YYZPrivateAlertAnimatedTransitioning

+ (YYZPrivateAlertAnimatedTransitioning *)animatedTransitioningWithFlag:(BOOL)isPresentAnimation {
    YYZPrivateAlertAnimatedTransitioning *obj = [[YYZPrivateAlertAnimatedTransitioning alloc] init];
    obj->_yyz_privateIsPresentAnimation = isPresentAnimation;
    return obj;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (self.yyz_privateIsPresentAnimation) {
        [self presentTransitionAnimation:transitionContext];
    } else {
        [self dismissTransitionAnimation:transitionContext];
    }
}

- (void)presentTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    // 可见区域
    CGRect visibleFrame = [transitionContext initialFrameForViewController:fromVC];
    CGRect visibleBounds = CGRectMake(0, 0, CGRectGetWidth(visibleFrame), CGRectGetHeight(visibleFrame));
    // 添加阴影View及交互隔离View
    UIView *shadowView = [[UIView alloc] initWithFrame:visibleBounds];
    shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    [containerView addSubview:shadowView];
    UIView *separatorView = [[UIView alloc] initWithFrame:visibleBounds];
    separatorView.backgroundColor = UIColor.clearColor;
    separatorView.userInteractionEnabled = NO;
    [containerView addSubview:separatorView];
    // 添加转场View
    [containerView addSubview:toView];
    [toView endEditing:YES];
    if (toVC.yyz_privateAlertStyle == YYZPrivateAlertStyleAlert) {
        toView.center = containerView.center;
        toView.alpha = 0;
        [UIView animateWithDuration:transitionDuration animations:^{
            toView.alpha = 1;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    } else {
        __block CGRect beginFrame = toView.frame;
        beginFrame.origin.x = (CGRectGetWidth(visibleBounds) - CGRectGetWidth(beginFrame)) / 2.0;
        beginFrame.origin.y = CGRectGetHeight(visibleBounds);
        toView.frame = beginFrame;
        [UIView animateWithDuration:transitionDuration animations:^{
            beginFrame.origin.y = CGRectGetHeight(visibleBounds) - CGRectGetHeight(beginFrame);
            toView.frame = beginFrame;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}

- (void)dismissTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    if (fromVC.yyz_privateAlertStyle == YYZPrivateAlertStyleAlert) {
        [UIView animateWithDuration:transitionDuration animations:^{
            fromView.alpha = 0;
        } completion:^(BOOL finished) {
            [fromView removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
    } else {
        UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        CGRect visibleFrame = [transitionContext finalFrameForViewController:toVC];
        [UIView animateWithDuration:transitionDuration animations:^{
            CGRect tempFrame = fromView.frame;
            tempFrame.origin.y = CGRectGetHeight(visibleFrame);
            fromView.frame = tempFrame;
        } completion:^(BOOL finished) {
            [fromView removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
    }
}

@end
