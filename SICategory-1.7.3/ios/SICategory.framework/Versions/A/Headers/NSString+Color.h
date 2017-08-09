//
//  NSString+Color.h
//  Category
//
//  Created by 杨晴贺 on 13/02/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NSString_Color_HEXADECIMAL_PREFIX                 @"#"
#define NSString_Color_HEXADECIMAL_COLOR_STRING_REGEX     @"[0-9A-Fa-f]{6,8}"

@class UIColor ;

/**
 ##Usage
 
 ##Custom color example
 ```objective-c
 [NSString registerColor:[@"#eeeeee"] withKey:@"descriptionText"]; /// Register a custom color
 [@"descriptionText" representedColor];  // Retrieve a custom color
 [@"dEscRiptIONText" representedColor];  // Custom color names are case insensitive
 
 ```
 
 * FPBrandColors:https://github.com/magtory/FPBrandColors
 ```objective-c
 [@"Facebook" representedColor];                      // UIColor selector name from FPBrandColors
 [@"Github" representedColor];                        // UIColor selector name from FPBrandColors
 ```
 
 * UIColor-FlatColors:https://github.com/mokagio/UIColor-FlatColors
 ```objective-c
 [@"flatEmeraldColor" representedColor];              // UIColor selector name from UIColor-FlatColors
 [@"flatPomegranateColor" representedColor];          // UIColor selector name from UIColor-FlatColors
 ```
 
 * UIColor-CSSColors:https://github.com/mokagio/UIColor-CSSColors
 ```objective-c
 [@"cssBurlywoodColor" representedColor];             // UIColor selector name from UIColor-CSSColors
 [@"cssLightgoldenrodyellowColor" representedColor];  // UIColor selector name from UIColor-CSSColors
 ```

 */

@interface NSString (Color)

/**
    注册自定义颜色

    @param color 颜色
    @param key 颜色Key
 */
+ (void)registerColor:(UIColor *)color withKey:(NSString *)key;

/**
    注册自定义颜色字典

    @param colors 自定义颜色字典
 */
+ (void)registerColors:(NSDictionary *)colors;

/**
    清楚自定义颜色

    @param key 颜色Key
 */
+ (void)clearRegisteredColorForKey:(NSString *)key;

/**
    获取注册的自定义颜色

    @param key 颜色Key
    @return 颜色
 */
+ (UIColor *)registeredColorForKey:(NSString *)key;

/**
    Web颜色

    @param webColorName 颜色Name
    @return 颜色
 */
+ (UIColor *)webColorForKey:(NSString *)webColorName;


/**
    根据RGB获取颜色<br/>
    [@"FFEE55" colorFromRGBcode];     // Hexadecimal code

    @return 颜色
 */
- (UIColor *)colorFromRGBcode;

/**
    根据RGBA获取颜色

    @return 颜色
 */
- (UIColor *)colorFromRGBAcode;

/**
    根据Name获取颜色<br/>
    [@"red" colorFromName];           // UIColor selector name, without color suffix
    [@"redColor" colorFromName];      // UIColor full selector name
    [@"roSyBroWn" colorFromName];     // Web color case insensitive

    @return 颜色
 */
- (UIColor *)colorFromName;

/**
    根据描述获取颜色<br/>
    [@"red" representedColor];        // UIColor selector name without suffix
    [@"redColor" representedColor];   // UIColor full selector name
    [@"#FFEE55" representedColor];    // RGB Hexadecimal code. Prefix with # to force hexadecimal method
    [@"FFEE55" representedColor];     // RGB Hexadecimal code. Will also work, but will be checked through a regex first
    [@"#eeEEEe77" representedColor];  // RGB and RGBA Hexadecimal code are case insensitive too
    [@"roSyBroWn" representedColor];  // Web color case insensitive

    @return 颜色
 */
- (UIColor *)representedColor;

@end
