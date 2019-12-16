//
//  YYZEqualWidthTabView.h
//  YYZKit
//
//  Created by 杨永正 on 2019/12/8.
//  Copyright © 2019 yoger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYZEWTabConfiguration.h"
#import "YYZEWTabItemBadgeProvider.h"

NS_ASSUME_NONNULL_BEGIN

@class YYZEqualWidthTabView;

@protocol YYZEqualWidthTabViewDelegate <NSObject>

- (void)equalWidthTabView:(YYZEqualWidthTabView *)equalWidthTabView
     didSelectItemAtIndex:(NSInteger)index
            isUserTrigger:(BOOL)isUserTrigger;
@end

@protocol YYZEqualWidthTabViewDataSource <NSObject>
@required
- (nullable NSArray<NSString *> *)titlesForEqualWidthTabView:(YYZEqualWidthTabView *)equalWidthTabView;
@optional
- (nullable id <YYZEWTabItemBadgeProvider>)equalWidthTabView:(YYZEqualWidthTabView *)equalWidthTabView
                                 badgeProviderForItemAtIndex:(NSInteger)index;
@end

@interface YYZEqualWidthTabView : UIView

/** 便利构造方法 */
- (instancetype)initWithFrame:(CGRect)frame configuration:(void(^)(YYZEWTabConfiguration *configuration))configuration;

@property (nullable, nonatomic, weak) id<YYZEqualWidthTabViewDelegate> delegate;
@property (nullable, nonatomic, weak) id<YYZEqualWidthTabViewDataSource> dataSource;

- (void)selectTabItemAtIndex:(NSInteger)index
                    animated:(BOOL)animated
               isUserTrigger:(BOOL)isUserTrigger;

/** 当Tab标题及其角标发生变化时调用此API更新，如只更新Tab角标请调用 reloadTabBadges API. */
- (void)reloadData;

/** 更新Tab角标数据（注意不会更新Tab标题） */
- (void)reloadTabBadges;

@end

NS_ASSUME_NONNULL_END
