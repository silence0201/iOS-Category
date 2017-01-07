//
//  UIApplication+AppInfo.m
//  Category
//
//  Created by 杨晴贺 on 01/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import "UIApplication+AppInfo.h"

@implementation UIApplication (AppInfo)

- (NSString *)appName{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
}

- (NSString *)appVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

- (NSString *)appBuild{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}
- (NSString *)appBundleID{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

- (int)documentsFolderSizeInBytes{
    NSString *folderPath = [self documentPath] ;
    unsigned long long int folderSize = [self sizeOfFolder:folderPath] ;
    return (int)folderSize;
}

- (NSString *)documentsFolderSizeAsString{
    NSString *folderPath = [self documentPath] ;
    unsigned long long int folderSize = [self sizeOfFolder:folderPath];
    NSString *folderSizeStr = [NSByteCountFormatter stringFromByteCount:folderSize countStyle:NSByteCountFormatterCountStyleFile];
    return folderSizeStr;
}

- (int)cacheFolderSizeInBytes{
    NSString *folderPath = [self cachePath] ;
    unsigned long long int folderSize = [self sizeOfFolder:folderPath] ;
    return (int)folderSize;
}

- (NSString *)cacheFolderSizeAsString{
    NSString *folderPath = [self cachePath] ;
    unsigned long long int folderSize = [self sizeOfFolder:folderPath];
    NSString *folderSizeStr = [NSByteCountFormatter stringFromByteCount:folderSize countStyle:NSByteCountFormatterCountStyleFile];
    return folderSizeStr;
}

- (int)applicationSizeSizeInBytes{
    NSString *folderPath = [self documentPath] ;
    unsigned long long int folderSize = [self sizeOfFolder:folderPath] ;
    return (int)folderSize;
}

- (NSString *)libraryFolderSizeAsString{
    NSString *folderPath = [self libraryPath] ;
    unsigned long long int folderSize = [self sizeOfFolder:folderPath];
    NSString *folderSizeStr = [NSByteCountFormatter stringFromByteCount:folderSize countStyle:NSByteCountFormatterCountStyleFile];
    return folderSizeStr;
}

- (int)libraryFolderSizeInBytes{
    NSString *folderPath = [self libraryPath] ;
    unsigned long long int folderSize = [self sizeOfFolder:folderPath] ;
    return (int)folderSize;
}

- (NSString *)applicationSizeAsString{
    unsigned long long docSize   =  [self sizeOfFolder:[self documentPath]];
    unsigned long long libSize   =  [self sizeOfFolder:[self libraryPath]];
    unsigned long long cacheSize =  [self sizeOfFolder:[self cachePath]];
    unsigned long long total = docSize + libSize + cacheSize;
    NSString *folderSizeStr = [NSByteCountFormatter stringFromByteCount:total countStyle:NSByteCountFormatterCountStyleFile];
    return folderSizeStr;
}



- (NSString *)documentPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = [paths firstObject];
    return basePath;
}

- (NSString *)libraryPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *basePath = [paths firstObject];
    return basePath;
}

- (NSString *)cachePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *basePath = [paths firstObject];
    return basePath;
}

-(unsigned long long)sizeOfFolder:(NSString *)folderPath{
    NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:folderPath error:nil];
    NSEnumerator *contentsEnumurator = [contents objectEnumerator];
    NSString *file;
    unsigned long long folderSize = 0;
    while (file = [contentsEnumurator nextObject]) {
        NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:[folderPath stringByAppendingPathComponent:file] error:nil];
        folderSize += [[fileAttributes objectForKey:NSFileSize] intValue];
    }
    return folderSize;
}


+ (BOOL)isAppExtension {
    static BOOL isAppExtension = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = NSClassFromString(@"UIApplication");
        if(!cls || ![cls respondsToSelector:@selector(sharedApplication)]) isAppExtension = YES;
        if ([[[NSBundle mainBundle] bundlePath] hasSuffix:@".appex"]) isAppExtension = YES;
    });
    return isAppExtension;
}

+ (UIApplication *)sharedExtensionApplication {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    return [self isAppExtension] ? nil : [UIApplication performSelector:@selector(sharedApplication)];
#pragma clang diagnostic pop
}

@end
