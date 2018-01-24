//
//  NSString+AES.h
//  Category
//
//  Created by Silence on 2017/11/15.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AES)

///  加密方法
- (NSString *)encryptWithAESwithKey:(NSString *)key ivParameter:(NSString *)ivParameter;

/// 解密方法
- (NSString*)decryptWithAESwithKey:(NSString *)key ivParameter:(NSString *)ivParameter;


@end
