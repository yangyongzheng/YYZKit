//
//  ViewController.m
//  YYZKit
//
//  Created by 杨永正 on 2019/7/18.
//  Copyright © 2019年 yoger. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
#import "InputPasswordView.h"

#import "YYZKitHeader.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Home Page";
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = UIColor.redColor;
    [self.view addSubview:view];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[[NSLayoutConstraint constraintWithItem:view
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.topLayoutGuide
                                                                           attribute:NSLayoutAttributeBottom
                                                                          multiplier:1.0
                                                                            constant:0],
                                              [NSLayoutConstraint constraintWithItem:view
                                                                           attribute:NSLayoutAttributeLeading
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.view
                                                                           attribute:NSLayoutAttributeLeading
                                                                          multiplier:1.0
                                                                            constant:0],
                                              [NSLayoutConstraint constraintWithItem:view
                                                                           attribute:NSLayoutAttributeBottom
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.bottomLayoutGuide
                                                                           attribute:NSLayoutAttributeTop
                                                                          multiplier:1.0
                                                                            constant:0],
                                              [NSLayoutConstraint constraintWithItem:view
                                                                           attribute:NSLayoutAttributeTrailing
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.view
                                                                           attribute:NSLayoutAttributeTrailing
                                                                          multiplier:1.0
                                                                            constant:0],
                                              ]];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

@end
