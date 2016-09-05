//
//  NSArray+Log.m
//  Category
//
//  Created by 杨晴贺 on 9/2/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "NSArray+Log.h"

@implementation NSArray (Log)

/**
 *  重新描述describtion方法
 *
 *
 *  @return 重新生成的descrip
 */
- (NSString *)descriptionWithLocale:(id)locale{
    NSMutableString *str = [NSMutableString string];
    
    [str appendString:@"[\n"];
    
    // 遍历数组的所有元素
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [str appendFormat:@"%@,\n", obj];
    }];
    
    [str appendString:@"]"];
    
    // 查出最后一个,的范围
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length) {
        // 删掉最后一个,
        [str deleteCharactersInRange:range];
    }
    
    return str;
}

@end
