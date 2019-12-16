//
//  NSLayoutConstraint+YYZAdditional.h
//  YYZKit
//
//  Created by 杨永正 on 2019/12/13.
//  Copyright © 2019 yoger. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define YYZConstraintFirstPart id view1, NSLayoutAttribute attr1
#define YYZConstraintSecondPart id _Nullable view2, NSLayoutAttribute attr2

typedef NSLayoutConstraint *(^YYZLayoutConstraintMakerBlock)(YYZConstraintFirstPart, NSLayoutRelation relation, YYZConstraintSecondPart, CGFloat multiplier, CGFloat constant);
typedef NSLayoutConstraint *(^YYZLayoutConstraintLiteMakerBlock)(YYZConstraintFirstPart, YYZConstraintSecondPart, CGFloat constant);


@interface NSLayoutConstraint (YYZAdditional)

@property (class, nonatomic, readonly) YYZLayoutConstraintMakerBlock yyz_constraintMaker;
@property (class, nonatomic, readonly) YYZLayoutConstraintLiteMakerBlock yyz_constraintLiteMaker;

@end

NS_ASSUME_NONNULL_END
