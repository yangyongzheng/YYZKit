//
//  SupplyZiZhiImageBrowserViewController.h
//  YYZMainProj
//
//  Created by Young on 2020/8/8.
//  Copyright © 2020 yangyongzheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SZiZhiImageBrowserParam : NSObject
@property (nonatomic, copy) NSString *pageTitle;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *imageURLString;

@property (nonatomic, copy) void (^ deleteHandler)(void);
@property (nonatomic, copy) void (^ changeImageHandler)(UIImage *image);
@end

@interface SupplyZiZhiImageBrowserViewController : UIViewController

+ (SupplyZiZhiImageBrowserViewController *)viewControllerWithParam:(SZiZhiImageBrowserParam *)paramBody;

@end

NS_ASSUME_NONNULL_END
