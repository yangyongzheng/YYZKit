//
//  SupplyZiZhiExampleViewController.m
//  YYZMainProj
//
//  Created by Young on 2020/8/8.
//  Copyright © 2020 yangyongzheng. All rights reserved.
//

#import "SupplyZiZhiExampleViewController.h"
#import "HNWImagePicker.h"
#import "HNWPhotoAuthorization.h"
#import "HNWMediaAuthorization.h"
#import <SDWebImage.h>

@interface SupplyZiZhiExampleViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *bottomShadowView;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;
@property (weak, nonatomic) IBOutlet UIImageView *themeImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *themeImageViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *themeImageViewTop;

@property (nonatomic, strong) SZiZhiExampleParam *paramInput;
@property (nonatomic) CGFloat imageReferHeight;
@end

@implementation SupplyZiZhiExampleViewController

#pragma mark - life
+ (SupplyZiZhiExampleViewController *)viewControllerWithParam:(SZiZhiExampleParam *)paramBody {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:NSBundle.mainBundle];
    SupplyZiZhiExampleViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SupplyZiZhiExampleViewController"];
    vc.paramInput = paramBody;
    vc.hidesBottomBarWhenPushed = YES;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.paramInput.pageTitle;
    self.view.backgroundColor = UIColor.blackColor;
    [self.actionButton setTitle:self.paramInput.actionTitle forState:UIControlStateNormal];
    self.actionButton.layer.cornerRadius = 20;
    self.actionButton.layer.masksToBounds = YES;
    
    if (self.paramInput.image) {
        [self refreshWithImage:self.paramInput.image];
    } else {
        NSURL *imageURL = [NSURL URLWithString:self.paramInput.imageURLString];
        [self.themeImageView sd_setImageWithURL:imageURL completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (!error) {
                [self refreshWithImage:image];
            }
        }];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    const CGFloat referBottomInset = self.bottomShadowView.bounds.size.height;
    if (fabs(self.scrollView.contentInset.bottom - referBottomInset) > FLT_EPSILON) {
        self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, referBottomInset, 0);
    }
    const CGFloat referHeight = self.scrollView.bounds.size.height - referBottomInset;
    if (fabs(self.imageReferHeight - referHeight) > FLT_EPSILON) {
        self.imageReferHeight = referHeight;
        [self refreshImageViewTopMargin];
    }
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

#pragma mark - other
- (void)refreshWithImage:(UIImage *)image {
    if (image && [image isKindOfClass:[UIImage class]] && image.size.width > 0 && image.size.height > 0) {
        self.themeImageView.hidden = NO;
        self.themeImageView.image = image;
        self.themeImageViewHeight.constant = image.size.height / image.size.width * UIScreen.mainScreen.bounds.size.width;
    } else {
        self.themeImageView.hidden = YES;
        self.themeImageView.image = nil;
        self.themeImageViewHeight.constant = 0;
    }
    [self refreshImageViewTopMargin];
}

- (void)refreshImageViewTopMargin {
    const CGFloat topMargin = (self.imageReferHeight - self.themeImageViewHeight.constant) / 2.0;
    self.themeImageViewTop.constant = MAX(floor(topMargin), 0);
}

- (void)handleCameraAction {
    [HNWMediaAuthorization requestVideoAuthorization:^(HNWMediaAuthorizationStatus status) {
        if (status == HNWMediaAuthorizationStatusHardwareNotSupported) {
            NSLog(@"检测不到相机设备");
        } else if (status == HNWMediaAuthorizationStatusAuthorized) {
            __weak typeof(self) weakSelf = self;
            [HNWImagePicker showCameraWithViewController:self cancelHandler:^(UIImagePickerController * _Nullable imagePickerController) {
                [imagePickerController dismissViewControllerAnimated:YES completion:nil];
            } selectImageHandler:^(UIImagePickerController * _Nonnull imagePickerController, UIImage * _Nonnull image) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf.navigationController popViewControllerAnimated:NO];
                [imagePickerController dismissViewControllerAnimated:YES completion:^{
                    [strongSelf selectImageCallback:image];
                }];
            }];
        } else {
            [UIApplication.sharedApplication openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
    }];
}

- (void)handlePhotoAction {
    __weak typeof(self) weakSelf = self;
    [HNWImagePicker showPhotoLibraryWithViewController:self cancelHandler:^(UIImagePickerController * _Nullable imagePickerController) {
        [imagePickerController dismissViewControllerAnimated:YES completion:nil];
    } selectImageHandler:^(UIImagePickerController * _Nonnull imagePickerController, UIImage * _Nonnull image) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.navigationController popViewControllerAnimated:NO];
        [imagePickerController dismissViewControllerAnimated:YES completion:^{
            [strongSelf selectImageCallback:image];
        }];
    }];
}

- (void)selectImageCallback:(UIImage *)image {
    if (self.paramInput.resultHandler) {
        self.paramInput.resultHandler(image);
    }
}

#pragma mark - action
- (IBAction)actionButtonDidClick:(UIButton *)sender {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil
                                                                     message:nil
                                                              preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取 消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍 照"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             [self handleCameraAction];
                                                         }];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从相册选择"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            [self handlePhotoAction];
                                                        }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:cameraAction];
    [alertVC addAction:photoAction];
    sender.userInteractionEnabled = NO;
    [self presentViewController:alertVC animated:YES completion:^{
        sender.userInteractionEnabled = YES;
    }];
}

@end



@implementation SZiZhiExampleParam

- (instancetype)init {
    self = [super init];
    if (self) {
        _pageTitle = @"示例图";
    }
    return self;
}

@end
