
#import "YYZSearchView.h"

@interface YYZPrivateSearchIconView : UIView
@property (nonatomic) UIEdgeInsets contentInsets;
@property (nonatomic, strong) UIColor *searchIconColor;
@end



@interface YYZSearchView () <UITextFieldDelegate>
@property (nonatomic, readonly, strong) UIView *contentView;
@property (nonatomic, readonly, strong) UIView *inputContainer;
@property (nonatomic, readonly, strong) YYZPrivateSearchIconView *searchIconView;
@property (nonatomic, readonly, copy) NSArray *contentViewConstraints; // top, leading, bottom, trailing
@property (nonatomic, readonly, strong) NSLayoutConstraint *cancelButtonTrailing;

@property (nonatomic, weak) UITapGestureRecognizer *focusTap;
@end

@implementation YYZSearchView

- (void)setSearchIconColor:(UIColor *)searchIconColor {
    _searchIconColor = searchIconColor;
    
    self.searchIconView.searchIconColor = searchIconColor;
}

- (void)setInputBackgroundColor:(UIColor *)inputBackgroundColor {
    _inputBackgroundColor = inputBackgroundColor;
    
    self.inputContainer.backgroundColor = inputBackgroundColor;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self yyz_initDefaultInterface];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self yyz_initDefaultInterface];
    }
    return self;
}

- (void)yyz_initDefaultInterface {
    self.backgroundColor = UIColor.whiteColor;
    
    _contentView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:_contentView];
    [self yyz_addConstraintsForContentView];
    _contentView.backgroundColor = UIColor.clearColor;
    _contentView.clipsToBounds = YES;
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_contentView addSubview:_cancelButton];
    [self yyz_addConstraintsForCancelButton];
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelButton setTitleColor:[UIColor colorWithRed:57.0/255.0 green:191.0/255.0 blue:62.0/255.0 alpha:1.0]
                        forState:UIControlStateNormal];
    _cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
    _cancelButton.backgroundColor = UIColor.clearColor;
    [_cancelButton addTarget:self
                      action:@selector(yyz_cancelButtonDidClicked:)
            forControlEvents:UIControlEventTouchUpInside];
    _cancelButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    _cancelButton.hidden = YES;
    _cancelButtonTrailing.constant = [_cancelButton sizeThatFits:CGSizeMake(0, 30)].width;
    
    _inputContainer = [[UIView alloc] initWithFrame:CGRectZero];
    [_contentView addSubview:_inputContainer];
    [self yyz_addConstraintsForInputContainer];
    _inputBackgroundColor = [UIColor colorWithWhite:221.0/255.0 alpha:1.0];
    _inputContainer.backgroundColor = _inputBackgroundColor;
    _inputContainer.layer.cornerRadius = 15;
    _inputContainer.layer.masksToBounds = YES;
    UITapGestureRecognizer *focusTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yyz_focusTapHandler:)];
    [_inputContainer addGestureRecognizer:focusTap];
    self.focusTap = focusTap;
    
    _searchIconView = [[YYZPrivateSearchIconView alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
    [_inputContainer addSubview:_searchIconView];
    [self yyz_addConstraintsForSearchIconView];
    _searchIconColor = [UIColor colorWithWhite:153.0/255.0 alpha:1.0];
    _searchIconView.searchIconColor = _searchIconColor;
    _searchIconView.contentInsets = UIEdgeInsetsMake(0, 0, 1, 1);
    
    _textField = [[UITextField alloc] initWithFrame:CGRectZero];
    [self addSubview:_textField];
    [self yyz_addConstraintsForTextField];
    _textField.backgroundColor = UIColor.clearColor;
    _textField.font = [UIFont systemFontOfSize:14];
    _textField.placeholder = @"请输入关键字";
    _textField.textColor = [UIColor colorWithWhite:34.0/255.0 alpha:1.0];
    _textField.tintColor = [UIColor colorWithRed:57.0/255.0 green:191.0/255.0 blue:62.0/255.0 alpha:1.0];
    _textField.textAlignment = NSTextAlignmentLeft;
    _textField.borderStyle = UITextBorderStyleNone;
    _textField.clearButtonMode = UITextFieldViewModeAlways;
    _textField.returnKeyType = UIReturnKeySearch;
    [_textField addTarget:self
                   action:@selector(yyz_textFieldTextDidChange:)
         forControlEvents:UIControlEventEditingChanged];
    _textField.delegate = self;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchViewShouldBeginEditing:)]) {
        return [self.delegate searchViewShouldBeginEditing:self];
    } else {
        return YES;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.focusTap.enabled = NO;
    self.cancelButton.hidden = NO;
    self.cancelButtonTrailing.constant = 0;
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchViewDidBeginEditing:)]) {
        [self.delegate searchViewDidBeginEditing:self];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    BOOL shouldEndEditing = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchViewShouldEndEditing:)]) {
        shouldEndEditing = [self.delegate searchViewShouldEndEditing:self];
    }
    
    if (shouldEndEditing) {
        self.focusTap.enabled = YES;
        self.cancelButtonTrailing.constant = CGRectGetWidth(self.cancelButton.bounds);
        [UIView animateWithDuration:0.25 animations:^{
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.cancelButton.hidden = YES;
        }];
    }
    
    return shouldEndEditing;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchViewDidEndEditing:)]) {
        [self.delegate searchViewDidEndEditing:self];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchView:shouldChangeCharactersInRange:replacementString:)]) {
        return [self.delegate searchView:self shouldChangeCharactersInRange:range replacementString:string];
    }  else {
        return YES;
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchViewShouldClear:)]) {
        return [self.delegate searchViewShouldClear:self];
    } else {
        return YES;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchViewShouldReturn:)]) {
        return [self.delegate searchViewShouldReturn:self];
    } else {
        return YES;
    }
}

