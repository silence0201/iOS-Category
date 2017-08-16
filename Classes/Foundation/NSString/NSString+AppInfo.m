//
//  NSString+UUID.m
//  Category
//
//  Created by Silence on 29/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "NSString+AppInfo.h"
#import <sys/utsname.h>

@implementation NSString (AppInfo)

+ (NSString *)UUID{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuid = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    return (__bridge_transfer NSString *)uuid;
}

+ (NSString *)version{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_Version;
}

+ (NSString *)build{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    return app_build ;
}

+ (NSString *)identifier{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString * bundleIdentifier = [infoDictionary objectForKey:@"CFBundleIdentifier"];
    return bundleIdentifier;
}

+ (NSString *)currentLanguage{
    return [[NSLocale preferredLanguages] firstObject];
}

+ (NSString *)deviceModel{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return deviceString;
}


@end
