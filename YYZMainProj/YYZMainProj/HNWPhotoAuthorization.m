//
//  HNWPhotoAuthorization.m
//  YYZMainProj
//
//  Created by Young on 2020/8/7.
//  Copyright © 2020 yangyongzheng. All rights reserved.
//

#import "HNWPhotoAuthorization.h"
#import <Photos/Photos.h>

@implementation HNWPhotoAuthorization

static void HNWAuthorizationSafeCallback(dispatch_block_t handler) {
    if (handler) {
        if (NSThread.isMainThread) {
            handler();
        } else {
            dispatch_async(dispatch_get_main_queue(), handler);
        }
    }
}



+ (void)requestAuthorization:(void (^)(HNWPhotoAuthorizationStatus))handler {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (handler) {
                HNWAuthorizationSafeCallback(^{
                    handler([self authorizationStatusWithStatus:status]);
                });
            }
        }];
    } else {
        if (handler) {
            HNWAuthorizationSafeCallback(^{
                handler([self authorizationStatusWithStatus:status]);
            });
        }
    }
}

+ (HNWPhotoAuthorizationStatus)authorizationStatusWithStatus:(PHAuthorizationStatus)status {
    HNWPhotoAuthorizationStatus toStatus = HNWPhotoAuthorizationStatusNotDetermined;
    switch (status) {
        case PHAuthorizationStatusNotDetermined:
            toStatus = HNWPhotoAuthorizationStatusNotDetermined;
            break;
        case PHAuthorizationStatusRestricted:
            toStatus = HNWPhotoAuthorizationStatusRestricted;
            break;
        case PHAuthorizationStatusDenied:
            toStatus = HNWPhotoAuthorizationStatusDenied;
            break;
        case PHAuthorizationStatusAuthorized:
            toStatus = HNWPhotoAuthorizationStatusAuthorized;
            break;
    }
    return toStatus;
}

@end
