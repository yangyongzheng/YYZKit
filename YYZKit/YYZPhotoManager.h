//
//  YYZPhotoManager.h
//  YYZKit
//
//  Created by yangyongzheng on 2019/8/2.
//  Copyright © 2019 yoger. All rights reserved.
//

#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYZPhotoManager : NSObject

+ (instancetype)defaultManager;

- (void)requestSavePhotoToAlbum:(NSArray<UIImage *> *)images;

@end

NS_ASSUME_NONNULL_END
