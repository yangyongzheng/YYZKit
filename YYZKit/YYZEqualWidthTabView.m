//
//  YYZEqualWidthTabView.m
//  YYZKit
//
//  Created by 杨永正 on 2019/12/8.
//  Copyright © 2019 yoger. All rights reserved.
//

#import "YYZEqualWidthTabView.h"
#import "YYZEWTabItemCollectionViewCell.h"
#import "YYZEWTabItemAttributes.h"
#import "NSLayoutConstraint+YYZAdditional.h"

@interface YYZEqualWidthTabView () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *headerLineView;
@property (nonatomic, strong) UIView *footerLineView;
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) YYZEWTabConfiguration *tabConfiguration;
@property (nonatomic, copy) NSArray<YYZEWTabItemAttributes *> *tabItemAttributes;
@property (nonatomic) NSInteger selectedTabItemIndex;
@property (nonatomic, getter=isShouldTellsDelegate) BOOL shouldTellsDelegate;
@end

@implementation YYZEqualWidthTabView

- (instancetype)initWithFrame:(CGRect)frame configuration:(void (^)(YYZEWTabConfiguration * _Nonnull))configuration {
    self = [super initWithFrame:frame];
    if (self) {
        self.tabConfiguration = [YYZEWTabConfiguration defaultConfiguration];
        if (configuration) {configuration(self.tabConfiguration);}
        self.selectedTabItemIndex = self.tabConfiguration.selectedTabItemIndex;
        self.shouldTellsDelegate = YES;
        // 初始化配置
        [self setupDefaultConfig];
    }
    return self;
}

- (void)selectTabItemAtIndex:(NSInteger)index
                    animated:(BOOL)animated
               isUserTrigger:(BOOL)isUserTrigger {
    [self selectTabItemAtIndex:index
                      animated:animated
                 isUserTrigger:isUserTrigger
                 tellsDelegate:YES];
}

- (void)reloadDataWithScope:(YYZEqualWidthTabScope)scope {
    switch (scope) {
        case YYZEqualWidthTabScopeBadge:
            [self reloadDataScopeBadge];
            break;
            
        default:
            [self reloadDataScopeAll];
            break;
    }
}

#pragma mark - Delegates
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tabItemAttributes.count > 0) {
        UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
        const CGFloat totalItemWidth = CGRectGetWidth(collectionView.bounds) - (self.tabItemAttributes.count - 1) * flowLayout.minimumLineSpacing;
        const CGFloat validTotalItemWidth = totalItemWidth > 0 ? totalItemWidth : 0;
        const CGFloat itemWidth = floor(validTotalItemWidth / self.tabItemAttributes.count);
        const CGFloat validItemWidth = MAX(itemWidth, self.tabConfiguration.minimumWidth);
        return CGSizeMake(validItemWidth, CGRectGetHeight(collectionView.bounds));
    } else {
        return CGSizeZero;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.tabItemAttributes.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YYZEWTabItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YYZEWTabItemCollectionViewCell"
                                                                                     forIndexPath:indexPath];
    YYZEWTabItemAttributes *model = [self tabItemAttributesAtIndex:indexPath.item];
    cell.titleLabel.text = model.title;
    cell.titleLabel.textColor = self.selectedTabItemIndex == indexPath.item ? self.tabConfiguration.titleConfig.selectedColor : self.tabConfiguration.titleConfig.unselectedColor;
    cell.titleLabel.font = self.selectedTabItemIndex == indexPath.item ? self.tabConfiguration.titleConfig.selectedFont : self.tabConfiguration.titleConfig.unselectedFont;
    [cell resetBadgeValue:model.badgeProvider];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self selectTabItemAtIndex:indexPath.item
                      animated:YES
                 isUserTrigger:YES];
}