#pragma mark - actions
- (void)yyz_cancelButtonDidClicked:(UIButton *)sender {
    if (self.textField.isFirstResponder) {
        [self.textField resignFirstResponder];
    }
}

- (void)yyz_focusTapHandler:(UITapGestureRecognizer *)tap {
    if (!self.textField.isFirstResponder && self.textField.canBecomeFirstResponder) {
        [self.textField becomeFirstResponder];
    }
}

- (void)yyz_textFieldTextDidChange:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchViewTextDidChange:)]) {
        [self.delegate searchViewTextDidChange:self];
    }
}

#pragma mark - Misc
- (void)yyz_addConstraintsForContentView {
    _contentView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint * (^ LayoutConstraintMakerBlock)(NSLayoutAttribute) =
    ^NSLayoutConstraint *(NSLayoutAttribute attribute) {
        return [NSLayoutConstraint constraintWithItem:self.contentView
                                            attribute:attribute
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:self
                                            attribute:attribute
                                           multiplier:1.0
                                             constant:0];
    };
    NSLayoutConstraint *top = LayoutConstraintMakerBlock(NSLayoutAttributeTop);
    NSLayoutConstraint *leading = LayoutConstraintMakerBlock(NSLayoutAttributeLeading);
    NSLayoutConstraint *bottom = LayoutConstraintMakerBlock(NSLayoutAttributeBottom);
    NSLayoutConstraint *trailing = LayoutConstraintMakerBlock(NSLayoutAttributeTrailing);
    _contentViewConstraints = @[top, leading, bottom, trailing];
    [NSLayoutConstraint activateConstraints:_contentViewConstraints];
}

- (void)yyz_addConstraintsForCancelButton {
    _cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_cancelButton setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [_cancelButton setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    NSLayoutConstraint * (^ LayoutConstraintMakerBlock)(NSLayoutAttribute) =
    ^NSLayoutConstraint *(NSLayoutAttribute attribute) {
        return [NSLayoutConstraint constraintWithItem:self.cancelButton
                                            attribute:attribute
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:self.contentView
                                            attribute:attribute
                                           multiplier:1.0
                                             constant:0];
    };
    NSLayoutConstraint *top = LayoutConstraintMakerBlock(NSLayoutAttributeTop);
    NSLayoutConstraint *bottom = LayoutConstraintMakerBlock(NSLayoutAttributeBottom);
    _cancelButtonTrailing = LayoutConstraintMakerBlock(NSLayoutAttributeTrailing);
    [NSLayoutConstraint activateConstraints:@[top, bottom, _cancelButtonTrailing]];
}

- (void)yyz_addConstraintsForInputContainer {
    _inputContainer.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:_inputContainer
                                                               attribute:NSLayoutAttributeLeading
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:_contentView
                                                               attribute:NSLayoutAttributeLeading
                                                              multiplier:1.0
                                                                constant:0];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:_inputContainer
                                                                attribute:NSLayoutAttributeTrailing
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_cancelButton
                                                                attribute:NSLayoutAttributeLeading
                                                               multiplier:1.0
                                                                 constant:0];
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:_inputContainer
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:_contentView
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1.0
                                                                constant:0];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:_inputContainer
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                             multiplier:1.0
                                                               constant:30];
    [NSLayoutConstraint activateConstraints:@[leading, trailing, centerY, height]];
}

