//
//  YYZEWTabItemBadgeProvider.m
//  YYZKit
//
//  Created by 杨永正 on 2019/12/12.
//  Copyright © 2019 yoger. All rights reserved.
//

#import "YYZEWTabItemBadgeProvider.h"

@implementation YYZEWTabBadgePointProvider

+ (instancetype)pointProvider {
    return [[[self class] alloc] init];
}

@end



@implementation YYZEWTabBadgeTextProvider

+ (instancetype)providerWithText:(NSString *)text {
    YYZEWTabBadgeTextProvider *attributes = [[[self class] alloc] init];
    if (text && [text isKindOfClass:[NSString class]]) {
        attributes->_text = [text copy]; // copy修饰的属性
    } else {
        attributes->_text = @"";
    }
    return attributes;
}

@end



@implementation YYZEWTabBadgeImageProvider

+ (instancetype)providerWithImage:(UIImage *)image imageSize:(CGSize)imageSize {
    YYZEWTabBadgeImageProvider *attributes = [[[self class] alloc] init];
    attributes->_image = image;
    attributes->_imageSize = imageSize;
    attributes.cornerRadius = 0;
    return attributes;
}

@end
