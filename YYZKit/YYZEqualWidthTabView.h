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

/**
 重新加载数据的作用域

 - YYZEqualWidthTabScopeAll: 重新加载 标题+角标
 - YYZEqualWidthTabScopeBadge: 重新加载 角标
 */
typedef NS_ENUM(NSInteger, YYZEqualWidthTabScope) {
    YYZEqualWidthTabScopeAll,
    YYZEqualWidthTabScopeBadge,
};

@class YYZEqualWidthTabView;

@protocol YYZEqualWidthTabViewDelegate <NSObject>

- (void)equalWidthTabView:(YYZEqualWidthTabView *)tabView
     didSelectItemAtIndex:(NSInteger)index
            isUserTrigger:(BOOL)isUserTrigger;
@end

@protocol YYZEqualWidthTabViewDataSource <NSObject>
@required
- (nullable NSArray<NSString *> *)titlesForEqualWidthTabView:(YYZEqualWidthTabView *)tabView;
@optional
- (nullable id <YYZEWTabItemBadgeProvider>)equalWidthTabView:(YYZEqualWidthTabView *)tabView
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

- (void)reloadDataWithScope:(YYZEqualWidthTabScope)scope;

@end

NS_ASSUME_NONNULL_END
