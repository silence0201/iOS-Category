//
//  NSString+URLEncode.h
//  Category
//
//  Created by Silence on 29/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLEncode)

/**
 urlEncode

 @return urlEncode
 */
- (NSString *)urlEncode;

/**
 urlEncodeUsingEncoding

 @param encoding Encoding
 @return urlEncodeUsingEncoding
 */
- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding;


/**
 urlDecode

 @return urlDecode
 */
- (NSString *)urlDecode;

/**
 urlDecodeUsingEncoding

 @param encoding Encoding
 @return urlDecodeUsingEncoding
 */
- (NSString *)urlDecodeUsingEncoding:(NSStringEncoding)encoding;


/**
 参数字典

 @return 参数字典
 */
- (NSDictionary *)dictionaryFromURLParameters;

@end
