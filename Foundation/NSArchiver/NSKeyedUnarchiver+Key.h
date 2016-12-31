//
//  NSKeyedUnarchiver+Key.h
//  Category
//
//  Created by 杨晴贺 on 01/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSKeyedUnarchiver (Key)

+ (id)unarchiveObjectForKey:(NSString*)key WithPath:(NSString *)path;
+ (id)unarchiveObjectForKey:(NSString*)key ;

+ (id)unarchiveObjectForKey:(NSString*)key WithPath:(NSString *)path failure:(void(^)())failure;
+ (id)unarchiveObjectForKey:(NSString*)key failure:(void(^)())failure ;


@end
