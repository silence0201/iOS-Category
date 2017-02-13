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
    根据RGB获取颜色

    @return 颜色
 */
- (UIColor *)colorFromRGBcode;

/**
    根据RGBA获取颜色

    @return 颜色
 */
- (UIColor *)colorFromRGBAcode;

/**
    根据Name获取颜色

    @return 颜色
 */
- (UIColor *)colorFromName;

/**
    根据描述获取颜色

    @return 颜色
 */
- (UIColor *)representedColor;

@end
