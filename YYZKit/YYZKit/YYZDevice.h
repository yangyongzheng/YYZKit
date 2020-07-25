//
//  YYZDevice.h
//  YYZKit
//
//  Created by Young on 2020/7/21.
//  Copyright © 2020 Young. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYZDevice : NSObject

@property (class, nonatomic, readonly) CGFloat screenWidth;
@property (class, nonatomic, readonly) CGFloat screenHeight;

@end

NS_ASSUME_NONNULL_END
