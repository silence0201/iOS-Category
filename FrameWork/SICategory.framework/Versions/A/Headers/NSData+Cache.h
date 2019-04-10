//
//  NSData+Cache.h
//  Category
//
//  Created by Silence on 31/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Cache)

/**
 根据key保存到磁盘里缓存起来

 @param key Key
 */
- (void)saveDataCacheWithKey:(NSString *)key;


/**
 根据key取出缓存data

 @param key Key
 @return 对象数据
 */
+ (NSData *)getDataCacheWithKey:(NSString *)key;

@end
