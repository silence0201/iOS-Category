//
//  NSObject+QuickCode.m
//  Category
//
//  Created by Silence on 30/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "NSObject+QuickCode.h"
#import <objc/runtime.h>

@implementation NSObject (QuickCode)

- (id)quickCoderWith:(NSCoder *)aDecoder{
    if (self) {
        unsigned int outCount;
        Ivar * ivars = class_copyIvarList([self class], &outCount);
        for (int i = 0; i < outCount; i ++) {
            Ivar ivar = ivars[i];
            NSString * key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];
        }
    }
    return self ;
}

- (void)quickEncodeWithCoder:(NSCoder *)aCoder{
    unsigned int outCount;
    Ivar * ivars = class_copyIvarList([self class], &outCount);
    for (int i = 0; i < outCount; i ++) {
        Ivar ivar = ivars[i];
        NSString * key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
}

@end
