
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (YYZGZIP)

/**
 根据压缩级别压缩数据
 
 @param level 压缩级别，取值范围0...9。系统已定义的压缩级别宏：Z_NO_COMPRESSION、Z_BEST_SPEED、Z_BEST_COMPRESSION、Z_DEFAULT_COMPRESSION。
 @return 压缩后数据
 */
- (nullable NSData *)yyz_gzipDataWithCompressionLevel:(int)level;

/** 根据默认压缩级别压缩数据 */
- (nullable NSData *)yyz_gzipData;

/** 解压数据 */
- (nullable NSData *)yyz_gunzipData;

/**
 检查是否已经GZIP压缩
 
 @return YES-已压缩，NO-未压缩
 */
- (BOOL)yyz_isGzipData;

@end

NS_ASSUME_NONNULL_END
