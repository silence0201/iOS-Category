//
//  NSBundle+AppInfo.h
//  Category
//
//  Created by 杨晴贺 on 31/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage ;
@interface NSBundle (AppInfo)

+ (NSString *)bundleName ;
+ (NSString *)bundleIdentifier ;

+ (UInt32)versionNumber ;
+ (NSString *)version ;

- (NSString*)appIconPath ;
- (UIImage*)appIcon ;

+ (NSString *)localizedDisplayName;

@end
