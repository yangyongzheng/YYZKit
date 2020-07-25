//
//  DateTableViewCell.h
//  YYZMainProj
//
//  Created by Young on 2020/7/24.
//  Copyright © 2020 yangyongzheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DateTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UIStackView *stackView;
@end

NS_ASSUME_NONNULL_END
