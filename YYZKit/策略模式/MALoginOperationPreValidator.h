//
//  策略模式
//  登录操作预验证方法类
//

#import "OperationPreValidator.h"

NS_ASSUME_NONNULL_BEGIN

@interface MALoginOperationPreValidator : OperationPreValidator
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *smsCode;
@property (nonatomic, copy) NSString *password;
@end

NS_ASSUME_NONNULL_END
