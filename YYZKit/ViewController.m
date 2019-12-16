//
//  ViewController.m
//  YYZKit
//
//  Created by 杨永正 on 2019/7/18.
//  Copyright © 2019年 yoger. All rights reserved.
//

#import "ViewController.h"
#import "YYZEqualWidthTabView.h"

@interface ViewController () <YYZEqualWidthTabViewDelegate, YYZEqualWidthTabViewDataSource> {
    YYZEqualWidthTabView *_tabView;
    NSMutableArray *_titleArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Home Page";
    self.view.backgroundColor = UIColor.whiteColor;
    _titleArray = [NSMutableArray array];
    [_titleArray addObjectsFromArray:@[@"全部", @"正营销", @"已下架", @"被驳回"]];
    [self resetTabView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_tabView reloadTabBadges];
}

- (void)resetTabView {
    _tabView = [[YYZEqualWidthTabView alloc] initWithFrame:CGRectMake(20, 200, 260, 44)
                                             configuration:^(YYZEWTabConfiguration * _Nonnull configuration) {
                                                 configuration.headerLineConfig.height = 1;
                                                 configuration.headerLineConfig.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
                                                 configuration.footerLineConfig.height = 1;
                                                 configuration.footerLineConfig.edgeInsets = UIEdgeInsetsMake(0, 0, 1, 0);
                                                 configuration.minimumWidth = 60;
                                                 configuration.selectedTabItemIndex = 2;
                                             }];
    _tabView.delegate = self;
    _tabView.dataSource = self;
    [self.view addSubview:_tabView];
}

- (NSArray<NSString *> *)titlesForEqualWidthTabView:(YYZEqualWidthTabView *)equalWidthTabView {
    return _titleArray;
}

- (id<YYZEWTabItemBadgeProvider>)equalWidthTabView:(YYZEqualWidthTabView *)equalWidthTabView badgeProviderForItemAtIndex:(NSInteger)index {
    if (index == 0) {
        return arc4random() % 2 == 0 ? [YYZEWTabBadgeTextProvider providerWithText:@"99+"] : nil;
    } else if (index == 1) {
        return arc4random() % 2 == 0 ? [YYZEWTabBadgePointProvider pointProvider] : nil;
    } else if (index == 2) {
        return [YYZEWTabBadgeImageProvider providerWithImage:[UIImage imageNamed:@"icon_new_bg_orange"] imageSize:CGSizeMake(16, 16)];
    } else {
        return nil;
    }
}

- (void)equalWidthTabView:(YYZEqualWidthTabView *)equalWidthTabView
     didSelectItemAtIndex:(NSInteger)index
            isUserTrigger:(BOOL)isUserTrigger {
    
}

@end
