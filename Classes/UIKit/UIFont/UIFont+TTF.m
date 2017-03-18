//
//  UIFont+TTF.m
//  Category
//
//  Created by 杨晴贺 on 2017/3/18.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "UIFont+TTF.h"
#import <CoreText/CoreText.h>

@implementation UIFont (TTF)

+ (UIFont *)fontWithTTFAtURL:(NSURL *)URL size:(CGFloat)size{
    BOOL isLocalFile = [URL isFileURL];
    NSAssert(isLocalFile, @"TTF files may only be loaded from local file paths. Remote files must first be cached locally, this category does not handle such cases natively.\n\nIf, however, the provided URL is indeed a reference to a local file.\n\n1. Ensure it was created via a method such as [NSURL fileURLWithPath:] and NOT [NSURL URLWithString:].\n\n2. Ensure the URL returns YES to isFileURL.");
    if (!isLocalFile) {
        return [UIFont systemFontOfSize:size];
    }
    return [UIFont fontWithTTFAtPath:URL.path size:size];
}

+ (UIFont *)fontWithTTFAtPath:(NSString *)path size:(CGFloat)size{
    BOOL foundFile = [[NSFileManager defaultManager] fileExistsAtPath:path];
    NSAssert(foundFile, @"The font at: \"%@\" was not found.", path);
    if (!foundFile) {
        return [UIFont systemFontOfSize:size];
    }
    
    CFURLRef fontURL = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, (__bridge CFStringRef)path, kCFURLPOSIXPathStyle, false);;
    CGDataProviderRef dataProvider = CGDataProviderCreateWithURL(fontURL);
    CFRelease(fontURL);
    CGFontRef graphicsFont = CGFontCreateWithDataProvider(dataProvider);
    CFRelease(dataProvider);
    CTFontRef smallFont = CTFontCreateWithGraphicsFont(graphicsFont, size, NULL, NULL);
    CFRelease(graphicsFont);
    
    UIFont *returnFont = (__bridge UIFont *)smallFont;
    CFRelease(smallFont);
    
    return returnFont;
}


@end
