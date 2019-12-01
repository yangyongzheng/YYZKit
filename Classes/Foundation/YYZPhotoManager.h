
#import <Photos/Photos.h>
#import "YYZKitDefines.h"

NS_ASSUME_NONNULL_BEGIN

YYZKIT_EXTERN const NSInteger YYZPhotoAccessRestrictedErrorCode; // 照片访问权限受限错误Code

@interface YYZPhotoManager : NSObject

+ (instancetype)defaultManager;

- (void)requestSaveImages:(NSArray<UIImage *> *)images
             successBlock:(void (^)(void))successBlock
             failureBlock:(void (^)(NSError *error))failureBlock;

- (void)requestSaveImageAtFileURL:(NSURL *)fileURL
                     successBlock:(void (^)(void))successBlock
                     failureBlock:(void (^)(NSError *error))failureBlock;

- (void)requestSaveVideoAtFileURL:(NSURL *)fileURL
                     successBlock:(void (^)(void))successBlock
                     failureBlock:(void (^)(NSError *error))failureBlock;

@end

NS_ASSUME_NONNULL_END
