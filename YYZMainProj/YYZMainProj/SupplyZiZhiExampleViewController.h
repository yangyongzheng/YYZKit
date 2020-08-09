//
//  SupplyZiZhiExampleViewController.h
//  YYZMainProj
//
//  Created by Young on 2020/8/8.
//  Copyright © 2020 yangyongzheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SZiZhiExampleParam : NSObject
@property (nonatomic, copy) NSString *pageTitle;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *imageURLString;
@property (nonatomic, copy) NSString *actionTitle;

@property (nonatomic, copy) void (^ resultHandler)(UIImage *image);
@end

@interface SupplyZiZhiExampleViewController : UIViewController

+ (SupplyZiZhiExampleViewController *)viewControllerWithParam:(SZiZhiExampleParam *)paramBody;

@end

NS_ASSUME_NONNULL_END
