//
//  HNWPhotoAuthorization.h
//  YYZMainProj
//
//  Created by Young on 2020/8/7.
//  Copyright © 2020 yangyongzheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HNWPhotoAuthorizationStatus) {
    HNWPhotoAuthorizationStatusNotDetermined = 0,   // 尚未作出抉择
    HNWPhotoAuthorizationStatusRestricted,          // 无权限访问，用户无法授权此类权限，家长控制或机构配置文件限制了用户授权
    HNWPhotoAuthorizationStatusDenied,              // 用户已明确拒绝访问
    HNWPhotoAuthorizationStatusAuthorized           // 用户已授权访问
};

@interface HNWPhotoAuthorization : NSObject

/// 请求相册权限
+ (void)requestAuthorization:(void (^)(HNWPhotoAuthorizationStatus status))handler;

@end

NS_ASSUME_NONNULL_END
