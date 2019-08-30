
#import "YYZPhotoManager.h"

const NSInteger YYZPhotoAccessRestrictedErrorCode = -101001;
const NSInteger YYZPhotoSaveFailedErrorCode = -101002;

@implementation YYZPhotoManager

#pragma mark - Public
+ (instancetype)defaultManager {
    static YYZPhotoManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[[self class] alloc] init];
    });
    return manager;
}

- (void)requestSaveImages:(NSArray<UIImage *> *)images
             successBlock:(void (^)(void))successBlock
             failureBlock:(void (^)(NSError * _Nonnull))failureBlock {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        YYZPrivateSafeSyncMainQueue(^{
            if (status == PHAuthorizationStatusAuthorized) {
                [self yyz_saveImages:images
                        successBlock:successBlock
                        failureBlock:failureBlock];
            } else if (failureBlock) {
                failureBlock([self yyz_errorWithCode:YYZPhotoAccessRestrictedErrorCode]);
            }
        });
    }];
}

- (void)requestSaveImageAtFileURL:(NSURL *)fileURL
                     successBlock:(void (^)(void))successBlock
                     failureBlock:(void (^)(NSError * _Nonnull))failureBlock {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        YYZPrivateSafeSyncMainQueue(^{
            if (status == PHAuthorizationStatusAuthorized) {
                [self yyz_saveImageAtFileURL:fileURL
                                successBlock:successBlock
                                failureBlock:failureBlock];
            } else  if (failureBlock) {
                failureBlock([self yyz_errorWithCode:YYZPhotoAccessRestrictedErrorCode]);
            }
        });
    }];
}

- (void)requestSaveVideoAtFileURL:(NSURL *)fileURL
                     successBlock:(void (^)(void))successBlock
                     failureBlock:(void (^)(NSError * _Nonnull))failureBlock {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        YYZPrivateSafeSyncMainQueue(^{
            if (status == PHAuthorizationStatusAuthorized) {
                [self yyz_saveVideoAtFileURL:fileURL
                                successBlock:successBlock
                                failureBlock:failureBlock];
            } else if (failureBlock) {
                failureBlock([self yyz_errorWithCode:YYZPhotoAccessRestrictedErrorCode]);
            }
        });
    }];
}

#pragma mark - Private
- (void)yyz_saveImages:(NSArray<UIImage *> *)images
          successBlock:(void(^)(void))successBlock
          failureBlock:(void(^)(NSError *error))failureBlock {
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        for (UIImage *image in images) {
            [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        }
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        YYZPrivateSafeSyncMainQueue(^{
            if (success) {
                if (successBlock) {successBlock();}
            } else if (failureBlock) {
                failureBlock(error?error:[self yyz_errorWithCode:YYZPhotoSaveFailedErrorCode]);
            }
        });
    }];
}

- (void)yyz_saveImageAtFileURL:(NSURL *)fileURL
                  successBlock:(void(^)(void))successBlock
                  failureBlock:(void(^)(NSError *error))failureBlock {
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        [PHAssetChangeRequest creationRequestForAssetFromImageAtFileURL:fileURL];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        YYZPrivateSafeSyncMainQueue(^{
            if (success) {
                if (successBlock) {successBlock();}
            } else if (failureBlock) {
                failureBlock(error?error:[self yyz_errorWithCode:YYZPhotoSaveFailedErrorCode]);
            }
        });
    }];
}

- (void)yyz_saveVideoAtFileURL:(NSURL *)fileURL
                  successBlock:(void(^)(void))successBlock
                  failureBlock:(void(^)(NSError *error))failureBlock {
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:fileURL];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        YYZPrivateSafeSyncMainQueue(^{
            if (success) {
                if (successBlock) {successBlock();}
            } else if (failureBlock) {
                failureBlock(error?error:[self yyz_errorWithCode:YYZPhotoSaveFailedErrorCode]);
            }
        });
    }];
}

- (NSError *)yyz_errorWithCode:(NSInteger)errorCode {
    if (errorCode == YYZPhotoAccessRestrictedErrorCode) {
        return [NSError errorWithDomain:@"照片访问权限受限"
                                   code:YYZPhotoAccessRestrictedErrorCode
                               userInfo:@{NSLocalizedDescriptionKey:@"照片访问权限受限"}];
    } else {
        return [NSError errorWithDomain:@"保存失败"
                                   code:YYZPhotoSaveFailedErrorCode
                               userInfo:@{NSLocalizedDescriptionKey:@"保存失败"}];
    }
}

static void YYZPrivateSafeSyncMainQueue(dispatch_block_t block) {
    if (block) {
        if (NSThread.isMainThread) {
            block();
        } else {
            dispatch_sync(dispatch_get_main_queue(), block);
        }
    }
}

@end
