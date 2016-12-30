//
//  NSData+Hash.h
//  Category
//
//  Created by 杨晴贺 on 30/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Hash)

- (NSString *)md2String;
- (NSData *)md2Data;

- (NSString *)md4String;
- (NSData *)md4Data;

- (NSString *)md5String;
- (NSData *)md5Data;

- (NSString *)sha1String;
- (NSData *)sha1Data;

- (NSString *)sha224String;
- (NSData *)sha224Data;

- (NSString *)sha256String;
- (NSData *)sha256Data;

- (NSString *)sha384String;
- (NSData *)sha384Data;

- (NSString *)sha512String;
- (NSData *)sha512Data;

- (NSString *)hmacMD5StringWithKey:(NSString *)key;
- (NSData *)hmacMD5DataWithKey:(NSData *)key;

- (NSString *)hmacSHA1StringWithKey:(NSString *)key;
- (NSData *)hmacSHA1DataWithKey:(NSData *)key;

- (NSString *)hmacSHA224StringWithKey:(NSString *)key;
- (NSData *)hmacSHA224DataWithKey:(NSData *)key;

- (NSString *)hmacSHA256StringWithKey:(NSString *)key;
- (NSData *)hmacSHA256DataWithKey:(NSData *)key;

- (NSString *)hmacSHA384StringWithKey:(NSString *)key;
- (NSData *)hmacSHA384DataWithKey:(NSData *)key;

- (NSString *)hmacSHA512StringWithKey:(NSString *)key;
- (NSData *)hmacSHA512DataWithKey:(NSData *)key;

@end
