//
//  NSData+Hash.h
//  Category
//
//  Created by Silence on 30/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Hash)

/// md2String
- (NSString *)md2String;
/// md2Data
- (NSData *)md2Data;

/// md4String
- (NSString *)md4String;
/// md4Data
- (NSData *)md4Data;

/// md5String
- (NSString *)md5String;
/// md5Data
- (NSData *)md5Data;

/// sha1String
- (NSString *)sha1String;
/// sha1Data
- (NSData *)sha1Data;

/// sha224String
- (NSString *)sha224String;
/// sha224Data
- (NSData *)sha224Data;

/// sha256String
- (NSString *)sha256String;
/// sha256Data
- (NSData *)sha256Data;

/// sha384String
- (NSString *)sha384String;
/// sha384Data
- (NSData *)sha384Data;

/// sha512String
- (NSString *)sha512String;
/// sha512Data
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
