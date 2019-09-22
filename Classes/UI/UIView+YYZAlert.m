
#import "UIView+YYZAlert.h"

@interface YYZPrivateAlertWindow : UIWindow

@property (nonatomic, strong) UIView *yyz_shadowView;
@property (nonatomic, strong) UIView *yyz_contentView;
@property (nonatomic, readonly) BOOL yyz_isAlerting;

+ (YYZPrivateAlertWindow *)yyz_privateAlertWindow;

- (BOOL)yyz_containView:(UIView *)view;

- (void)yyz_removeAlertView;

- (void)yyz_resetDefaultConfig;

@end

#define YYZPAlertDefaultWindow [YYZPrivateAlertWindow yyz_privateAlertWindow]

static const NSTimeInterval YYZAlertAnimationDuration = 0.25;

@implementation UIView (YYZAlert)

- (BOOL)yyz_showWithAnimation:(YYZAlertAnimationType)animation completion:(void (^)(void))completion {
    if (CGSizeEqualToSize(self.frame.size, CGSizeZero)) {
        NSAssert(NO, @"The width or height of alert view cannot be zero.");
        return NO;
    } else if (YYZPAlertDefaultWindow.yyz_isAlerting) {
        NSLog(@"Alert view is in progress.");
        return NO;
    } else {
        [YYZPAlertDefaultWindow.yyz_contentView addSubview:self];
        self.center = YYZPAlertDefaultWindow.yyz_contentView.center;
        [YYZPAlertDefaultWindow makeKeyAndVisible];
        switch (animation) {
            case YYZAlertAnimationTypeFade: {
                YYZPAlertDefaultWindow.yyz_contentView.alpha = 0;
                [UIView animateWithDuration:YYZAlertAnimationDuration animations:^{
                    YYZPAlertDefaultWindow.yyz_contentView.alpha = 1;
                } completion:^(BOOL finished) {
                    if (completion) {completion();}
                }];
                break;
            }
                
            case YYZAlertAnimationTypeSlide: {
                __block CGRect tempFrame = UIScreen.mainScreen.bounds;
                tempFrame.origin.x = -CGRectGetWidth(tempFrame);
                YYZPAlertDefaultWindow.yyz_contentView.frame = tempFrame;
                [UIView animateWithDuration:YYZAlertAnimationDuration animations:^{
                    tempFrame.origin.x = 0;
                    YYZPAlertDefaultWindow.yyz_contentView.frame = tempFrame;
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
        return YES;
    }
}

- (BOOL)yyz_hideWithAnimation:(YYZAlertAnimationType)animation completion:(void (^)(void))completion {
    if ([YYZPAlertDefaultWindow yyz_containView:self]) {
        switch (animation) {
            case YYZAlertAnimationTypeFade: {
                [UIView animateWithDuration:YYZAlertAnimationDuration animations:^{
                    YYZPAlertDefaultWindow.yyz_contentView.alpha = 0;
                    YYZPAlertDefaultWindow.yyz_shadowView.alpha = 0;
                } completion:^(BOOL finished) {
                    [YYZPAlertDefaultWindow yyz_removeAlertView];
                    [YYZPAlertDefaultWindow yyz_resetDefaultConfig];
                    if (completion) {completion();}
                }];
                break;
            }
                
            case YYZAlertAnimationTypeSlide: {
                [UIView animateWithDuration:YYZAlertAnimationDuration animations:^{
                    YYZPAlertDefaultWindow.yyz_shadowView.alpha = 0;
                    CGRect tempFrame = UIScreen.mainScreen.bounds;
                    tempFrame.origin.x = CGRectGetWidth(tempFrame);
                    YYZPAlertDefaultWindow.yyz_contentView.frame = tempFrame;
                } completion:^(BOOL finished) {
                    [YYZPAlertDefaultWindow yyz_removeAlertView];
                    [YYZPAlertDefaultWindow yyz_resetDefaultConfig];
                    if (completion) {completion();}
                }];
                break;
            }
                
            default: {
                [YYZPAlertDefaultWindow yyz_removeAlertView];
                [YYZPAlertDefaultWindow yyz_resetDefaultConfig];
                if (completion) {completion();}
                break;
            }
        }
        return YES;
    } else {
        return NO;
    }
}

@end



@implementation YYZPrivateAlertWindow

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        self.windowLevel = UIWindowLevelStatusBar + 1;
        UIViewController *rootVC = [[UIViewController alloc] init];
        rootVC.view.hidden = YES;
        self.rootViewController = rootVC;
        self.hidden = YES;
        self.yyz_shadowView = [[UIView alloc] initWithFrame:self.bounds];
        self.yyz_shadowView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        self.yyz_shadowView.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.6];
        self.yyz_contentView = [[UIView alloc] initWithFrame:self.bounds];
        self.yyz_contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        self.yyz_contentView.backgroundColor = UIColor.clearColor;
        [self addSubview:self.yyz_shadowView];
        [self addSubview:self.yyz_contentView];
    }
    return self;
}

+ (YYZPrivateAlertWindow *)yyz_privateAlertWindow {
    static YYZPrivateAlertWindow *window = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        window = [[YYZPrivateAlertWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    });
    return window;
}

- (BOOL)yyz_isAlerting {
    return self.yyz_contentView.subviews.count > 0;
}

- (void)yyz_removeAlertView {
    NSArray *alertViews = self.yyz_contentView.subviews;
    for (UIView *av in alertViews) {
        [av removeFromSuperview];
    }
}

- (BOOL)yyz_containView:(UIView *)view {
    if (view && [view isKindOfClass:[UIView class]]) {
        return [self.yyz_contentView.subviews containsObject:view];
    } else {
        return NO;
    }
}

- (void)yyz_resetDefaultConfig {
    [self resignKeyWindow];
    self.hidden = YES;
    self.yyz_shadowView.alpha = 1;
    self.yyz_contentView.alpha = 1;
    self.yyz_contentView.frame = self.bounds;
}

@end
