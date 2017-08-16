//
//  NSBundle+AppInfo.h
//  Category
//
//  Created by Silence on 31/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage ;
@interface NSBundle (AppInfo)

/**
 Bundle Name

 @return BundleName
 */
+ (NSString *)bundleName ;

/**
 Bundle Identifier

 @return BundleIdentifier
 */
+ (NSString *)bundleIdentifier ;

/**
 版本信息

 @return Version String
 */
+ (NSString *)version ;


/**
 Icon路径

 @return icon路径
 */
- (NSString*)appIconPath ;

/**
 app的icon

 @return icon image对象
 */
- (UIImage*)appIcon ;

/**
 Localized Display Name

 @return LocalizedDisplayName
 */
+ (NSString *)localizedDisplayName;

@end
