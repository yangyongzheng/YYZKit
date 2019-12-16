//
//  TabTestViewController.m
//  YYZKit
//
//  Created by 杨永正 on 2019/12/16.
//  Copyright © 2019 yoger. All rights reserved.
//

#import "TabTestViewController.h"
#import "YYZEqualWidthTabView.h"

@interface TabTestViewController () <YYZEqualWidthTabViewDelegate, YYZEqualWidthTabViewDataSource>
{
    YYZEqualWidthTabView *_tabView;
}
@end

@implementation TabTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"YYZEqualWidthTabView";
    self.view.backgroundColor = UIColor.whiteColor;
    CGRect tabViewFrame = CGRectMake(0, 15, YYZ_SCREEN_WIDTH, 44);
    _tabView = [[YYZEqualWidthTabView alloc] initWithFrame:tabViewFrame configuration:^(YYZEWTabConfiguration * _Nonnull configuration) {
        configuration.minimumWidth = 60;
        configuration.selectedTabItemIndex = 1;
        
        configuration.headerLineConfig.height = 1;
        configuration.footerLineConfig.height = 1;
    }];
    [self.view addSubview:_tabView];
    _tabView.delegate = self;
    _tabView.dataSource = self;
}

- (NSArray<NSString *> *)titlesForEqualWidthTabView:(YYZEqualWidthTabView *)tabView {
    return @[@"全部", @"军官证", @"学生证", @"身份证", @"无证移民"];
}

- (id<YYZEWTabItemBadgeProvider>)equalWidthTabView:(YYZEqualWidthTabView *)tabView
                       badgeProviderForItemAtIndex:(NSInteger)index {
    return index == 0 ? [YYZEWTabBadgePointProvider pointProvider] : nil;
}

- (void)equalWidthTabView:(YYZEqualWidthTabView *)tabView
     didSelectItemAtIndex:(NSInteger)index
            isUserTrigger:(BOOL)isUserTrigger {
    
}

@end
