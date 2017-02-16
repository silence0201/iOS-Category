//
//  NSKeyedUnarchiver+Key.h
//  Category
//
//  Created by 杨晴贺 on 01/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSKeyedUnarchiver (Key)

/**
 解档对象

 @param key Key
 @param path 自定义路径信息
 @return 解档的对象 
 */
+ (id)unarchiveObjectForKey:(NSString*)key WithPath:(NSString *)path;

/**
 解档对象

 @param key Key
 @return 解档的对象
 */
+ (id)unarchiveObjectForKey:(NSString*)key ;


/**
 解档对象

 @param key Key
 @param path 自定义路径信息
 @param failure 失败的回调
 @return 解档的对象
 */
+ (id)unarchiveObjectForKey:(NSString*)key WithPath:(NSString *)path failure:(void(^)())failure;

/**
 解档对象

 @param key Key
 @param failure 失败的回调
 @return 解档的对象
 */
+ (id)unarchiveObjectForKey:(NSString*)key failure:(void(^)())failure ;


@end
