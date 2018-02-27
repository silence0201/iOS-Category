//
//  NSString+UUID.h
//  Category
//
//  Created by Silence on 29/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AppInfo)

/**
 UUID

 @return UUID String
 */
+ (NSString *)UUID ;


/**
 version 1.0

 @return version
 */
+ (NSString *)appVersion;


/**
 build Version 13

 @return build Version
 */
+ (NSString *)build;


/**
 identifier

 @return identifier
 */
+ (NSString *)identifier;

/**
 displayName
 
 @return displayName
 */
+ (NSString *)displayName;

/**
 currentLanguage

 @return currentLanguage
 */
+ (NSString *)currentLanguage;


/**
 设备信息

 @return 设备信息String
 */
+ (NSString *)deviceModel;

@end
