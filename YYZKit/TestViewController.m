//
//  TestViewController.m
//  YYZKit
//
//  Created by 杨永正 on 2019/8/25.
//  Copyright © 2019 yoger. All rights reserved.
//

#import "TestViewController.h"
#import "YYZKitHeader.h"

@interface TestViewController () <YYZKeyboardMonitorDelegate>
{
    YYZTimerHolder *_timerHolder;
}
@end

@implementation TestViewController

+ (TestViewController *)testViewController {
    TestViewController *vc = [[TestViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"测试";
    [YYZKeyboardMonitor addDelegate:self];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    __weak typeof(self) weakSelf = self;
    _timerHolder = [[YYZTimerHolder alloc] init];
    [_timerHolder scheduledTimerWithCountdown:6000
                         intervalMilliseconds:1000
                                        block:^(YYZTimerHolder * _Nonnull timerHolder, long currentMilliseconds) {
                                            __strong typeof(weakSelf) strongSelf = weakSelf;
                                            NSLog(@"%@-%ld", strongSelf, currentMilliseconds/1000);
                                        }];
    [_timerHolder fire];
}

- (void)keyboardMonitor:(YYZKeyboardMonitor *)keyboardMonitor keyboardWillShow:(YYZKeyboardInfo *)info {
    
}

- (void)keyboardMonitor:(YYZKeyboardMonitor *)keyboardMonitor keyboardWillHide:(YYZKeyboardInfo *)info {
    
}

@end
