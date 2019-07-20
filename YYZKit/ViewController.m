//
//  ViewController.m
//  YYZKit
//
//  Created by 杨永正 on 2019/7/18.
//  Copyright © 2019年 yoger. All rights reserved.
//

#import "ViewController.h"
#import "YYZKitHeader.h"
#import "YYZSearchView.h"

@interface ViewController () <YYZSearchViewDelegate>
{
    YYZSearchView *searchView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *titleView = [[UIView alloc] initWithFrame:self.navigationController.navigationBar.bounds];
    searchView = [[YYZSearchView alloc] initWithFrame:CGRectMake(15, 0, titleView.frame.size.width-30, titleView.frame.size.height)];
    searchView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [titleView addSubview:searchView];
    [self.navigationController.navigationBar addSubview:titleView];
    searchView.delegate = self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    YYZSearchView *searchView = [[YYZSearchView alloc] initWithFrame:CGRectMake(15, 64, self.view.frame.size.width-30, 54)];
    searchView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:searchView];
}

- (void)searchView:(YYZSearchView *)searchView textFieldTextDidChange:(UITextField *)textField {
    NSLog(@"%@", textField.text);
}

@end
