//
//  ViewController.m
//  YYZKit
//
//  Created by 杨永正 on 2019/7/18.
//  Copyright © 2019年 yoger. All rights reserved.
//

#import "ViewController.h"
#import "YYZKitHeader.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Home Page";
    self.view.backgroundColor = UIColor.yyz_hexString(@"66bb47");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"提示"
                                                                message:@"描述内容信息"
                                                         preferredStyle:UIAlertControllerStyleAlert
                                                      cancelButtonTitle:@"我知道了"
                                                      otherButtonTitles:@[@"联系客服"]
                                                          actionHandler:^(NSInteger index) {
                                                              if (index == -1) {
                                                                  
                                                              } else {
                                                                  
                                                              }
                                                          }];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
