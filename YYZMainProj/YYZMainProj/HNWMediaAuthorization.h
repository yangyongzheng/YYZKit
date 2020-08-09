//
//  HNWMediaAuthorization.h
//  YYZMainProj
//
//  Created by Young on 2020/8/8.
//  Copyright © 2020 yangyongzheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HNWMediaAuthorizationStatus) {
    HNWMediaAuthorizationStatusHardwareNotSupported = -1,   // 硬设不支持
    HNWMediaAuthorizationStatusNotDetermined = 0,           // 尚未作出抉择
    HNWMediaAuthorizationStatusRestricted,                  // 无权限访问，用户无法授权此类权限，家长控制或机构配置文件限制了用户授权
    HNWMediaAuthorizationStatusDenied,                      // 用户已明确拒绝访问
    HNWMediaAuthorizationStatusAuthorized                   // 用户已授权访问
};

@interface HNWMediaAuthorization : NSObject

/// 请求相机权限
+ (void)requestVideoAuthorization:(void (^)(HNWMediaAuthorizationStatus status))handler;

/// 请求麦克风权限
+ (void)requestAudioAuthorization:(void (^)(HNWMediaAuthorizationStatus status))handler;

@end

NS_ASSUME_NONNULL_END
