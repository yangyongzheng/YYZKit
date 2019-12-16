
#import "ConcreteBuilder.h"
#import "Product.h"

@interface ConcreteBuilder ()
@property (nonatomic, strong) Product *product;
@end

@implementation ConcreteBuilder

- (instancetype)init {
    self = [super init];
    if (self) {
        _product = [[Product alloc] init];
    }
    return self;
}

- (void)buildPartOne {
    _product.partOne = @"部件一";
}

- (void)buildPartTwo {
    _product.partTwo = @"部件二";
}

- (void)buildPartThree {
    _product.partThree = @"部件三";
}

- (Product *)getProduct {
    return _product;
}

@end
