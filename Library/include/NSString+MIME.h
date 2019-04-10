//
//  NSString+MIME.h
//  Category
//
//  Created by Silence on 29/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MIME)


/**
 文件名的MIME

 @return MIME
 */
- (NSString *)MIMEType;

/**
 根绝后辍名获取MIME Type

 @param extension 后辍名
 @return MIME
 */
+ (NSString *)MIMETypeForExtension:(NSString *)extension;

/**
 MIMEDict信息

 @return MIMEDict字典
 */
+ (NSDictionary *)MIMEDict;

@end
