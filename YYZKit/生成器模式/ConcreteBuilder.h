
#import <Foundation/Foundation.h>
#import "Builder.h"

NS_ASSUME_NONNULL_BEGIN

@class Product;

@interface ConcreteBuilder : NSObject <Builder>

- (Product *)getProduct;

@end

NS_ASSUME_NONNULL_END