#pragma mark - Actions
- (void)selectTabItemAtIndex:(NSInteger)index
                    animated:(BOOL)animated
               isUserTrigger:(BOOL)isUserTrigger
               tellsDelegate:(BOOL)tellsDelegate {
    if (index >= 0 && index < self.tabItemAttributes.count) {
        self.selectedTabItemIndex = index;
        [self.collectionView reloadData];
        // 刷新indicatorView
        [self refreshIndicatorViewAnimated:animated];
        if (self.collectionView.contentSize.width > self.collectionView.frame.size.width) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.selectedTabItemIndex inSection:0];
            [self.collectionView scrollToItemAtIndexPath:indexPath
                                        atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                                animated:YES];
        }
        if (tellsDelegate && self.delegate && [self.delegate respondsToSelector:@selector(equalWidthTabView:didSelectItemAtIndex:isUserTrigger:)]) {
            [self.delegate equalWidthTabView:self
                        didSelectItemAtIndex:self.selectedTabItemIndex
                               isUserTrigger:isUserTrigger];
        }
    }
}

#pragma mark - Misc
- (void)reloadDataScopeAll {
    [self constructDataSource];
    [self.collectionView reloadData];
    [self refreshIndicatorViewAnimated:NO];
}

- (void)reloadDataScopeBadge {
    [self constructTabBadges];
    [self.collectionView reloadData];
}

- (void)constructDataSource {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(titlesForEqualWidthTabView:)]) {
        NSArray *titleArray = [self.dataSource titlesForEqualWidthTabView:self];
        if (titleArray && [titleArray isKindOfClass:[NSArray class]] && titleArray.count > 0) {
            NSArray<NSString *> *titleSafeArray = [titleArray copy];
            __block NSMutableArray *attributesArray = [NSMutableArray arrayWithCapacity:titleSafeArray.count];
            [titleSafeArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                id <YYZEWTabItemBadgeProvider> badgeProvider = [self dequeueBadgeProviderForItemAtIndex:idx];
                YYZEWTabItemAttributes *attributes = [YYZEWTabItemAttributes attributesWithTitle:obj badgeProvider:badgeProvider];
                if (attributes) {
                    const CGSize titleSize = [attributes.title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                                                            options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                                         attributes:@{NSFontAttributeName : self.tabConfiguration.titleConfig.selectedFont}
                                                                            context:nil].size;
                    attributes.titleSelectedWidth = ceil(titleSize.width);
                    [attributesArray addObject:attributes];
                }
            }];
            self.tabItemAttributes = [attributesArray copy];
        } else {
            self.tabItemAttributes = @[];
        }
    } else {
        self.tabItemAttributes = @[];
    }
}

- (void)constructTabBadges {
    if (self.tabItemAttributes.count > 0) {
        [self.tabItemAttributes enumerateObjectsUsingBlock:^(YYZEWTabItemAttributes * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.badgeProvider = [self dequeueBadgeProviderForItemAtIndex:idx];
        }];
    }
}

- (id<YYZEWTabItemBadgeProvider>)dequeueBadgeProviderForItemAtIndex:(NSInteger)index {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(equalWidthTabView:badgeProviderForItemAtIndex:)]) {
        return [self.dataSource equalWidthTabView:self badgeProviderForItemAtIndex:index];
    } else {
        return nil;
    }
}

- (YYZEWTabItemAttributes *)tabItemAttributesAtIndex:(NSInteger)index {
    if (index < self.tabItemAttributes.count) {
        return self.tabItemAttributes[index];
    } else {
        return nil;
    }
}

- (BOOL)indicatorViewHidden {
    if ((self.tabConfiguration.indicatorConfig.lineWidth == YYZEWTabIndicatorEqualToTitleWidth || self.tabConfiguration.indicatorConfig.lineWidth > 0) &&
        self.tabConfiguration.indicatorConfig.lineHeight > 0 &&
        self.selectedTabItemIndex >= 0 && self.selectedTabItemIndex < self.tabItemAttributes.count) {
        return NO;
    } else {
        return YES;
    }
}

