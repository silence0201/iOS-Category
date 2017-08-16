//
//  UIFont+TTF.h
//  Category
//
//  Created by Silence on 2017/3/18.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (TTF)

+ (UIFont *)fontWithTTFAtPath:(NSString *)path size:(CGFloat)size;
+ (UIFont *)fontWithTTFAtURL:(NSURL *)URL size:(CGFloat)size;

@end
