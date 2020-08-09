//
//  HNWImagePicker.m
//  YYZMainProj
//
//  Created by Young on 2020/8/8.
//  Copyright © 2020 yangyongzheng. All rights reserved.
//

#import "HNWImagePicker.h"
#import <CoreServices/CoreServices.h>
#import <objc/runtime.h>

@interface UIImagePickerController (HNWPrivateResultHandler)
@property (nonatomic, copy) HNWImagePickerCancelHandler hnwPrivateCancelHandler;
@property (nonatomic, copy) HNWImagePickerSelectImageHandler hnwPrivateSelectImageHandler;
@end

@implementation UIImagePickerController (HNWPrivateResultHandler)

static const void * hnwPrivateCancelHandlerKey = &hnwPrivateCancelHandlerKey;
static const void * hnwPrivateSelectImageHandlerKey = &hnwPrivateSelectImageHandlerKey;

- (void)setHnwPrivateCancelHandler:(HNWImagePickerCancelHandler)hnwPrivateCancelHandler {
    objc_setAssociatedObject(self,
                             hnwPrivateCancelHandlerKey,
                             hnwPrivateCancelHandler,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (HNWImagePickerCancelHandler)hnwPrivateCancelHandler {
    return objc_getAssociatedObject(self, hnwPrivateCancelHandlerKey);
}

- (void)setHnwPrivateSelectImageHandler:(HNWImagePickerSelectImageHandler)hnwPrivateSelectImageHandler {
    objc_setAssociatedObject(self,
                             hnwPrivateSelectImageHandlerKey,
                             hnwPrivateSelectImageHandler,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (HNWImagePickerSelectImageHandler)hnwPrivateSelectImageHandler {
    return objc_getAssociatedObject(self, hnwPrivateSelectImageHandlerKey);
}

@end



@interface HNWImagePicker () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation HNWImagePicker

- (void)presentPhotoLibraryWithViewController:(UIViewController *)presentingViewController
                                cancelHandler:(HNWImagePickerCancelHandler)cancelHandler
                           selectImageHandler:(HNWImagePickerSelectImageHandler)selectImageHandler {
    if (presentingViewController && [presentingViewController isKindOfClass:[UIViewController class]]) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.hnwPrivateCancelHandler = cancelHandler;
            imagePickerController.hnwPrivateSelectImageHandler = selectImageHandler;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePickerController.mediaTypes = @[(__bridge NSString *)kUTTypeImage];
            imagePickerController.allowsEditing = NO;
            imagePickerController.delegate = self;
            imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
            imagePickerController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            [presentingViewController presentViewController:imagePickerController animated:YES completion:nil];
        } else {
            if (cancelHandler) {cancelHandler(nil);}
        }
    } else {
        if (cancelHandler) {cancelHandler(nil);}
    }
}

- (void)presentCameraWithViewController:(UIViewController *)presentingViewController
                          cancelHandler:(HNWImagePickerCancelHandler)cancelHandler
                     selectImageHandler:(HNWImagePickerSelectImageHandler)selectImageHandler {
    if (presentingViewController && [presentingViewController isKindOfClass:[UIViewController class]]) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.hnwPrivateCancelHandler = cancelHandler;
            imagePickerController.hnwPrivateSelectImageHandler = selectImageHandler;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePickerController.mediaTypes = @[(__bridge NSString *)kUTTypeImage];
            imagePickerController.allowsEditing = NO;
            imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
            imagePickerController.delegate = self;
            imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
            imagePickerController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            [presentingViewController presentViewController:imagePickerController animated:YES completion:nil];
        } else {
            if (cancelHandler) {cancelHandler(nil);}
        }
    } else {
        if (cancelHandler) {cancelHandler(nil);}
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    if (picker.hnwPrivateSelectImageHandler) {
        picker.hnwPrivateSelectImageHandler(picker, info[UIImagePickerControllerOriginalImage]);
    } else {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if (picker.hnwPrivateCancelHandler) {
        picker.hnwPrivateCancelHandler(picker);
    } else {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
