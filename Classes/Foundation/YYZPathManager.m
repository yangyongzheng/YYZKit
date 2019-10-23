
#import "YYZPathManager.h"

static NSString * const YYZUserCustomDataDirectory = @"YYZUserCustomData";

static NSString * YYZDirectoryAppendSubdirectory(NSString *directory, NSString *subdirectory) {
    NSString *fullPath = [directory stringByAppendingPathComponent:subdirectory];
    BOOL isDirectory = NO;
    if ([NSFileManager.defaultManager fileExistsAtPath:fullPath isDirectory:&isDirectory] && isDirectory) {} else {
        [NSFileManager.defaultManager createDirectoryAtPath:fullPath
                                withIntermediateDirectories:YES
                                                 attributes:nil
                                                      error:nil];
    }
    return fullPath;
}

NSString * YYZUserDocumentDirectory() {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    return YYZDirectoryAppendSubdirectory(path, YYZUserCustomDataDirectory);
}

NSString * YYZUserLibraryDirectory() {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
    return YYZDirectoryAppendSubdirectory(path, YYZUserCustomDataDirectory);
}

NSString * YYZUserCachesDirectory() {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    return YYZDirectoryAppendSubdirectory(path, YYZUserCustomDataDirectory);
}

NSString * YYZUserTemporaryDirectory() {
    NSString *path = NSTemporaryDirectory();
    return YYZDirectoryAppendSubdirectory(path, YYZUserCustomDataDirectory);
}
