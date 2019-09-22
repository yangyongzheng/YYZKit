//
//  InputPasswordView.m
//  YYZKit
//
//  Created by 杨永正 on 2019/9/22.
//  Copyright © 2019 yoger. All rights reserved.
//

#import "InputPasswordView.h"

@implementation InputPasswordView

+ (InputPasswordView *)passwordView {
    InputPasswordView *view = [[InputPasswordView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = UIColor.whiteColor;
    view.contentMode = UIViewContentModeRedraw;
    view.layer.cornerRadius = 5;
    view.layer.borderColor = UIColor.blackColor.CGColor;
    view.layer.borderWidth = 1;
    view.layer.masksToBounds = YES;
    view.clipsToBounds = YES;
    return view;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    for (int idx = 1; idx < 6; idx++) {
        const CGFloat offsetX = round(CGRectGetWidth(rect)/6.0) * idx - 1.0 / UIScreen.mainScreen.scale;
        CGContextMoveToPoint(contextRef, offsetX, 0);
        CGContextAddLineToPoint(contextRef, offsetX, CGRectGetHeight(rect));
    }
    CGContextSetLineWidth(contextRef, 1);
    CGContextSetLineCap(contextRef, kCGLineCapButt);
    CGContextSetLineJoin(contextRef, kCGLineJoinMiter);
    CGContextSetStrokeColorWithColor(contextRef, UIColor.blackColor.CGColor);
    CGContextStrokePath(contextRef);
}

@end
