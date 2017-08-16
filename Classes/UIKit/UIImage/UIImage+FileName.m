//
//  UIImage+FileName.m
//  Category
//
//  Created by Silence on 2017/3/28.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "UIImage+FileName.h"

@implementation UIImage (FileName)

+ (UIImage *)imageWithFileName:(NSString *)name {
    return [self imageWithFileName:name inBundle:[NSBundle mainBundle]];
}
+ (UIImage *)imageWithFileName:(NSString *)name inBundle:(NSBundle*)bundle{
    NSString *extension = @"png";
    NSArray *components = [name componentsSeparatedByString:@"."];
    if ([components count] >= 2) {
        NSUInteger lastIndex = components.count - 1;
        extension = [components objectAtIndex:lastIndex];
        name = [name substringToIndex:(name.length-(extension.length+1))];
    }
    // 如果为Retina屏幕且存在对应图片，则返回Retina图片，否则查找普通图片
    if ([UIScreen mainScreen].scale == 2.0) {
        name = [name stringByAppendingString:@"@2x"];
        
        NSString *path = [bundle pathForResource:name ofType:extension];
        if (path != nil) {
            return [UIImage imageWithContentsOfFile:path];
        }
    }
    if ([UIScreen mainScreen].scale == 3.0) {
        name = [name stringByAppendingString:@"@3x"];
        
        NSString *path = [bundle pathForResource:name ofType:extension];
        if (path != nil) {
            return [UIImage imageWithContentsOfFile:path];
        }
    }
    NSString *path = [bundle pathForResource:name ofType:extension];
    if (path) {
        return [UIImage imageWithContentsOfFile:path];
    }
    return nil;
}


@end
