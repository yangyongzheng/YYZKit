//
//  HNWMediaAuthorization.m
//  YYZMainProj
//
//  Created by Young on 2020/8/8.
//  Copyright © 2020 yangyongzheng. All rights reserved.
//

#import "HNWMediaAuthorization.h"
#import <AVFoundation/AVFoundation.h>

@implementation HNWMediaAuthorization

static void HNWAuthorizationSafeCallback(dispatch_block_t handler) {
    if (handler) {
        if (NSThread.isMainThread) {
            handler();
        } else {
            dispatch_async(dispatch_get_main_queue(), handler);
        }
    }
}



+ (void)requestVideoAuthorization:(void (^)(HNWMediaAuthorizationStatus))handler {
    [self requestAuthorizationWithMediaType:AVMediaTypeVideo completionHandler:handler];
}

+ (void)requestAudioAuthorization:(void (^)(HNWMediaAuthorizationStatus))handler {
    [self requestAuthorizationWithMediaType:AVMediaTypeAudio completionHandler:handler];
}

+ (void)requestAuthorizationWithMediaType:(AVMediaType)mediaType completionHandler:(void (^)(HNWMediaAuthorizationStatus))handler {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:mediaType];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
                if (handler) {
                    HNWAuthorizationSafeCallback(^{
                        handler(granted ? HNWMediaAuthorizationStatusAuthorized : HNWMediaAuthorizationStatusDenied);
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
    } else {
        if (handler) {
            HNWAuthorizationSafeCallback(^{
                handler(HNWMediaAuthorizationStatusHardwareNotSupported);
            });
        }
    }
}

+ (HNWMediaAuthorizationStatus)authorizationStatusWithStatus:(AVAuthorizationStatus)status {
    HNWMediaAuthorizationStatus toStatus = HNWMediaAuthorizationStatusNotDetermined;
    switch (status) {
        case AVAuthorizationStatusNotDetermined:
            toStatus = HNWMediaAuthorizationStatusNotDetermined;
            break;
        case AVAuthorizationStatusRestricted:
            toStatus = HNWMediaAuthorizationStatusRestricted;
            break;
        case AVAuthorizationStatusDenied:
            toStatus = HNWMediaAuthorizationStatusDenied;
            break;
        case AVAuthorizationStatusAuthorized:
            toStatus = HNWMediaAuthorizationStatusAuthorized;
            break;
    }
    return toStatus;
}

@end
