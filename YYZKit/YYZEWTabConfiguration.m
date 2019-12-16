//
//  YYZEWTabConfiguration.m
//  YYZKit
//
//  Created by 杨永正 on 2019/12/8.
//  Copyright © 2019 yoger. All rights reserved.
//

#import "YYZEWTabConfiguration.h"

#define YYZEWTCSelectedColor [UIColor colorWithRed:57.0/255.0 green:191.0/255.0 blue:62.0/255.0 alpha:1.0]

@implementation YYZEWTabTitleConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        _selectedFont = [UIFont boldSystemFontOfSize:17];
        _unselectedFont = [UIFont systemFontOfSize:15];
        _selectedColor = YYZEWTCSelectedColor;
        _unselectedColor = [UIColor colorWithWhite:34.0/255.0 alpha:1.0];
    }
    return self;
}

- (UIFont *)selectedFont {
    if (!_selectedFont) {
        _selectedFont = [UIFont boldSystemFontOfSize:17];
    }
    return _selectedFont;
}

- (UIFont *)unselectedFont {
    if (!_unselectedFont) {
        _unselectedFont = [UIFont systemFontOfSize:15];
    }
    return _unselectedFont;
}

- (UIColor *)selectedColor {
    if (!_selectedColor) {
        _selectedColor = YYZEWTCSelectedColor;
    }
    return _selectedColor;
}

- (UIColor *)unselectedColor {
    if (!_unselectedColor) {
        _unselectedColor = [UIColor colorWithWhite:34.0/255.0 alpha:1.0];
    }
    return _unselectedColor;
}

@end

const YYZEWTabIndicatorWidth YYZEWTabIndicatorEqualToTitleWidth = -1;

@implementation YYZEWTabIndicatorConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        _lineWidth = 21;
        _lineHeight = 3;
        _cornerRadius = 1.5;
        _backgroundColor = YYZEWTCSelectedColor;
    }
    return self;
}

- (UIColor *)backgroundColor {
    if (!_backgroundColor) {
        _backgroundColor = YYZEWTCSelectedColor;
    }
    return _backgroundColor;
}

@end

@implementation YYZEWTabSeparatorConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        _height = 0.5;
        _backgroundColor = [UIColor colorWithWhite:221.0/255.0 alpha:1.0];
        _edgeInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (UIColor *)backgroundColor {
    if (!_backgroundColor) {
        _backgroundColor = [UIColor colorWithWhite:221.0/255.0 alpha:1.0];
    }
    return _backgroundColor;
}

@end



@implementation YYZEWTabConfiguration

- (instancetype)init {
    self = [super init];
    if (self) {
        _titleConfig = [[YYZEWTabTitleConfig alloc] init];
        _indicatorConfig = [[YYZEWTabIndicatorConfig alloc] init];
        _headerLineConfig = [[YYZEWTabSeparatorConfig alloc] init];
        _footerLineConfig = [[YYZEWTabSeparatorConfig alloc] init];
        _selectedTabItemIndex = 0;
        _tabItemSpacing = 1;
        _minimumWidth = 0;
    }
    return self;
}

+ (instancetype)defaultConfiguration {
    return [[[self class] alloc] init];
}

- (void)setTabItemSpacing:(CGFloat)tabItemSpacing {
    if (tabItemSpacing >= 1) {
        _tabItemSpacing = tabItemSpacing;
    } else {
        _tabItemSpacing = 1;
    }
}

@end
