//
//  NSDictionary+URL.h
//  Category
//
//  Created by 杨晴贺 on 31/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (URL)

/// 将url参数转换成NSDictionary
+ (NSDictionary *)dictionaryWithURLQuery:(NSString *)query;
/// 将NSDictionary转换成url参数字符串
- (NSString *)URLQueryString;

@end
