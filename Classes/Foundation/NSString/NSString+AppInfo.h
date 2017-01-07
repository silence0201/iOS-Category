//
//  NSString+UUID.h
//  Category
//
//  Created by 杨晴贺 on 29/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AppInfo)

+ (NSString *)UUID ;

+ (NSString *)version;

+ (NSString *)build;

+ (NSString *)identifier;

+ (NSString *)currentLanguage;

+ (NSString *)deviceModel;

@end
