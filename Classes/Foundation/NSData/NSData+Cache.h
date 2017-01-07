//
//  NSData+Cache.h
//  Category
//
//  Created by 杨晴贺 on 31/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Cache)

/** 根据key保存到磁盘里缓存起来 */
- (void)saveDataCacheWithKey:(NSString *)key;

/** 根据key取出缓存data */
+ (NSData *)getDataCacheWithKey:(NSString *)key;

@end
