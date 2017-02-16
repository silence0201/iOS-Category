//
//  NSDictionary+Plist.h
//  Category
//
//  Created by 杨晴贺 on 31/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDictionary (Plist)

/// 根据Plist数据初始化字典
+ (instancetype)dictionaryWithPlistData:(NSData *)plist;
/// 根绝Plist String初始化字典
+ (instancetype)dictionaryWithPlistString:(NSString *)plist;

/// Plist 数据信息
- (NSData *)plistData;
/// Plist String
- (NSString *)plistString;

@end
