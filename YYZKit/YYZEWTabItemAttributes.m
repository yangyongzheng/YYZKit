//
//  YYZEWTabItemAttributes.m
//  YYZKit
//
//  Created by 杨永正 on 2019/12/12.
//  Copyright © 2019 yoger. All rights reserved.
//

#import "YYZEWTabItemAttributes.h"

@implementation YYZEWTabItemAttributes

+ (instancetype)attributesWithTitle:(NSString *)title badgeProvider:(id<YYZEWTabItemBadgeProvider>)badgeProvider {
    YYZEWTabItemAttributes *attr = [[[self class] alloc] init];
    if (title && [title isKindOfClass:[NSString class]] && title.length > 0) {
        attr->_title = title;
    } else {
        attr->_title = @"";
    }
    attr.badgeProvider = badgeProvider;
    
    return attr;
}

- (void)setBadgeProvider:(id<YYZEWTabItemBadgeProvider>)badgeProvider {
    if ([YYZEWTabItemAttributes isValidBadgeProvider:badgeProvider]) {
        _badgeProvider = badgeProvider;
    } else {
        _badgeProvider = nil;
    }
}

+ (BOOL)isValidBadgeProvider:(id<YYZEWTabItemBadgeProvider>)badgeProvider {
    return badgeProvider && ([badgeProvider isKindOfClass:[YYZEWTabBadgePointProvider class]] ||
                             [badgeProvider isKindOfClass:[YYZEWTabBadgeTextProvider class]] ||
                             [badgeProvider isKindOfClass:[YYZEWTabBadgeImageProvider class]]);
}

@end
