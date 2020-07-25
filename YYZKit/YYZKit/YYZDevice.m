//
//  YYZDevice.m
//  YYZKit
//
//  Created by Young on 2020/7/21.
//  Copyright © 2020 Young. All rights reserved.
//

#import "YYZDevice.h"

@implementation YYZDevice

+ (CGFloat)screenWidth {
    return UIScreen.mainScreen.bounds.size.width;
}

+ (CGFloat)screenHeight {
    return UIScreen.mainScreen.bounds.size.height;
}

@end
