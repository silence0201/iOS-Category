//
//  SIWarningMacro.h
//  Category
//
//  Created by Silence on 25/02/2017.
//  Copyright © 2017 silence. All rights reserved.
//

//Suppress warning performselector
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

//Suppress warning deprecated
#define SuppressDeprecatedWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

