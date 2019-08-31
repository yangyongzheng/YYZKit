
#import "NSString+YYZAdditions.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (YYZAdditions)

- (NSString *)yyz_MD5Encryption {
    const char *cString = self.UTF8String;
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cString, (CC_LONG)strlen(cString), digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02X", digest[i]];
    }
    
    return [output copy];
}

@end
