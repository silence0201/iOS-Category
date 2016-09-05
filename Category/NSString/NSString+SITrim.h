//
//  NSString+Trim.h
//  Category
//
//  Created by 杨晴贺 on 9/5/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SITrim)

/**
 *  去除字符串的前后空格
 *
 *  @return 处理后的字符串
 */
- (NSString *)si_trim ;

/**
 *  MD5
 *
 *  @return 经MD5处理后的字符串
 */
- (NSString *)si_md5 ;

@end
