//
//  NSDictionary+Plist.m
//  Category
//
//  Created by 杨晴贺 on 31/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "NSDictionary+Plist.h"

@implementation NSDictionary (Plist)

+ (instancetype)dictionaryWithPlistData:(NSData *)plist{
    if (!plist) return nil;
    NSDictionary *dictionary = [NSPropertyListSerialization propertyListWithData:plist options:NSPropertyListImmutable format:NULL error:NULL];
    if ([dictionary isKindOfClass:[NSDictionary class]]) return dictionary;
    return nil;
}

+ (instancetype)dictionaryWithPlistString:(NSString *)plist{
    if (!plist) return nil;
    NSData *data = [plist dataUsingEncoding:NSUTF8StringEncoding];
    return [self dictionaryWithPlistData:data];
}

- (NSData *)plistData{
    return [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListBinaryFormat_v1_0 options:kNilOptions error:NULL];
}

- (NSString *)plistString{
    NSData *xmlData = [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListXMLFormat_v1_0 options:kNilOptions error:NULL];
    if (xmlData) return [[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
    return nil;
}

@end
