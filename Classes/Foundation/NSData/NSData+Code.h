//
//  NSData+Code.h
//  Category
//
//  Created by 杨晴贺 on 30/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Code)

/**
 UTF8 String

 @return UTF8String
 */
- (NSString *)utf8String;

/**
 hexString

 @return hex String
 */
- (NSString *)hexString;


/**
 Data WithHexString

 @param hexString hexString
 @return Data
 */
+ (NSData *)dataWithHexString:(NSString *)hexString;


/**
 base64 EncodedString

 @return base64EncodedString
 */
- (NSString *)base64EncodedString;


/**
 Data With Base64EncodedString

 @param base64EncodedString base64 EncodedString
 @return Data
 */
+ (NSData *)dataWithBase64EncodedString:(NSString *)base64EncodedString;


/**
 JSON编译

 @return 对象
 */
- (id)jsonValueDecoded;

@end
