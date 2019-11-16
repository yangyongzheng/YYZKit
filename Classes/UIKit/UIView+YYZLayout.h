
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (YYZLayout)

/** x */
@property (nonatomic) CGFloat yyz_minX;
@property (nonatomic) CGFloat yyz_midX;
@property (nonatomic) CGFloat yyz_maxX;

/** y */
@property (nonatomic) CGFloat yyz_minY;
@property (nonatomic) CGFloat yyz_midY;
@property (nonatomic) CGFloat yyz_maxY;

/** width */
@property (nonatomic) CGFloat yyz_width;

/** height */
@property (nonatomic) CGFloat yyz_height;

/** origin */
@property (nonatomic) CGPoint yyz_origin;

/** size */
@property (nonatomic) CGSize yyz_size;

@end

NS_ASSUME_NONNULL_END
