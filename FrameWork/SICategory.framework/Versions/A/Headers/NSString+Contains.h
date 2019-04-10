//
//  NSString+Contains.h
//  Category
//
//  Created by Silence on 29/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Contains)

/**是否包含中文*/
- (BOOL)isContainChinese;

/**是否包含空格*/
- (BOOL)isContainBlank;

/**是否包含set*/
- (BOOL)containsCharacterSet:(NSCharacterSet *)set;

/**是否包含String*/
- (BOOL)containsString:(NSString *)string;

/**字符数量*/
- (int)wordsCount;

@end
