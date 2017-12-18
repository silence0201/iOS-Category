//
//  NSString+Append.m
//  Category
//
//  Created by Silence on 2017/12/18.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "NSString+Append.h"

@implementation NSString (Append)

- (NSString *)appendHomePath {
    NSString *home = NSHomeDirectory();
    return [home stringByAppendingString:self];
}

- (NSString *)appendDocumentPath {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return [documentPath stringByAppendingString:self];
}

- (NSString *)appendCachePath {
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    return [cachePath stringByAppendingString:self];
}

- (NSString *)appendMainBundlePath {
    NSString *mainBundlePath = [NSBundle mainBundle].bundlePath;
    return [mainBundlePath stringByAppendingString:self];
}

- (NSString *)appendTempPath {
    NSString *tempPath = NSTemporaryDirectory() ;
    return [tempPath stringByAppendingString:self];
}

- (NSString *)appendPreferencesPath {
    NSString *preferencesPath = [NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES) lastObject];
    return [preferencesPath stringByAppendingString:self];
}

@end
