//
//  HNWImagePicker.h
//  YYZMainProj
//
//  Created by Young on 2020/8/8.
//  Copyright © 2020 yangyongzheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^HNWImagePickerCancelHandler)(UIImagePickerController * _Nullable imagePickerController);
typedef void(^HNWImagePickerSelectImageHandler)(UIImagePickerController *imagePickerController, UIImage *image);

@interface HNWImagePicker : NSObject

/// 从相册选择图片，调用者负责 dismiss image picker controller
- (void)presentPhotoLibraryWithViewController:(UIViewController *)presentingViewController
                                cancelHandler:(HNWImagePickerCancelHandler)cancelHandler
                           selectImageHandler:(HNWImagePickerSelectImageHandler)selectImageHandler;

/// 拍照，调用者负责 dismiss image picker controller
- (void)presentCameraWithViewController:(UIViewController *)presentingViewController
                          cancelHandler:(HNWImagePickerCancelHandler)cancelHandler
                     selectImageHandler:(HNWImagePickerSelectImageHandler)selectImageHandler;

@end

NS_ASSUME_NONNULL_END
