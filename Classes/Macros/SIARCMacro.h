//
//  SIARCMacros.h
//  Category
//
//  Created by 杨晴贺 on 16/02/2017.
//  Copyright © 2017 silence. All rights reserved.
//

// Warc-performSelector-leaks警告
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

// 强弱引用
#define WeakSelf          __weak __typeof(self) weakSelf = self;
#define StrongSelf        __strong __typeof(weakSelf)strongSelf = weakSelf;