#pragma mark - UI
- (void)layoutSubviews {
    [super layoutSubviews];
    if (!self.tabItemAttributes) {[self constructDataSource];}
    [self layoutIfNeeded];
    [self selectTabItemAtIndex:self.selectedTabItemIndex
                      animated:NO
                 isUserTrigger:NO
                 tellsDelegate:self.isShouldTellsDelegate];
    self.shouldTellsDelegate = NO;
}

- (void)refreshIndicatorViewAnimated:(BOOL)animated {
    self.indicatorView.hidden = [self indicatorViewHidden];
    if (!self.indicatorView.isHidden) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.selectedTabItemIndex inSection:0];
        UICollectionViewLayoutAttributes *layoutAttributes = [self.collectionView layoutAttributesForItemAtIndexPath:indexPath];
        if (layoutAttributes) {
            CGFloat x, y, w = self.tabConfiguration.indicatorConfig.lineWidth, h = self.tabConfiguration.indicatorConfig.lineHeight;
            if (w == YYZEWTabIndicatorEqualToTitleWidth) {
                YYZEWTabItemAttributes *itemAttr = [self tabItemAttributesAtIndex:self.selectedTabItemIndex];
                w = itemAttr.titleSelectedWidth;
            }
            x = layoutAttributes.center.x - w / 2.0;
            y = layoutAttributes.size.height - h;
            CGRect newFrame = CGRectMake(x, y, w, h);
            if (animated) {
                [UIView animateWithDuration:0.25 animations:^{
                    self.indicatorView.frame = newFrame;
                }];
            } else {
                self.indicatorView.frame = newFrame;
            }
        }
    }
}

