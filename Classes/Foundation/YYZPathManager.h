
#import "YYZKitDefines.h"

NS_ASSUME_NONNULL_BEGIN

/*
 .
 ├── Documents
 │   └── YYZUserCustomData
 ├── Library
 │   ├── Caches
 │   │   └── YYZUserCustomData
 │   ├── Preferences
 │   └── YYZUserCustomData
 ├── SystemData
 └── tmp
     └── YYZUserCustomData
 */

YYZKIT_EXTERN NSString * YYZUserDocumentDirectory(void);    // Documents/YYZUserCustomData

YYZKIT_EXTERN NSString * YYZUserLibraryDirectory(void);     // Library/YYZUserCustomData

YYZKIT_EXTERN NSString * YYZUserCachesDirectory(void);      // Library/Caches/YYZUserCustomData

YYZKIT_EXTERN NSString * YYZUserTemporaryDirectory(void);   // tmp/YYZUserCustomData

NS_ASSUME_NONNULL_END
