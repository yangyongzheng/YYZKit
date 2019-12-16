//
//  YYZEWTabItemAttributes.h
//  YYZKit
//
//  Created by 杨永正 on 2019/12/12.
//  Copyright © 2019 yoger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYZEWTabItemBadgeProvider.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYZEWTabItemAttributes : NSObject

+ (instancetype)attributesWithTitle:(NSString *)title badgeProvider:(nullable id<YYZEWTabItemBadgeProvider>)badgeProvider;

@property (nonatomic, readonly, copy) NSString *title;

@property (nullable, nonatomic, strong) id<YYZEWTabItemBadgeProvider> badgeProvider;

@property (nonatomic) CGFloat titleSelectedWidth;

@end

NS_ASSUME_NONNULL_END
