//
//  NSLayoutConstraint+YYZAdditional.m
//  YYZKit
//
//  Created by 杨永正 on 2019/12/13.
//  Copyright © 2019 yoger. All rights reserved.
//

#import "NSLayoutConstraint+YYZAdditional.h"

@implementation NSLayoutConstraint (YYZAdditional)

+ (YYZLayoutConstraintMakerBlock)yyz_constraintMaker {
    return ^id(YYZConstraintFirstPart, NSLayoutRelation relation, YYZConstraintSecondPart, CGFloat multiplier, CGFloat constant) {
        return [NSLayoutConstraint constraintWithItem:view1
                                            attribute:attr1
                                            relatedBy:relation
                                               toItem:view2
                                            attribute:attr2
                                           multiplier:multiplier
                                             constant:constant];
    };
}

+ (YYZLayoutConstraintLiteMakerBlock)yyz_constraintLiteMaker {
    return ^id(YYZConstraintFirstPart, YYZConstraintSecondPart, CGFloat constant) {
        return [NSLayoutConstraint constraintWithItem:view1
                                            attribute:attr1
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:view2
                                            attribute:attr2
                                           multiplier:1.0
                                             constant:constant];
    };
}

@end
