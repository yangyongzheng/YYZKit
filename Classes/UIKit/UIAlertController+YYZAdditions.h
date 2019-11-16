
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertController (YYZAdditions)

/**
 创建提示弹框

 @param title 标题
 @param message 描述信息
 @param preferredStyle 样式
 @param cancelButtonTitle 取消按钮标题
 @param otherButtonTitles 其他按钮标题
 @param actionHandler 按钮点击回调，index：-1 取消按钮，>= 0对应otherButtonTitles数组下标按钮被点击
 @return UIAlertController 实例对象
 */
+ (instancetype)alertControllerWithTitle:(nullable NSString *)title
                                 message:(nullable NSString *)message
                          preferredStyle:(UIAlertControllerStyle)preferredStyle
                       cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                       otherButtonTitles:(nullable NSArray<NSString *> *)otherButtonTitles
                           actionHandler:(void(^)(NSInteger index))actionHandler;

@end

NS_ASSUME_NONNULL_END
