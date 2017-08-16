//
//  NSKeyedArchiver+Key.m
//  Category
//
//  Created by Silence on 31/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "NSKeyedArchiver+Key.h"
#import <objc/runtime.h>

@implementation NSKeyedArchiver (Key)

+ (BOOL)archiveRootObject:(id<NSCoding>)rootObject forKey:(NSString *)key WithFolderPath:(NSString *)path{
    key = [key stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"/"]];
    if (key.length == 0) {
        return NO;
    }
    @try {
        [self _createDirectoryForKey:key WithFloderPath:path];
        return [NSKeyedArchiver archiveRootObject:rootObject
                                           toFile:[self _filePathForKey:key WithFloderPath:path]];
    } @catch (NSException* e) {
        NSLog(@"%s: %@", __PRETTY_FUNCTION__, e);
        return NO;
    }
}

+ (BOOL)archiveRootObject:(id<NSCoding>)rootObject forKey:(NSString *)key{
    return [self archiveRootObject:rootObject forKey:key WithFolderPath:nil] ;
}

+ (BOOL)removeArchiveForKey:(NSString*)key WithFolderPath:(NSString *)path{
    BOOL result = YES;
    NSString* filePath = [self _filePathForKey:key WithFloderPath:path];
    if ([self archiveExistsForKey:key]) {
        NSError* error = nil;
        result = [NSFileManager.defaultManager removeItemAtPath:filePath
                                                          error:&error];
        if (error) {
            NSLog(@"%s: %@", __PRETTY_FUNCTION__, error);
        }
    }
    return result;
}

+ (BOOL)removeArchiveForKey:(NSString *)key{
    return [self removeArchiveForKey:key WithFolderPath:nil] ;
}

+ (BOOL)archiveExistsForKey:(NSString*)key WithFolderPath:(NSString *)path{
    return [NSFileManager.defaultManager fileExistsAtPath:[self _filePathForKey:key WithFloderPath:path]];
}

+ (BOOL)archiveExistsForKey:(NSString *)key{
    return [self archiveExistsForKey:key WithFolderPath:nil] ;
}

+ (NSString*)_filePathForKey:(NSString*)key WithFloderPath:(NSString *)path{
    NSString *filename = [key stringByAppendingPathExtension:@"archive"];
    if (path) {
        return [path stringByAppendingPathComponent:filename] ;
    }
    return [self.defaultPath stringByAppendingPathComponent:filename];
}

+ (void)_createDirectoryForKey:(NSString*)key WithFloderPath:(NSString *)path{
    NSString *dir = [[self _filePathForKey:key WithFloderPath:path] stringByDeletingLastPathComponent];
    if (![NSFileManager.defaultManager fileExistsAtPath:dir]) {
        NSError* error = nil;
        [NSFileManager.defaultManager createDirectoryAtPath:dir
                                withIntermediateDirectories:YES
                                                 attributes:nil
                                                      error:&error];
        if (error) {
            NSLog(@"%s: %@", __PRETTY_FUNCTION__, error);
        }
    }
}

+ (NSString*)defaultPath{
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return [documentPath stringByAppendingPathComponent:@"DefaultArchive"] ;
}

@end
