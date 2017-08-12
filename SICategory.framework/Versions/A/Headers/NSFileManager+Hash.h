//
//  NSFileManager+Hash.h
//  Category
//
//  Created by 杨晴贺 on 12/02/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Hash)


/**
    指定路径文件的MD5值

    @param filePath 文件路径
    @return 文件MD5
 */
+ (NSString *)md5HashOfFileAtPath:(NSString *)filePath;


/**
    指定路径文件的SHA1值

    @param filePath 文件路径
    @return 文件SHA1
 */
+ (NSString *)sha1HashOfFileAtPath:(NSString *)filePath;


/**
    指定路径文件的SHA512值

    @param filePath 文件路径
    @return 文件SHA512
 */
+ (NSString *)sha512HashOfFileAtPath:(NSString *)filePath;

@end
