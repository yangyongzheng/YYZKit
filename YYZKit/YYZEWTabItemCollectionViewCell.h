//
//  YYZEWTabItemCollectionViewCell.h
//  YYZKit
//
//  Created by 杨永正 on 2019/12/10.
//  Copyright © 2019 yoger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYZEWTabItemBadgeProvider.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYZEWTabItemCollectionViewCell : UICollectionViewCell

@property (nonatomic, readonly, strong) UILabel *titleLabel;
@property (nonatomic, readonly, strong) UIImageView *badgeImageView;
@property (nonatomic, readonly, strong) UIButton *badgeTextView;

- (void)resetBadgeValue:(id<YYZEWTabItemBadgeProvider>)badgeProvider;

@end

NS_ASSUME_NONNULL_END
