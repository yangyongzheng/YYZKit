
#import "YYZAlertManager.h"

@interface YYZAlertManager ()
@property (nonatomic, readonly, strong) UIWindow *window;
@property (nonatomic, readonly, strong) UIView *shadowView;
@property (nonatomic, readonly, strong) UIView *containerView;

@property (nonatomic) BOOL isAlerting;
@end

@implementation YYZAlertManager

+ (BOOL)isAlertingView {
    return YYZAlertManager.defaultManager.isAlerting;
}

+ (BOOL)showWithCustomView:(UIView *)customView
             animationType:(YYZAlertAnimationType)animationType
                completion:(void (^)(void))completion {
    if (!YYZAlertManager.defaultManager.isAlerting &&
        customView && [customView isKindOfClass:[UIView class]] &&
        !CGSizeEqualToSize(customView.frame.size, CGSizeZero)) {
        // 添加自定义View
        [YYZAlertManager.defaultManager.containerView addSubview:customView];
        customView.center = YYZAlertManager.defaultManager.containerView.center;
        // 执行动画
        [YYZAlertManager.defaultManager showWithAnimationType:animationType completion:completion];
        return YES;
    } else {
        if (completion) {completion();}
        return NO;
    }
}

+ (void)hideWithAnimationType:(YYZAlertAnimationType)animationType completion:(void (^)(void))completion {
    [YYZAlertManager.defaultManager hideWithAnimationType:animationType completion:completion];
}

+ (YYZAlertManager *)defaultManager {
    static YYZAlertManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[YYZAlertManager alloc] init];
        [manager initDefaultConfig];
    });
    return manager;
}

- (void)initDefaultConfig {
    _window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    _window.backgroundColor = UIColor.clearColor;
    _window.windowLevel = UIWindowLevelStatusBar + 1;
    
    _shadowView = [[UIView alloc] initWithFrame:_window.bounds];
    [_window addSubview:_shadowView];
    _shadowView.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.7];
    
    _containerView = [[UIView alloc] initWithFrame:_window.bounds];
    [_window addSubview:_containerView];
    _containerView.backgroundColor = UIColor.clearColor;
    _containerView.clipsToBounds = YES;
    
    [self resetDefaultConfig];
}

- (void)resetDefaultConfig {
    [self.window resignKeyWindow];
    self.window.hidden = YES;
    self.shadowView.alpha = 1;
    self.containerView.alpha = 1;
    self.containerView.frame = self.window.bounds;
}

- (void)showWithAnimationType:(YYZAlertAnimationType)animationType
                   completion:(void (^)(void))completion {
    self.isAlerting = YES;
    [self.window makeKeyAndVisible];
    switch (animationType) {
        case YYZAlertAnimationTypeFade: {
            self.containerView.alpha = 0;
            [UIView animateWithDuration:0.25 animations:^{
                self.containerView.alpha = 1;
            } completion:^(BOOL finished) {
                if (completion) {completion();}
            }];
            break;
        }
            
        case YYZAlertAnimationTypeSlide: {
            __block CGRect tempFrame = UIScreen.mainScreen.bounds;
            tempFrame.origin.x = -CGRectGetWidth(tempFrame);
            self.containerView.frame = tempFrame;
            [UIView animateWithDuration:0.25 animations:^{
                tempFrame.origin.x = 0;
                self.containerView.frame = tempFrame;
            } completion:^(BOOL finished) {
                if (completion) {completion();}
            }];
            break;
        }
            
        default: {
            if (completion) {completion();}
            break;
        }
    }
}

- (void)hideWithAnimationType:(YYZAlertAnimationType)animationType completion:(void (^)(void))completion {
    if (self.isAlerting) {
        switch (animationType) {
            case YYZAlertAnimationTypeFade: {
                [UIView animateWithDuration:0.25 animations:^{
                    self.containerView.alpha = 0;
                    self.shadowView.alpha = 0;
                } completion:^(BOOL finished) {
                    [self removeCustomView];
                    [self resetDefaultConfig];
                    self.isAlerting = NO;
                    if (completion) {completion();}
                }];
                break;
            }
                
            case YYZAlertAnimationTypeSlide: {
                [UIView animateWithDuration:0.25 animations:^{
                    self.shadowView.alpha = 0;
                    CGRect tempFrame = UIScreen.mainScreen.bounds;
                    tempFrame.origin.x = CGRectGetWidth(tempFrame);
                    self.containerView.frame = tempFrame;
                } completion:^(BOOL finished) {
                    [self removeCustomView];
                    [self resetDefaultConfig];
                    self.isAlerting = NO;
                    if (completion) {completion();}
                }];
                break;
            }
                
            default: {
                [self removeCustomView];
                [self resetDefaultConfig];
                self.isAlerting = NO;
                if (completion) {completion();}
                break;
            }
        }
    } else {
        if (completion) {completion();}
    }
}

- (void)removeCustomView {
    NSArray *subviews = self.containerView.subviews;
    for (UIView *view in subviews) {
        [view removeFromSuperview];
    }
}

@end
