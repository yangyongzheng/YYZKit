//
//  ViewController.m
//  YYZKit
//
//  Created by 杨永正 on 2019/7/18.
//  Copyright © 2019年 yoger. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"

#import "YYZKitHeader.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Home Page";
    NSLog(@"%f", UIDevice.yyz_safeAreaBottomInset);
    NSLog(@"%lld", UIDevice.yyz_compileTimestamp);
    YYZSearchView *searchView = [[YYZSearchView alloc] initWithFrame:CGRectMake(15, 100, UIDevice.yyz_screenWidth-30, 30)];
    [self.view addSubview:searchView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSURL *imageURL = [NSURL URLWithString:@"http://gss0.baidu.com/-4o3dSag_xI4khGko9WTAnF6hhy/zhidao/pic/item/730e0cf3d7ca7bcb96e256f5bc096b63f724a84b.jpg"];
    [[NSURLSession.sharedSession downloadTaskWithURL:imageURL completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error && location) {
            NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:response.suggestedFilename];
            NSURL *fileURL = [NSURL fileURLWithPath:filePath];
            NSError *aError = nil;
            [NSFileManager.defaultManager moveItemAtURL:location toURL:fileURL error:&aError];
            dispatch_sync(dispatch_get_main_queue(), ^{
                [YYZPhotoManager.defaultManager requestSaveImageAtFileURL:fileURL
                                                             successBlock:^{
                                                                 NSLog(@"1");
                                                             } failureBlock:^(NSError * _Nonnull error) {
                                                                 NSLog(@"0");
                                                             }];
            });
        } else {
            NSLog(@"下载图片失败");
        }
    }] resume];
    
    TestViewController *vc = [TestViewController yyz_instantiateFromStoryboard];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
