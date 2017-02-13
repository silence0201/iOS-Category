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

+ (void)registerColor:(UIColor *)color withKey:(NSString *)key;
+ (void)registerColors:(NSDictionary *)colors;
+ (void)clearRegisteredColorForKey:(NSString *)key;
+ (UIColor *)registeredColorForKey:(NSString *)key;
+ (UIColor *)webColorForKey:(NSString *)webColorName;

- (UIColor *)colorFromRGBcode;
- (UIColor *)colorFromRGBAcode;
- (UIColor *)colorFromName;

- (UIColor *)representedColor;

@end
