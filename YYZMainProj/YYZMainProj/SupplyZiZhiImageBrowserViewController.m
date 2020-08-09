//
//  SupplyZiZhiImageBrowserViewController.m
//  YYZMainProj
//
//  Created by Young on 2020/8/8.
//  Copyright © 2020 yangyongzheng. All rights reserved.
//

#import "SupplyZiZhiImageBrowserViewController.h"
#import "HNWImagePicker.h"
#import "HNWPhotoAuthorization.h"
#import "HNWMediaAuthorization.h"
#import <SDWebImage.h>

@interface SupplyZiZhiImageBrowserViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *changeView;
@property (weak, nonatomic) IBOutlet UIImageView *themeImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *themeImageViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *themeImageViewTop;

@property (nonatomic, strong) HNWImagePicker *imagePicker;
@property (nonatomic, strong) SZiZhiImageBrowserParam *paramInput;
@property (nonatomic) CGFloat imageReferHeight;
@end

@implementation SupplyZiZhiImageBrowserViewController

#pragma mark - life
+ (SupplyZiZhiImageBrowserViewController *)viewControllerWithParam:(SZiZhiImageBrowserParam *)paramBody {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:NSBundle.mainBundle];
    SupplyZiZhiImageBrowserViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SupplyZiZhiImageBrowserViewController"];
    vc.paramInput = paramBody;
    vc.hidesBottomBarWhenPushed = YES;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.paramInput.pageTitle;
    self.view.backgroundColor = UIColor.blackColor;
    self.changeView.layer.cornerRadius = 18;
    self.changeView.layer.masksToBounds = YES;
    self.changeView.layer.borderWidth = 1;
    self.changeView.layer.borderColor = UIColor.whiteColor.CGColor;
    UITapGestureRecognizer *changeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleChangeTapGesture:)];
    [self.changeView addGestureRecognizer:changeTap];
    
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
    
    const CGFloat referBottomMargin = self.changeView.bounds.size.height + self.bottomLayoutGuide.length + 45;
    if (fabs(self.scrollView.contentInset.bottom - referBottomMargin - 30) > FLT_EPSILON) { // 30为更换按钮与图片顶部间距
        self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, referBottomMargin+30, 0);
    }
    const CGFloat referHeight = self.scrollView.bounds.size.height - referBottomMargin;
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
            [self.imagePicker presentCameraWithViewController:self cancelHandler:^(UIImagePickerController * _Nullable imagePickerController) {
                [imagePickerController dismissViewControllerAnimated:YES completion:nil];
            } selectImageHandler:^(UIImagePickerController * _Nonnull imagePickerController, UIImage * _Nullable image) {
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
    [self.imagePicker presentPhotoLibraryWithViewController:self cancelHandler:^(UIImagePickerController * _Nullable imagePickerController) {
        [imagePickerController dismissViewControllerAnimated:YES completion:nil];
    } selectImageHandler:^(UIImagePickerController * _Nonnull imagePickerController, UIImage * _Nullable image) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.navigationController popViewControllerAnimated:NO];
        [imagePickerController dismissViewControllerAnimated:YES completion:^{
            [strongSelf selectImageCallback:image];
        }];
    }];
}

- (void)selectImageCallback:(UIImage *)image {
    if (self.paramInput.changeImageHandler) {
        self.paramInput.changeImageHandler(image);
    }
}

#pragma mark - action
- (IBAction)deleteBarButtonItemDidClick:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    if (self.paramInput.deleteHandler) {
        self.paramInput.deleteHandler();
    }
}

- (void)handleChangeTapGesture:(UITapGestureRecognizer *)tap {
    if (tap.state != UIGestureRecognizerStateEnded) {
        return;
    }
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
    tap.enabled = NO;
    [self presentViewController:alertVC animated:YES completion:^{
        tap.enabled = YES;
    }];
}

#pragma mark - setter or getter
- (HNWImagePicker *)imagePicker {
    if (!_imagePicker) {
        _imagePicker = [[HNWImagePicker alloc] init];
    }
    return _imagePicker;
}

@end



@implementation SZiZhiImageBrowserParam

- (instancetype)init {
    self = [super init];
    if (self) {
        _pageTitle = @"许可证";
    }
    return self;
}

@end
