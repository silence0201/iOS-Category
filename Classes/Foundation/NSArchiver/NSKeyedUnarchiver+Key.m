//
//  NSKeyedUnarchiver+Key.m
//  Category
//
//  Created by Silence on 01/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import "NSKeyedUnarchiver+Key.h"

@implementation NSKeyedUnarchiver (Key)

+ (id)unarchiveObjectForKey:(NSString *)key WithPath:(NSString *)path{
    id object = nil;
    @try {
        object = [NSKeyedUnarchiver unarchiveObjectWithFile:[self _filePathForKey:key WithFloderPath:path]];
    } @catch (NSException* e) {
        NSLog(@"%s: %@", __PRETTY_FUNCTION__, e);
    }
    return object;
}

+ (id)unarchiveObjectForKey:(NSString *)key{
    return [self unarchiveObjectForKey:key WithPath:nil] ;
}

+ (id)unarchiveObjectForKey:(NSString *)key WithPath:(NSString *)path failure:(void (^)(void))failure{
    id obj = [self unarchiveObjectForKey:key WithPath:path] ;
    if (obj == nil) {
        failure();
    }
    return obj;
}

+ (id)unarchiveObjectForKey:(NSString *)key failure:(void (^)(void))failure{
    return [self unarchiveObjectForKey:key WithPath:nil failure:failure] ;
}


+ (NSString*)_filePathForKey:(NSString*)key WithFloderPath:(NSString *)path{
    NSString *filename = [key stringByAppendingPathExtension:@"archive"];
    if (path) {
        return [path stringByAppendingPathComponent:filename] ;
    }
    return [self.defaultPath stringByAppendingPathComponent:filename];
}

+ (NSString*)defaultPath{
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return [documentPath stringByAppendingPathComponent:@"DefaultArchive"] ;
}


@end
