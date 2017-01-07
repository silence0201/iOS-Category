//
//  NSArray+Plist.h
//  Category
//
//  Created by 杨晴贺 on 31/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Plist)

+ (instancetype)arrayWithPlistData:(NSData *)plist;
+ (instancetype)arrayWithPlistString:(NSString *)plist;

- (NSData *)plistData;
- (NSString *)plistString;

@end

@interface NSMutableArray (Plist)

+ (instancetype)arrayWithPlistData:(NSData *)plist;
+ (instancetype)arrayWithPlistString:(NSString *)plist;

@end