- (void)setupDefaultConfig {
    // 1.自身配置
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    // 2.添加子视图
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.headerLineView];
    [self.contentView addSubview:self.footerLineView];
    [self.contentView addSubview:self.collectionView];
    [self.collectionView addSubview:self.indicatorView];
    // 3.添加约束
    [self layoutView:self.contentView equalEdgeInsetsToView:self];
    [self addConstraintsForHeaderLineView];
    [self addConstraintsForFooterLineView];
    [self layoutView:self.collectionView equalEdgeInsetsToView:self.contentView];
    // 4.更新子视图配置
    self.headerLineView.backgroundColor = self.tabConfiguration.headerLineConfig.backgroundColor;
    self.footerLineView.backgroundColor = self.tabConfiguration.footerLineConfig.backgroundColor;
    self.indicatorView.backgroundColor = self.tabConfiguration.indicatorConfig.backgroundColor;
    self.indicatorView.layer.cornerRadius = self.tabConfiguration.indicatorConfig.cornerRadius;
    self.indicatorView.layer.masksToBounds = self.tabConfiguration.indicatorConfig.cornerRadius > 0 ? YES : NO;
    [self.collectionView registerClass:[YYZEWTabItemCollectionViewCell class]
            forCellWithReuseIdentifier:@"YYZEWTabItemCollectionViewCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

- (void)addConstraintsForHeaderLineView {
    self.headerLineView.translatesAutoresizingMaskIntoConstraints = NO;
    UIEdgeInsets insets = self.tabConfiguration.headerLineConfig.edgeInsets;
    NSLayoutConstraint *top = NSLayoutConstraint.yyz_constraintLiteMaker(self.headerLineView, NSLayoutAttributeTop,
                                                                         self.contentView, NSLayoutAttributeTop,
                                                                         insets.top);
    NSLayoutConstraint *leading = NSLayoutConstraint.yyz_constraintLiteMaker(self.headerLineView, NSLayoutAttributeLeading,
                                                                             self.contentView, NSLayoutAttributeLeading,
                                                                             insets.left);
    NSLayoutConstraint *trailing = NSLayoutConstraint.yyz_constraintLiteMaker(self.headerLineView, NSLayoutAttributeTrailing,
                                                                              self.contentView, NSLayoutAttributeTrailing,
                                                                              -insets.right);
    NSLayoutConstraint *height = NSLayoutConstraint.yyz_constraintLiteMaker(self.headerLineView, NSLayoutAttributeHeight,
                                                                            nil, NSLayoutAttributeNotAnAttribute,
                                                                            self.tabConfiguration.headerLineConfig.height);
    [NSLayoutConstraint activateConstraints:@[top, leading, trailing, height]];
}

- (void)addConstraintsForFooterLineView {
    self.footerLineView.translatesAutoresizingMaskIntoConstraints = NO;
    UIEdgeInsets insets = self.tabConfiguration.footerLineConfig.edgeInsets;
    NSLayoutConstraint *bottom = NSLayoutConstraint.yyz_constraintLiteMaker(self.footerLineView, NSLayoutAttributeBottom,
                                                                            self.contentView, NSLayoutAttributeBottom,
                                                                            -insets.bottom);
    NSLayoutConstraint *leading = NSLayoutConstraint.yyz_constraintLiteMaker(self.footerLineView, NSLayoutAttributeLeading,
                                                                             self.contentView, NSLayoutAttributeLeading,
                                                                             insets.left);
    NSLayoutConstraint *trailing = NSLayoutConstraint.yyz_constraintLiteMaker(self.footerLineView, NSLayoutAttributeTrailing,
                                                                              self.contentView, NSLayoutAttributeTrailing,
                                                                              -insets.right);
    NSLayoutConstraint *height = NSLayoutConstraint.yyz_constraintLiteMaker(self.footerLineView, NSLayoutAttributeHeight,
                                                                            nil, NSLayoutAttributeNotAnAttribute,
                                                                            self.tabConfiguration.footerLineConfig.height);
    [NSLayoutConstraint activateConstraints:@[bottom, leading, trailing, height]];
}

- (void)layoutView:(UIView *)view equalEdgeInsetsToView:(UIView *)toView {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *top = NSLayoutConstraint.yyz_constraintLiteMaker(view, NSLayoutAttributeTop, toView, NSLayoutAttributeTop, 0);
    NSLayoutConstraint *leading = NSLayoutConstraint.yyz_constraintLiteMaker(view, NSLayoutAttributeLeading, toView, NSLayoutAttributeLeading, 0);
    NSLayoutConstraint *bottom = NSLayoutConstraint.yyz_constraintLiteMaker(view, NSLayoutAttributeBottom, toView, NSLayoutAttributeBottom, 0);
    NSLayoutConstraint *trailing = NSLayoutConstraint.yyz_constraintLiteMaker(view, NSLayoutAttributeTrailing, toView, NSLayoutAttributeTrailing, 0);
    [NSLayoutConstraint activateConstraints:@[top, leading, bottom, trailing]];
}

#pragma mark - getter or setter
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}

- (UIView *)headerLineView {
    if (!_headerLineView) {
        _headerLineView = [[UIView alloc] initWithFrame:CGRectZero];
        _headerLineView.userInteractionEnabled = NO;
    }
    return _headerLineView;
}

- (UIView *)footerLineView {
    if (!_footerLineView) {
        _footerLineView = [[UIView alloc] initWithFrame:CGRectZero];
        _footerLineView.userInteractionEnabled = NO;
    }
    return _footerLineView;
}

- (UIView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc] initWithFrame:CGRectZero];
        _indicatorView.userInteractionEnabled = NO;
    }
    return _indicatorView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = MAX(1, self.tabConfiguration.tabItemSpacing);
        layout.minimumInteritemSpacing = MAX(1, self.tabConfiguration.tabItemSpacing);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.estimatedItemSize = CGSizeZero;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.scrollsToTop = NO;
        _collectionView.scrollEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.alwaysBounceHorizontal = NO;
        _collectionView.alwaysBounceVertical = NO;
        _collectionView.pagingEnabled = NO;
        _collectionView.contentInset = UIEdgeInsetsZero;
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}

@end
