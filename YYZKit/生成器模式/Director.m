
#import "Director.h"

@implementation Director

- (void)construct {
    [_concreteBuilder buildPartOne];
    [_concreteBuilder buildPartTwo];
    [_concreteBuilder buildPartThree];
}

@end
