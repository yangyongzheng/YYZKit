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

@interface HNWPrivateImagePickerHelper : NSObject <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, copy) HNWImagePickerCancelHandler privateCancelHandler;
@property (nonatomic, copy) HNWImagePickerSelectImageHandler privateSelectImageHandler;
@end

@implementation HNWPrivateImagePickerHelper

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    if (self.privateSelectImageHandler) {
        self.privateSelectImageHandler(picker, info[UIImagePickerControllerOriginalImage]);
    } else {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if (self.privateCancelHandler) {
        self.privateCancelHandler(picker);
    } else {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

@end

@interface UIImagePickerController (HNWPrivateImagePickerHelper)
@property (nonatomic, strong) HNWPrivateImagePickerHelper *privateImagePickerHelper;
@end

@implementation UIImagePickerController (HNWPrivateImagePickerHelper)

static const void * privateImagePickerHelperKey = &privateImagePickerHelperKey;

- (void)setPrivateImagePickerHelper:(HNWPrivateImagePickerHelper *)privateImagePickerHelper {
    objc_setAssociatedObject(self,
                             privateImagePickerHelperKey,
                             privateImagePickerHelper,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (HNWPrivateImagePickerHelper *)privateImagePickerHelper {
    return objc_getAssociatedObject(self, privateImagePickerHelperKey);
}

@end



@implementation HNWImagePicker

+ (void)showPhotoLibraryWithViewController:(UIViewController *)presentingViewController
                             cancelHandler:(HNWImagePickerCancelHandler)cancelHandler
                        selectImageHandler:(HNWImagePickerSelectImageHandler)selectImageHandler {
    if (presentingViewController && [presentingViewController isKindOfClass:[UIViewController class]]) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            HNWPrivateImagePickerHelper *imagePickerHelper = [[HNWPrivateImagePickerHelper alloc] init];
            imagePickerHelper.privateCancelHandler = cancelHandler;
            imagePickerHelper.privateSelectImageHandler = selectImageHandler;
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.privateImagePickerHelper = imagePickerHelper;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePickerController.mediaTypes = @[(__bridge NSString *)kUTTypeImage];
            imagePickerController.allowsEditing = NO;
            imagePickerController.delegate = imagePickerHelper;
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

+ (void)showCameraWithViewController:(UIViewController *)presentingViewController
                       cancelHandler:(HNWImagePickerCancelHandler)cancelHandler
                  selectImageHandler:(HNWImagePickerSelectImageHandler)selectImageHandler {
    if (presentingViewController && [presentingViewController isKindOfClass:[UIViewController class]]) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            HNWPrivateImagePickerHelper *imagePickerHelper = [[HNWPrivateImagePickerHelper alloc] init];
            imagePickerHelper.privateCancelHandler = cancelHandler;
            imagePickerHelper.privateSelectImageHandler = selectImageHandler;
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.privateImagePickerHelper = imagePickerHelper;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePickerController.mediaTypes = @[(__bridge NSString *)kUTTypeImage];
            imagePickerController.allowsEditing = NO;
            imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
            imagePickerController.delegate = imagePickerHelper;
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

@end
