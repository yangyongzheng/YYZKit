
#import "UIView+YYZLayout.h"

@implementation UIView (YYZLayout)

#pragma mark - frame
- (void)setYyz_minX:(CGFloat)yyz_minX {
    CGRect tempFrame = self.frame;
    tempFrame.origin.x = yyz_minX;
    self.frame = tempFrame;
}

- (CGFloat)yyz_minX {
    return CGRectGetMinX(self.frame);
}

- (void)setYyz_midX:(CGFloat)yyz_midX {
    self.center = CGPointMake(yyz_midX, self.center.y);
}

- (CGFloat)yyz_midX {
    return CGRectGetMidX(self.frame);
}

- (void)setYyz_maxX:(CGFloat)yyz_maxX {
    CGRect tempFrame = self.frame;
    tempFrame.origin.x = yyz_maxX - tempFrame.size.width;
    self.frame = tempFrame;
}

- (CGFloat)yyz_maxX {
    return CGRectGetMaxX(self.frame);
}

- (void)setYyz_minY:(CGFloat)yyz_minY {
    CGRect tempFrame = self.frame;
    tempFrame.origin.y = yyz_minY;
    self.frame = tempFrame;
}

- (CGFloat)yyz_minY {
    return CGRectGetMinY(self.frame);
}

- (void)setYyz_midY:(CGFloat)yyz_midY {
    self.center = CGPointMake(self.center.x, yyz_midY);
}

- (CGFloat)yyz_midY {
    return CGRectGetMidY(self.frame);
}

- (void)setYyz_maxY:(CGFloat)yyz_maxY {
    CGRect tempFrame = self.frame;
    tempFrame.origin.y = yyz_maxY - tempFrame.size.height;
    self.frame = tempFrame;
}

- (CGFloat)yyz_maxY {
    return CGRectGetMaxY(self.frame);
}

- (void)setYyz_width:(CGFloat)yyz_width {
    CGRect tempFrame = self.frame;
    tempFrame.size.width = yyz_width;
    self.frame = tempFrame;
}

- (CGFloat)yyz_width {
    return CGRectGetWidth(self.frame);
}

- (void)setYyz_height:(CGFloat)yyz_height {
    CGRect tempFrame = self.frame;
    tempFrame.size.height = yyz_height;
    self.frame = tempFrame;
}

- (CGFloat)yyz_height {
    return CGRectGetHeight(self.frame);
}

- (void)setYyz_origin:(CGPoint)yyz_origin {
    CGRect tempFrame = self.frame;
    tempFrame.origin = yyz_origin;
    self.frame = tempFrame;
}

- (CGPoint)yyz_origin {
    return self.frame.origin;
}

- (void)setYyz_size:(CGSize)yyz_size {
    CGRect tempFrame = self.frame;
    tempFrame.size = yyz_size;
    self.frame = tempFrame;
}

- (CGSize)yyz_size {
    return self.frame.size;
}

@end
