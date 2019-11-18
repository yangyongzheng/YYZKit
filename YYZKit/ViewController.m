//
//  ViewController.m
//  YYZKit
//
//  Created by 杨永正 on 2019/7/18.
//  Copyright © 2019年 yoger. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
#import "UIViewController+YYZAlert.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Home Page";
    self.view.backgroundColor = UIColor.yyz_hexString(@"39BF3E");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {    
    TestViewController *vc2 = TestViewController.testViewController;
    vc2.view.frame = CGRectMake(0, 0, YYZ_SCREEN_WIDTH-60, 300);
//    [self yyz_showFormSheetController:vc2 completion:^{}];
    [self yyz_showAlertController:vc2 completion:^{}];
}

@end
