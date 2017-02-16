//
//  NSArray+JSONEncode.h
//  Category
//
//  Created by 杨晴贺 on 31/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (JSONEncode)

/**
 转换为JSON

 @return JSON Sting
 */
- (NSString *)jsonStringEncoded;

/**
 返回格式化后JSON

 @return 格式化后的JSON String
 */
- (NSString *)jsonPrettyStringEncoded;

@end
