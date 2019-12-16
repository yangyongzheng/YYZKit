
#import <Foundation/Foundation.h>
#import "Builder.h"

NS_ASSUME_NONNULL_BEGIN

/**
 指导者：抽象对象 构建流程
 */
@interface Director : NSObject

@property (nonatomic, strong) id<Builder> concreteBuilder;

- (void)construct;

@end

NS_ASSUME_NONNULL_END
