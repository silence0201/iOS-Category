//
//  NSString+Path.h
//  Category
//
//  Created by Silence on 29/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Path)

/**
 快速返回沙盒中，Documents文件的路径

 @return 文件路径
 */
+ (NSString *)pathForDocuments;

/**
 快速返回沙盒中，Documents文件中某个子文件的路径

 @param fileName 子文件名
 @return 文件路径
 */
+ (NSString *)filePathAtDocumentsWithFileName:(NSString *)fileName;

/**
 快速返回沙盒中，Library下Caches文件的路径

 @return Caches文件的路径
 */
+ (NSString *)pathForCaches;

/**
 快速返回沙盒中，Library下Caches文件中某个子文件的路径

 @param fileName 子文件名
 @return 文件路径
 */
+ (NSString *)filePathAtCachesWithFileName:(NSString *)fileName;


/**
 快速返回沙盒中，MainBundle(资源捆绑包的)的路径

 @return MainBundle(资源捆绑包的)的路径
 */
+ (NSString *)pathForMainBundle;


/**
 快速返回沙盒中，MainBundle(资源捆绑包的)中某个子文件的路径

 @param fileName 文件名
 @return 文件路径
 */
+ (NSString *)filePathAtMainBundleWithFileName:(NSString *)fileName;


/**
 快速返回沙盒中，tmp(临时文件)文件的路径

 @return 临时文件路径
 */
+ (NSString *)pathForTemp;


/**
 快速返回沙盒中，temp文件中某个子文件的路径

 @param fileName 文件名
 @return 文件路径
 */
+ (NSString *)filePathAtTempWithFileName:(NSString *)fileName;


/**
 快速返回沙盒中，Library下Preferences文件的路径

 @return Preferences文件的路径
 */
+ (NSString *)pathForPreferences;


/**
 快速返回沙盒中，Library下Preferences文件中某个子文件的路径

 @param fileName 文件名
 @return 文件路径2
 */
+ (NSString *)filePathAtPreferencesWithFileName:(NSString *)fileName;

/**快速返回沙盒中，你指定的系统文件的路径。tmp文件除外，tmp用系统的NSTemporaryDirectory()函数更加便捷*/
+ (NSString *)pathForSystemFile:(NSSearchPathDirectory)directory;

/**快速返回沙盒中，你指定的系统文件的中某个子文件的路径。tmp文件除外，请使用filePathAtTempWithFileName*/
+ (NSString *)filePathForSystemFile:(NSSearchPathDirectory)directory withFileName:(NSString *)fileName;


@end
