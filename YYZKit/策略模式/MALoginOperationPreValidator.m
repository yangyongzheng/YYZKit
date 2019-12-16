//
//  MALoginOperationPreValidator.m
//  YYZKit
//
//  Created by 杨永正 on 2019/12/3.
//  Copyright © 2019 yoger. All rights reserved.
//

#import "MALoginOperationPreValidator.h"

@implementation MALoginOperationPreValidator

@synthesize errorMessage = _errorMessage;

- (BOOL)validateOperation {
    _errorMessage = nil;
    if (!self.mobile) {
        _errorMessage = @"请输入手机号码";
    } else if (self.mobile.length != 11) {
        _errorMessage = @"输入的手机号码错误";
    } else if (!self.smsCode.length && self.password.length < 6) {
        _errorMessage = @"请输入验证码或密码";
    }
    
    return !_errorMessage;
}

@end
