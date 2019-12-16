//
//  YYZEWTabItemBadgeProvider.h
//  YYZKit
//
//  Created by 杨永正 on 2019/12/12.
//  Copyright © 2019 yoger. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YYZEWTabItemBadgeProvider <NSObject>

@end



@interface YYZEWTabBadgePointProvider : NSObject <YYZEWTabItemBadgeProvider>
/** 便利构造方法 */
+ (instancetype)pointProvider;
@end



@interface YYZEWTabBadgeTextProvider : NSObject <YYZEWTabItemBadgeProvider>
/** 便利构造方法 */
+ (instancetype)providerWithText:(NSString *)text;

@property (nonatomic, readonly, copy) NSString *text;
@end



@interface YYZEWTabBadgeImageProvider : NSObject <YYZEWTabItemBadgeProvider>
/** 便利构造方法 */
+ (instancetype)providerWithImage:(UIImage *)image imageSize:(CGSize)imageSize;

@property (nonatomic, readonly, strong) UIImage *image;
@property (nonatomic, readonly) CGSize imageSize;
/** default 0 */
@property (nonatomic) CGFloat cornerRadius;
@end

NS_ASSUME_NONNULL_END
