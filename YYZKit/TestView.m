//
//  TestView.m
//  YYZKit
//
//  Created by 杨永正 on 2019/9/22.
//  Copyright © 2019 yoger. All rights reserved.
//

#import "TestView.h"

@implementation TestView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = UIColor.clearColor;
    self.layer.cornerRadius = 10;
    self.layer.borderWidth = 5;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = UIColor.redColor.CGColor;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(50, 0)];
    [linePath addLineToPoint:CGPointMake(50, 60)];
    
    linePath.lineWidth = 5;
    [UIColor.redColor setStroke];
    [linePath stroke];
}

@end
