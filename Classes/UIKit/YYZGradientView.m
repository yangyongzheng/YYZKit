
#import "YYZGradientView.h"
#import <objc/runtime.h>

@interface YYZGradientMaker ()
@property (nonatomic, readonly, copy) NSArray *colorRefs; // 数组元素为 CGColorRef 对象
@end



@implementation YYZGradientView

#pragma mark - Public
- (void)makeGradient:(void (NS_NOESCAPE ^)(YYZGradientMaker * _Nonnull))block {
    if (block) {
        YYZGradientMaker *maker = [[YYZGradientMaker alloc] init];
        block(maker);
        [self installGradientWithMaker:maker];
    }
}

#pragma mark - Private
#pragma mark 更新渐变配置
- (void)installGradientWithMaker:(YYZGradientMaker *)maker {
    CAGradientLayer *gradientLayer = (CAGradientLayer *)self.layer;
    if (gradientLayer && [gradientLayer isKindOfClass:[CAGradientLayer class]]) {
        gradientLayer.colors = maker.colorRefs;
        gradientLayer.locations = maker.locations;
        gradientLayer.startPoint = maker.startPoint;
        gradientLayer.endPoint = maker.endPoint;
        gradientLayer.type = maker.type;
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.userInteractionEnabled = NO;
    }
    return self;
}

+ (Class)layerClass {
    return [CAGradientLayer class];
}

@end



@implementation UIView (YYZGradient)

- (void)yyz_makeGradient:(void (NS_NOESCAPE ^)(YYZGradientMaker * _Nonnull))block {
    YYZGradientView *gradientView = [self yyz_gradientView];
    if (gradientView) {
        [self sendSubviewToBack:gradientView];
        // 更新渐变层配置
        [gradientView makeGradient:block];
    } else {
        gradientView = [[YYZGradientView alloc] initWithFrame:self.bounds];
        [self setYyz_gradientView:gradientView];
        [self insertSubview:gradientView atIndex:0];
        [self yyz_addConstraintsForGradientView];
        // 更新渐变层配置
        [gradientView makeGradient:block];
    }
}

#pragma mark - Private
static const void * YYZGradientViewAssociationKey = (void *)&YYZGradientViewAssociationKey;

- (YYZGradientView *)yyz_gradientView {
    return objc_getAssociatedObject(self, YYZGradientViewAssociationKey);
}

- (void)setYyz_gradientView:(YYZGradientView *)yyz_gradientView {
    objc_setAssociatedObject(self,
                             YYZGradientViewAssociationKey,
                             yyz_gradientView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)yyz_addConstraintsForGradientView {
    UIView *gradientView = [self yyz_gradientView];
    if (gradientView) {
        gradientView.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *top = YYZPrivateLayoutConstraintMaker(gradientView, self, NSLayoutAttributeTop);
        NSLayoutConstraint *leading = YYZPrivateLayoutConstraintMaker(gradientView, self, NSLayoutAttributeLeading);
        NSLayoutConstraint *bottom = YYZPrivateLayoutConstraintMaker(gradientView, self, NSLayoutAttributeBottom);
        NSLayoutConstraint *trailing = YYZPrivateLayoutConstraintMaker(gradientView, self, NSLayoutAttributeTrailing);
        [NSLayoutConstraint activateConstraints:@[top, leading, bottom, trailing]];
    }
}

static NSLayoutConstraint * YYZPrivateLayoutConstraintMaker(id item, id toItem, NSLayoutAttribute attribute) {
    return [NSLayoutConstraint constraintWithItem:item
                                        attribute:(attribute)
                                        relatedBy:(NSLayoutRelationEqual)
                                           toItem:toItem
                                        attribute:(attribute)
                                       multiplier:1.0
                                         constant:0.0];
}

@end



@implementation YYZGradientMaker

- (instancetype)init {
    self = [super init];
    if (self) {
        _colors = nil;
        _locations = nil;
        _startPoint = CGPointMake(0.0, 0.5);
        _endPoint = CGPointMake(1.0, 0.5);
        _type = kCAGradientLayerAxial;
    }
    return self;
}

- (NSArray *)colorRefs {
    NSArray *tempColors = [NSArray arrayWithArray:_colors];
    if (tempColors && tempColors.count > 0) {
        NSMutableArray *colorRefArray = [NSMutableArray array];
        for (UIColor *color in tempColors) {
            [colorRefArray addObject:(__bridge id)color.CGColor];
        }
        
        return colorRefArray.count>0 ? [colorRefArray copy] : nil;
    } else {
        return nil;
    }
}

@end
