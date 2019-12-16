//
//  YYZEWTabConfiguration.h
//  YYZKit
//
//  Created by 杨永正 on 2019/12/8.
//  Copyright © 2019 yoger. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYZEWTabTitleConfig : NSObject
/** default bold system 15 */
@property (null_resettable, nonatomic, strong) UIFont *selectedFont;
/** default system 15 */
@property (null_resettable, nonatomic, strong) UIFont *unselectedFont;
/** default redColor */
@property (null_resettable, nonatomic, strong) UIColor *selectedColor;
/** default 0x222222 */
@property (null_resettable, nonatomic, strong) UIColor *unselectedColor;
@end

typedef CGFloat YYZEWTabIndicatorWidth;
extern const YYZEWTabIndicatorWidth YYZEWTabIndicatorEqualToTitleWidth;

@interface YYZEWTabIndicatorConfig : NSObject
/** default 21 */
@property (nonatomic) YYZEWTabIndicatorWidth lineWidth;
/** default 3 */
@property (nonatomic) CGFloat lineHeight;
/** default 1.5 */
@property (nonatomic) CGFloat cornerRadius;
/** default redColor */
@property (null_resettable, nonatomic, strong) UIColor *backgroundColor;
@end

@interface YYZEWTabSeparatorConfig : NSObject
/** default 0.5 */
@property (nonatomic) CGFloat height;
/** default 0xDDDDDD */
@property (null_resettable, nonatomic, strong) UIColor *backgroundColor;
/**
 default UIEdgeInsetsZero，
 header仅有 top, left, right 会生效
 footer仅有 left, bottom, right 会生效
 */
@property (nonatomic) UIEdgeInsets edgeInsets;
@end



@interface YYZEWTabConfiguration : NSObject

+ (instancetype)defaultConfiguration;

@property (nonatomic, readonly, strong) YYZEWTabTitleConfig *titleConfig;
@property (nonatomic, readonly, strong) YYZEWTabIndicatorConfig *indicatorConfig;
@property (nonatomic, readonly, strong) YYZEWTabSeparatorConfig *headerLineConfig;
@property (nonatomic, readonly, strong) YYZEWTabSeparatorConfig *footerLineConfig;
/** default 0，即默认选中第一项 */
@property (nonatomic) NSInteger selectedTabItemIndex;

/** Tab Item之间的间距，最小值为 1，default 1 */
@property (nonatomic) CGFloat tabItemSpacing;

/** Tab最小宽度，default 0 */
@property (nonatomic) CGFloat minimumWidth;

@end

NS_ASSUME_NONNULL_END
