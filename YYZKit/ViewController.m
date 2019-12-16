//
//  ViewController.m
//  YYZKit
//
//  Created by 杨永正 on 2019/7/18.
//  Copyright © 2019年 yoger. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"首页";
    self.view.backgroundColor = UIColor.greenColor;
    
    UIBarButtonItem *enter = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                           target:self
                                                                           action:@selector(rightBarButtonItemActionCallback:)];
    enter.tintColor = UIColor.redColor;
    self.navigationItem.rightBarButtonItem = enter;
}

- (void)rightBarButtonItemActionCallback:(UIBarButtonItem *)item {
    TestViewController *vc = TestViewController.testViewController;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
