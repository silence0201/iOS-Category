//
//  NSString+Path.m
//  Category
//
//  Created by Silence on 29/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "NSString+Path.h"

@implementation NSString (Path)

/**快速返回沙盒中，Documents文件的路径*/
+ (NSString *)pathForDocuments{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

/**快速返回Documents文件中某个子文件的路径*/
+ (NSString *)filePathAtDocumentsWithFileName:(NSString *)fileName{
    return  [[self pathForDocuments] stringByAppendingPathComponent:fileName];
}

/**快速返回沙盒中Library下Caches文件的路径*/
+ (NSString *)pathForCaches{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)filePathAtCachesWithFileName:(NSString *)fileName{
    return [[self pathForCaches] stringByAppendingPathComponent:fileName];
}

/**快速返回MainBundle(资源捆绑包的)的路径*/
+ (NSString *)pathForMainBundle{
    return [NSBundle mainBundle].bundlePath;
}

/**快速返回MainBundle(资源捆绑包的)下文件的路径*/
+ (NSString *)filePathAtMainBundleWithFileName:(NSString *)fileName{
    return [[self pathForMainBundle] stringByAppendingPathComponent:fileName];
}

/**快速返回沙盒中tmp(临时文件)文件的路径*/
+ (NSString *)pathForTemp{
    return NSTemporaryDirectory();
}

/**快速返回沙盒中，temp文件中某个子文件的路径*/
+ (NSString *)filePathAtTempWithFileName:(NSString *)fileName{
    return [[self pathForTemp] stringByAppendingPathComponent:fileName];
}

/**快速返回沙盒中，Library下Preferences文件的路径*/
+ (NSString *)pathForPreferences{
    return [NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES) lastObject];
}

/**快速返回沙盒中，Library下Preferences文件中某个子文件的路径*/
+ (NSString *)filePathAtPreferencesWithFileName:(NSString *)fileName{
    return [[self pathForPreferences] stringByAppendingPathComponent:fileName];
}

/**快速你指定的系统文件的路径*/
+ (NSString *)pathForSystemFile:(NSSearchPathDirectory)directory{
    return [NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES) lastObject];
}

/**快速返回沙盒中，你指定的系统文件的中某个子文件的路径。tmp文件除外，请使用filePathAtTempWithFileName*/
+ (NSString *)filePathForSystemFile:(NSSearchPathDirectory)directory withFileName:(NSString *)fileName{
    return [[self pathForSystemFile:directory] stringByAppendingPathComponent:fileName];
}

@end
