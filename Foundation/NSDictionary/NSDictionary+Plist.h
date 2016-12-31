//
//  NSDictionary+Plist.h
//  Category
//
//  Created by 杨晴贺 on 31/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Plist)


+ (instancetype)dictionaryWithPlistData:(NSData *)plist;
+ (instancetype)dictionaryWithPlistString:(NSString *)plist;

- (NSData *)plistData;
- (NSString *)plistString;

@end