- (void)yyz_addConstraintsForSearchIconView {
    _searchIconView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:_searchIconView
                                                               attribute:NSLayoutAttributeLeading
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:_inputContainer
                                                               attribute:NSLayoutAttributeLeading
                                                              multiplier:1.0
                                                                constant:10];
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:_searchIconView
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:_inputContainer
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1.0
                                                                constant:0];
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:_searchIconView
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                            multiplier:1.0
                                                              constant:16];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:_searchIconView
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                             multiplier:1.0
                                                               constant:16];
    [NSLayoutConstraint activateConstraints:@[leading, centerY, width, height]];
}

- (void)yyz_addConstraintsForTextField {
    _textField.translatesAutoresizingMaskIntoConstraints = NO;
    [_textField setContentHuggingPriority:UILayoutPriorityDefaultLow-1 forAxis:UILayoutConstraintAxisHorizontal];
    [_textField setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh-1 forAxis:UILayoutConstraintAxisHorizontal];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:_textField
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:_inputContainer
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0
                                                            constant:0];
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:_textField
                                                               attribute:NSLayoutAttributeLeading
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:_searchIconView
                                                               attribute:NSLayoutAttributeTrailing
                                                              multiplier:1.0
                                                                constant:6];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:_textField
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:_inputContainer
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0
                                                               constant:0];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:_textField
                                                                attribute:NSLayoutAttributeTrailing
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_inputContainer
                                                                attribute:NSLayoutAttributeTrailing
                                                               multiplier:1.0
                                                                 constant:0];
    [NSLayoutConstraint activateConstraints:@[top, leading, bottom, trailing]];
}

@end



@implementation YYZPrivateSearchIconView

+ (Class)layerClass {
    return [CAShapeLayer class];
}

- (void)layoutSublayersOfLayer:(CALayer *)layer {
    [super layoutSublayersOfLayer:layer];
    [self yyz_refreshIcon];
}

- (void)yyz_refreshIcon {
    static const CGFloat lineWidth = 2;
    CAShapeLayer *iconLayer = (CAShapeLayer *)self.layer;
    iconLayer.strokeColor = self.searchIconColor.CGColor;
    iconLayer.fillColor = nil;
    iconLayer.lineWidth = lineWidth;
    iconLayer.lineCap = kCALineCapRound;
    iconLayer.lineJoin = kCALineJoinRound;
    
    CGFloat width = CGRectGetWidth(self.bounds) - self.contentInsets.left - self.contentInsets.right;
    CGFloat height = CGRectGetHeight(self.bounds) - self.contentInsets.top - self.contentInsets.bottom;
    CGFloat validValue = MIN(width, height);
    CGFloat validDiameter = validValue - lineWidth;
    CGPoint arcCenter = CGPointMake(validValue/2.0+self.contentInsets.left, validValue/2.0+self.contentInsets.top);
    UIBezierPath *iconPath = [UIBezierPath bezierPathWithArcCenter:arcCenter
                                                            radius:validDiameter/2.0
                                                        startAngle:M_PI * 0.25
                                                          endAngle:M_PI * 2.25
                                                         clockwise:YES];
    CGFloat minMargin = MIN(self.contentInsets.right, self.contentInsets.bottom);
    [iconPath addLineToPoint:CGPointMake(self.contentInsets.left+validValue+minMargin-lineWidth/2.0,
                                         self.contentInsets.top+validValue+minMargin-lineWidth/2.0)];
    iconLayer.path = iconPath.CGPath;
}

- (void)setSearchIconColor:(UIColor *)searchIconColor {
    _searchIconColor = searchIconColor;
    
    ((CAShapeLayer *)self.layer).strokeColor = searchIconColor.CGColor;
}

@end
