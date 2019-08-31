
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYZGradientMaker : NSObject

/** 渐变色数组，默认值 nil */
@property (nullable, nonatomic, copy) NSArray<UIColor *> *colors;

/** 每个渐变停止的位置数组，默认值 nil。如果 locations 为 nil，则在整个范围内均匀分布 */
@property (nullable, nonatomic, copy) NSArray<NSNumber *> *locations;

/**
 在图层坐标空间中绘制时渐变的起点，默认值为[0.0, 0.5].
 
 注：[0.0, 0.0] is the bottom-left corner of the layer, [1.0, 1.0] is the top-right corner.
 */
@property (nonatomic) CGPoint startPoint;

/**
 在图层坐标空间中绘制时渐变的终点，默认值[1.0, 0.5].
 
 注：[0.0, 0.0] is the bottom-left corner of the layer, [1.0, 1.0] is the top-right corner.
 */
@property (nonatomic) CGPoint endPoint;

/** 图层绘制的渐变样式，默认值 kCAGradientLayerAxial，即轴向梯度（也称为线性梯度）*/
@property (nonatomic, copy) CAGradientLayerType type;

@end



/** 渐变图层视图，默认不允许交互，即其 `userInteractionEnabled` 为 NO */
@interface YYZGradientView : UIView

/**
 设置渐变

 @param block 渐变配置Block
 */
- (void)makeGradient:(void (NS_NOESCAPE ^)(YYZGradientMaker *maker))block;

@end



@interface UIView (YYZGradient)

/**
 设置渐变层（可多次调用此方法改变渐变色）。
 
 创建一个 `YYZGradientView` 对象实现渐变，插入到self的子视图中index为0的位置。
 
 @param block 渐变配置Block
 */
- (void)yyz_makeGradient:(void (NS_NOESCAPE ^)(YYZGradientMaker *maker))block;

@end

NS_ASSUME_NONNULL_END
