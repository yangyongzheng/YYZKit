//
//  YYZPhotoManager.m
//  YYZKit
//
//  Created by yangyongzheng on 2019/8/2.
//  Copyright © 2019 yoger. All rights reserved.
//

#import "YYZPhotoManager.h"

@implementation YYZPhotoManager

- (void)requestSavePhotoToAlbum:(NSArray<UIImage *> *)images {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            [self save];
        } else if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
            
        }
    }];
}

- (void)save {
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        UIImageWriteToSavedPhotosAlbum(<#UIImage * _Nonnull image#>, <#id  _Nullable completionTarget#>, <#SEL  _Nullable completionSelector#>, <#void * _Nullable contextInfo#>)
    } completionHandler:<#^(BOOL success, NSError * _Nullable error)completionHandler#>]
}

@end
