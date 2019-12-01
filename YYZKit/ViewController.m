//
//  ViewController.m
//  YYZKit
//
//  Created by 杨永正 on 2019/7/18.
//  Copyright © 2019年 yoger. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
#import "YYZAlertManager.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Home Page";
    self.view.backgroundColor = UIColor.yyz_hexString(@"39BF3E");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"%@", UIApplication.sharedApplication.windows);
//    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"提示"
//                                                                message:@"描述内容信息"
//                                                         preferredStyle:UIAlertControllerStyleAlert
//                                                      cancelButtonTitle:@"我知道了"
//                                                      otherButtonTitles:@[@"联系客服"]
//                                                          actionHandler:^(NSInteger index) {
//                                                              if (index == -1) {
//
//                                                              } else {
//
//                                                              }
//                                                          }];
//    [self presentViewController:vc animated:YES completion:nil];
//    NSLog(@"%@", UIApplication.sharedApplication.windows);
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSLog(@"%@", UIApplication.sharedApplication.windows);
//    });
    
//    TestViewController *vc = TestViewController.testViewController;
//    vc.view.frame = CGRectMake(0, 0, 300, 250);
//    [YYZAlertManager showAlertController:vc presentingController:self completion:nil];
    
    TestViewController *vc2 = TestViewController.testViewController;
    vc2.view.frame = CGRectMake(0, 0, 320, 250);
    [YYZAlertManager showAlertController:vc2 presentingController:self completion:^{
        
    }];
}

@end
