//
//  NSData+Code.h
//  Category
//
//  Created by 杨晴贺 on 30/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Code)

- (NSString *)utf8String;

- (NSString *)hexString;

+ (NSData *)dataWithHexString:(NSString *)hexString;

- (NSString *)base64EncodedString;

+ (NSData *)dataWithBase64EncodedString:(NSString *)base64EncodedString;

- (id)jsonValueDecoded;

@end
