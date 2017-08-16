//
//  NSBundle+AppInfo.m
//  Category
//
//  Created by Silence on 31/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "NSBundle+AppInfo.h"
#import <UIKit/UIKit.h>

@implementation NSBundle (AppInfo)

+ (NSString*)bundleName{
    static NSString* bundleName;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bundleName = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
    });
    
    return bundleName;
}

+ (NSString*)bundleIdentifier{
    static NSString* bundleIdentifier;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bundleIdentifier = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleIdentifierKey];
    });
    
    return bundleIdentifier;
}

+ (NSString*)version{
    CFStringRef ver = CFBundleGetValueForInfoDictionaryKey(CFBundleGetMainBundle(), kCFBundleVersionKey);
    return (__bridge_transfer NSString*)ver;
}

- (NSString*)appIconPath{
    NSString* iconFilename = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIconFile"] ;
    NSString* iconBasename = [iconFilename stringByDeletingPathExtension] ;
    NSString* iconExtension = [iconFilename pathExtension] ;
    
    return [[NSBundle mainBundle] pathForResource:iconBasename ofType:iconExtension];
}

- (UIImage*)appIcon{
    UIImage*appIcon = [[UIImage alloc] initWithContentsOfFile:[self appIconPath]] ;
    return appIcon;
}

+ (NSString *)localizedDisplayName{
    NSString * appName = [[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:@"CFBundleDisplayName"];
    if (!appName) {
        appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    }
    if (!appName) {
        appName = @"";
    }
    return appName;
}

@end
