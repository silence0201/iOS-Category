//
//  NSKeyedArchiver+Key.h
//  Category
//
//  Created by 杨晴贺 on 31/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSKeyedArchiver (Key)

+ (BOOL)archiveRootObject:(id <NSCoding>)rootObject forKey:(NSString*)key WithFolderPath:(NSString *)path ;
+ (BOOL)archiveRootObject:(id <NSCoding>)rootObject forKey:(NSString*)key;

+ (BOOL)removeArchiveForKey:(NSString *)key WithFolderPath:(NSString *)path;
+ (BOOL)removeArchiveForKey:(NSString *)key ;

+ (BOOL)archiveExistsForKey:(NSString *)key WithFolderPath:(NSString *)path;
+ (BOOL)archiveExistsForKey:(NSString *)key ;

@end
