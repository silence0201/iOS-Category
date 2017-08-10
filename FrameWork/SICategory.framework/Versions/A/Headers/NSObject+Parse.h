//
//  NSObject+Parse.h
//  Category
//
//  Created by 杨晴贺 on 19/02/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Parse)

/// 转换为String
- (NSString *)toString;

/// 转换为Number
- (NSNumber *)toNumber;

/// 转化为Dictionary
- (NSDictionary *)toDictionary;

/// 转换为Array
- (NSArray *)toArray;

/// 转换为Array
- (NSArray *)toArrayOf:(Class)itemClass;

@end
