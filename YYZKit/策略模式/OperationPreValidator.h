//
//  策略模式
//  操作预验证策略的基类
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OperationPreValidator : NSObject

/**
 验证操作

 @return 验证通过返回 YES，否则返回 NO
 */
- (BOOL)validateOperation;


/**
 当 validateOperation 返回 NO 的时候，可读取 errorMessage 获取验证不通过信息
 */
@property (nonatomic, readonly, copy) NSString *errorMessage;

@end

NS_ASSUME_NONNULL_END
